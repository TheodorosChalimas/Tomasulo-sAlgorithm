
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RoBToP is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM ISSUE
           Rj : in  STD_LOGIC_VECTOR (4 downto 0);
           Rk : in  STD_LOGIC_VECTOR (4 downto 0);
			  Ri : in  STD_LOGIC_VECTOR (4 downto 0);
			  WrEn : in  STD_LOGIC;
			  --FROM CDB
			  CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
			  CDBData : in  STD_LOGIC_VECTOR (31 downto 0);
			  ---------------------------------OUTPUTS
			  --TO ISSUE 
			  Full : out STD_LOGIC;
			  --TO RS
			  --RsReq : out  std_logic;
			  RoBS : out  std_logic;
			  TAG : out  STD_LOGIC_VECTOR (4 downto 0);
           Vj : out  STD_LOGIC_VECTOR (31 downto 0);
           Vk : out  STD_LOGIC_VECTOR (31 downto 0);
           Qj : out  STD_LOGIC_VECTOR (4 downto 0);
           Qk : out  STD_LOGIC_VECTOR (4 downto 0));
end RoBToP;


architecture Behavioral of RoBToP is

component Reorder_Buffer is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RFnote
           Rj : in  STD_LOGIC_VECTOR (4 downto 0);
           Rk : in  STD_LOGIC_VECTOR (4 downto 0);
			  --FROM ISSUE
			  Ri : in  STD_LOGIC_VECTOR (4 downto 0);
			  WrEn : in  STD_LOGIC;
			  --FROM CDB
			  CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
			  CDBData : in  STD_LOGIC_VECTOR (31 downto 0);

			  ---------------------------------OUTPUTS
			  --TO ISSUE 
			  Full : out STD_LOGIC;
			  --TO RS
			  Ready1 : out  STD_LOGIC;
			  Ready2 : out  STD_LOGIC;
			  Vj : out  STD_LOGIC_VECTOR (31 downto 0);
			  Vk : out  STD_LOGIC_VECTOR (31 downto 0);
			  --TO RFnote//RF
			  RoBTail : out  STD_LOGIC_VECTOR (4 downto 0);
           RoBHead : out  STD_LOGIC_VECTOR (4 downto 0);
			  RF_WrEn : out  STD_LOGIC;
           RF_Ri: out STD_LOGIC_VECTOR (4 downto 0);
			  RF_Data : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component RFnote is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM ISSUE
           Rj : in  STD_LOGIC_VECTOR (4 downto 0);
           Rk : in  STD_LOGIC_VECTOR (4 downto 0);
			  Ri : in  STD_LOGIC_VECTOR (4 downto 0);
			  WrEn : in  STD_LOGIC;
			  --FROM RoB
			  RoBTail : in  STD_LOGIC_VECTOR (4 downto 0);
           RoBHead : in  STD_LOGIC_VECTOR (4 downto 0);
			  RF_WrEn : in  STD_LOGIC;
           RF_Ri: in  STD_LOGIC_VECTOR (4 downto 0);
			  ---------------------------------OUTPUTS
			  --TO RS//RoB
           Qj : out  STD_LOGIC_VECTOR (4 downto 0);
           Qk : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component RF is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM ISSUE
           Rj : in  STD_LOGIC_VECTOR (4 downto 0);
           Rk : in  STD_LOGIC_VECTOR (4 downto 0);
			 
			  --FROM RoB
           WrEn : in  STD_LOGIC;
			  Ri : in  STD_LOGIC_VECTOR (4 downto 0);
			  Data : in  STD_LOGIC_VECTOR (31 downto 0);
			  ---------------------------------OUTPUTS
			  --TO RS
           Vj : out  STD_LOGIC_VECTOR (31 downto 0);
           Vk : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_2to1_5 is
    Port ( Clk : in std_logic;
			  In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           Data : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component MUX_2to1_32 is
    Port ( Clk : in std_logic;
			  In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           Data : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
SIGNAL SigVjRob,SigVkRob,SigVj,SigVk,SigRF_Data,VjNew,VkNew: STD_LOGIC_VECTOR (31 downto 0);
SIGNAL SigQj,SigQk,SigRoBTail,SigRoBHead,SigRF_Ri : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL SigReady1,SigReady2,SigRF_WrEn: STD_LOGIC;

begin


   RoB: Reorder_Buffer 
	PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rj => SigQj,
          Rk => SigQk,
          Ri => Ri,
          WrEn => WrEn,
          CDBQ => CDBQ,
          CDBData => CDBData,
			 Full => Full,
			 Ready1 => SigReady1,
			 Ready2 => SigReady2,
			 --FROM ROB
			 Vj => SigVjRob,
			 Vk => SigVkRob,
          RoBTail => SigRoBTail,
          RoBHead => SigRoBHead,
          RF_WrEn => SigRF_WrEn,
          RF_Ri => SigRF_Ri,
          RF_Data => SigRF_Data
        );


   RFN: RFnote 
	PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rj => Rj,
          Rk => Rk,
          Ri => Ri,
          WrEn => WrEn,
          RoBTail => SigRoBTail,
          RoBHead => SigRoBHead,
          RF_WrEn => SigRF_WrEn,
          RF_Ri => SigRF_Ri,
			 
          Qj => SigQj,
          Qk => SigQk
        );

   RegFile: RF 
	PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rj => Rj,
          Rk => Rk,
          WrEn => SigRF_WrEn,
          Ri => SigRF_Ri,
          Data => SigRF_Data,
			 
          Vj => SigVj,
          Vk => SigVk
        );

	mux32A: MUX_2to1_32
	Port MAP ( 
		  Clk  => Clk,
		  In0 => SigVj,
		  In1 => SigVjRoB,
		  sel => SigReady1,
		  Data => Vj--New
		  );

	mux32B: MUX_2to1_32
	Port MAP ( 
		  Clk  => Clk,
		  In0 => SigVk,
		  In1 => SigVkRoB,
		  sel => SigReady2,
		  Data => Vk--New
		  );

	mux5A: MUX_2to1_5
	Port MAP ( 
		  Clk  => Clk,
		  In0 => SigQj,
		  In1 => "00000",
		  sel => SigReady1,
		  Data => Qj 
		  );

	mux5B: MUX_2to1_5
	Port MAP ( 
		  Clk  => Clk,
		  In0 => SigQk,
		  In1 => "00000",
		  sel => SigReady2,
		  Data => Qk
		  );

--process 
--begin
--wait until Clk'Event And Clk='1';
--	---------------------------------RESSET
--
--	 if ( SigVjRoB = "00000000000000000000000000000000" and VjNew /= "00000000000000000000000000000000") then 
--	 Vj <= VjNew;
--	 end if;	
--	 if (SigVkRoB = "00000000000000000000000000000000" and VkNew /= "00000000000000000000000000000000") then 
--	 Vk <= VkNew;
--	 end if;
--
--end process;

TAG <= SigRoBTail;

RoBS <= SigReady1 or SigReady2;
end Behavioral;

