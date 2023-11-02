
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ReservatioStationLogic is
    Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM RoB
			   RoBTaG : in  STD_LOGIC_VECTOR (4 downto 0);
				VjIn : in  STD_LOGIC_VECTOR (31 downto 0);
				VkIn : in  STD_LOGIC_VECTOR (31 downto 0);
				Qj : in  STD_LOGIC_VECTOR (4 downto 0);
				Qk : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM CDB
				CDBData : in  STD_LOGIC_VECTOR (31 downto 0);
				CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM LOCAL CONTROL
				RegRes : in std_logic_vector(1 downto 0);
				OpIn : in  STD_LOGIC_VECTOR (1 downto 0);
				WrEn : in  std_logic_vector(1 downto 0);
				RegSel : in  std_logic_vector(1 downto 0);
				---------------------------------OUTPUTS
				--TO FU
				OpOut : out  STD_LOGIC_VECTOR (1 downto 0);
				VjOut : out  STD_LOGIC_VECTOR (31 downto 0);
				VkOut : out  STD_LOGIC_VECTOR (31 downto 0);
				TAG : out  STD_LOGIC_VECTOR (4 downto 0);
				--TO LOCAL CONTROL
				RE : out std_logic_vector(1 downto 0);
				BU : out std_logic_vector(1 downto 0));
end ReservatioStationLogic;


architecture Behavioral of ReservatioStationLogic is
---------------------------------COMPONENTS
	component RSReg is 
	Port (WrEn : in  STD_LOGIC;
         Rst : in  STD_LOGIC;
         Clk : in  STD_LOGIC;
         DataIn : in  STD_LOGIC_VECTOR (75 downto 0);
         DataOut : out  STD_LOGIC_VECTOR (75 downto 0);
			Update: in std_logic;
			UpData: in std_logic_vector(73 downto 0);
			TAGin: in std_logic_vector(4 downto 0);
			TAGout: out std_logic_vector(4 downto 0));
	end component;
---------------------------------SIGNALS
	signal Sig0Op,Sig1Op : std_logic_vector(1 downto 0);
	signal RESig,BUSig : std_logic_vector(1 downto 0);
	signal Sig0Vj,Sig1Vj,Sig0Vk,Sig1Vk : std_logic_vector(31 downto 0);
	signal Sig0Qj,Sig1Qj,Sig0Qk,Sig1Qk : std_logic_vector(4 downto 0);
	signal SigTAGout1,SigTAGout2 : std_logic_vector(4 downto 0);
	--
	signal Update : std_logic_vector(1 downto 0);
	signal Sig0UpData,Sig1UpData : std_logic_vector(73 downto 0);

begin
---------------------------------PORT MAPS
	Reg0: RSReg
	port map 
		(WrEn => WrEn(0), 
		 Rst => RegRes(0), 
		 Clk => Clk, 
		 DataIn(75 downto 74) => OpIn,
		 DataIn(73 downto 69) => Qj,
		 DataIn(68 downto 37) => VjIn,
		 DataIn(36 downto 32) => Qk,
		 DataIn(31 downto  0) => VkIn,
		 --
		 Update=>Update(0),
		 UpData=>Sig0UpData,
		 --
		  --
		 TAGin => RoBTaG,
		 TAGout => SigTAGout1,
		 --
		 DataOut(75 downto 74) => Sig0Op,
		 DataOut(73 downto 69) => Sig0Qj,
		 DataOut(68 downto 37) => Sig0Vj,
		 DataOut(36 downto 32) => Sig0Qk,
		 DataOut(31 downto  0) => Sig0Vk
		);
	
	Reg1: RSReg
	port map 
		(WrEn => WrEn(1), 
		 Rst => RegRes(1), 
		 Clk => Clk, 
		 DataIn(75 downto 74) => OpIn,
		 DataIn(73 downto 69) => Qj,
		 DataIn(68 downto 37) => VjIn,
		 DataIn(36 downto 32) => Qk,
		 DataIn(31 downto  0) => VkIn,
		 --
		 Update=>Update(1),
		 UpData=>Sig1UpData,
		 --
		 --
		 TAGin => RoBTaG,
		 TAGout => SigTAGout2,
		 --
		 DataOut(75 downto 74) => Sig1Op,
		 DataOut(73 downto 69) => Sig1Qj,
		 DataOut(68 downto 37) => Sig1Vj,
		 DataOut(36 downto 32) => Sig1Qk,
		 DataOut(31 downto  0) => Sig1Vk
		);
	
---------------------------------PROCESS FOR ALU
	process
	begin
	
	wait until Clk'Event And Clk='1';
	---------------------------------RESSET
	 if (rst = '1') then
		 BUSig <= "00";
		 RESig <= "00";
		 OpOut <= "11";
		 VjOut <= "00000000000000000000000000000000";
		 VkOut <= "00000000000000000000000000000000";
	else
		---------------------------------BUSY/READY
		if (WrEn = "01") then
			BUSig(0) <='1';
		elsif (WrEn = "10") then 
			BUSig(1)<= '1';
		end if;
		
		if(Sig0Qj = "00000" and Sig0Qk = "00000") then
			RESig(0) <= '1';
		else
			RESig(0) <= '0';
		end if;
		if(Sig1Qj = "00000" and Sig1Qk = "00000") then
			RESig(1) <= '1';
		else
			RESig(1) <= '0';
		end if;
	
	--------------------------------------OUT TO ALU
		----------------------REGISTER0
		if (RegSel = "01" ) then
			TAG <= SigTAGout1;
			BUSig(0) <='0';
			RESig(0) <= '0';
			OpOut <= Sig0Op;
			VjOut <= Sig0Vj;
			VkOut <= Sig0Vk;
		
		----------------------REGISTER1
		elsif (RegSel = "10" )then
			TAG <= SigTAGout2;
			BUSig(1) <='0';
			RESig(1) <= '0';
			OpOut <= Sig1Op;
			VjOut <= Sig1Vj;
			VkOut <= Sig1Vk;
		else 
			null;
		end if;
	end if;
	
	
	end process;
	BU <= BUSig;
	RE <= RESig;
	
---------------------------------PROCESS FOR CDB
	process
	begin
	wait until clk'event and clk = '1';
	
			----------------------REGISTER0
		--FROM CDB
			if(CDBQ = Sig0Qj and CDBQ = Sig0Qk  ) then 
				Update(0) <= '1';
				Sig0UpData <= "00000" & CDBData & "00000" & CDBData;
			elsif(CDBQ /= Sig0Qj and CDBQ = Sig0Qk  ) then 
				Update(0) <= '1';
				Sig0UpData <= Sig0Qj & Sig0Vj & "00000" & CDBData;
			elsif(CDBQ = Sig0Qj and CDBQ /= Sig0Qk ) then
				Update(0) <= '1';
				Sig0UpData <= "00000" & CDBData & Sig0Qk & Sig0Vk;
			else 
				Update(0) <= '0';
			end if;
		----------------------REGISTER1	
					--FROM CDB
			if(CDBQ = Sig1Qj and CDBQ = Sig1Qk  ) then 
				Update(1) <= '1';
				Sig1UpData <= "00000" & CDBData & "00000" & CDBData;
			elsif(CDBQ /= Sig1Qj and CDBQ = Sig1Qk ) then 
				Update(1) <= '1';
				Sig1UpData <= Sig1Qj & Sig1Vj & "00000" & CDBData;
			elsif(CDBQ = Sig1Qj and CDBQ /= Sig1Qk ) then
				Update(1) <= '1';
				Sig1UpData <= "00000" & CDBData & Sig1Qk & Sig1Vk;
			else 
				Update(1) <= '0';
			end if;
	end process;

end Behavioral;

