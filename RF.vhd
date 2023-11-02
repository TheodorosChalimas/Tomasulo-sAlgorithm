
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RF is
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
end RF;

architecture Behavioral of RF is
---------------------------------COMPONENTS
	component	Register37 is 
	Port (Clk : in  STD_LOGIC;
         Rst : in  STD_LOGIC;
			--FROM RF
			Datain :in STD_LOGIC_VECTOR (31 downto 0);
			WrEn : in  STD_LOGIC;
			--TO RF
         Data: out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	component DEMUX32 is
	Port ( R : in  std_logic_vector (4 downto 0);
           writeMux_out0 : out  std_logic;
			  writeMux_out1 : out  std_logic;
			  writeMux_out2 : out  std_logic;
			  writeMux_out3 : out  std_logic;
			  writeMux_out4 : out  std_logic;
			  writeMux_out5 : out  std_logic;
			  writeMux_out6 : out  std_logic;
			  writeMux_out7 : out  std_logic;
			  writeMux_out8 : out  std_logic; 
			  writeMux_out9 : out  std_logic;
			  writeMux_out10 : out  std_logic;
			  writeMux_out11 : out  std_logic;
			  writeMux_out12 : out  std_logic;
			  writeMux_out13 : out  std_logic;
			  writeMux_out14 : out  std_logic;
			  writeMux_out15 : out  std_logic;
			  writeMux_out16 : out  std_logic;
			  writeMux_out17 : out  std_logic;
			  writeMux_out18 : out  std_logic;
			  writeMux_out19 : out  std_logic;
			  writeMux_out20 : out  std_logic;
			  writeMux_out21 : out  std_logic;
			  writeMux_out22 : out  std_logic;
			  writeMux_out23 : out  std_logic;
			  writeMux_out24 : out  std_logic;
			  writeMux_out25 : out  std_logic;
			  writeMux_out26 : out  std_logic;
			  writeMux_out27 : out  std_logic;
			  writeMux_out28 : out  std_logic;
			  writeMux_out29 : out  std_logic;
			  writeMux_out30 : out  std_logic;
			  writeMux_out31 : out  std_logic);
	end component;
	
	component MUX32bit_32to1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In4 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In5 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In6 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In7 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In8 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In9 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In10 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In11 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In12 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In13 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In14 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In15 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In16 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In17 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In18 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In19 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In20 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In21 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In22 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In23 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In24 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In25 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In26 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In27 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In28 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In29 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In30 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mout : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (4 downto 0));
end component;
-----------------------------STATES
	type State is (StRst,StA,StB);
	signal CrntState, NxtState: State;
---------------------------------SIGNALS
	signal SigVj,SigVk : std_logic_vector(31 downto 0);
	signal SigSel : std_logic_vector(4 downto 0);
	--
	signal SigMux0,SigMux1,SigMux2,SigMux3,SigMux4,SigMux5,SigMux6,SigMux7,SigMux8,SigMux9,SigMux10,SigMux11,SigMux12,SigMux13,SigMux14,SigMux15,SigMux16,SigMux17,SigMux18,SigMux19,SigMux20,SigMux21,SigMux22,SigMux23,SigMux24,SigMux25,SigMux26,SigMux27,SigMux28,SigMux29,SigMux30,SigMux31 :  std_logic;
	signal SigMuxj0,SigMuxj1,SigMuxj2,SigMuxj3,SigMuxj4,SigMuxj5,SigMuxj6,SigMuxj7,SigMuxj8,SigMuxj9,SigMuxj10,SigMuxj11,SigMuxj12,SigMuxj13,SigMuxj14,SigMuxj15,SigMuxj16,SigMuxj17,SigMuxj18,SigMuxj19,SigMuxj20,SigMuxj21,SigMuxj22,SigMuxj23,SigMuxj24,SigMuxj25,SigMuxj26,SigMuxj27,SigMuxj28,SigMuxj29,SigMuxj30,SigMuxj31 :  std_logic_vector (31 downto 0);
	
	constant DEFAULT1 :std_logic_vector(31 downto 0):= "00000000000000000000000000000001";
	constant DEFAULT2 :std_logic_vector(31 downto 0):= "00000000000000000000000000000010";
begin
----------------------------------------------------PORT MAPS
	
	Reg0: Register37
	port map 
		(WrEn => SigMux0, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj0);
	Reg1: Register37
	port map 
		(WrEn => '1', 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => DEFAULT1,
		 Data => SigMuxj1);
	Reg2: Register37
	port map 
		(WrEn => '1', 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => DEFAULT2,
		 Data => SigMuxj2);
	Reg3: Register37
	port map 
		(WrEn => SigMux3, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj3);
	Reg4: Register37
	port map 
		(WrEn => SigMux4, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj4);
	Reg5: Register37
	port map 
		(WrEn => SigMux5, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj5);
	Reg6: Register37
	port map 
		(WrEn => SigMux6, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj6);
	Reg7: Register37
	port map 
		(WrEn => SigMux7, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj7);
	Reg8: Register37
	port map 
		(WrEn => SigMux8, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj8);
	Reg9: Register37
	port map 
		(WrEn => SigMux9, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj9);
	Reg10: Register37
	port map 
		(WrEn => SigMux10, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj10);
	Reg11: Register37
	port map 
		(WrEn => SigMux11, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj11);
	Reg12: Register37
	port map 
		(WrEn => SigMux12, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj12);
	Reg13: Register37
	port map 
		(WrEn => SigMux13, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj13);
	Reg14: Register37
	port map 
		(WrEn => SigMux14, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj14);
	Reg15: Register37
	port map 
		(WrEn => SigMux15, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj15);
	Reg16: Register37
	port map 
		(WrEn => SigMux16, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj16);
	Reg17: Register37
	port map 
		(WrEn => SigMux17, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj17);
	Reg18: Register37
	port map 
		(WrEn => SigMux18, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj18);
	Reg19: Register37
	port map 
		(WrEn => SigMux19, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj19);
	Reg20: Register37
	port map 
		(WrEn => SigMux20, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj20);
	Reg21: Register37
	port map 
		(WrEn => SigMux21, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj21);
	Reg22: Register37
	port map 
		(WrEn => SigMux22, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj22);
	Reg23: Register37
	port map 
		(WrEn => SigMux23, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj23);
	Reg24: Register37
	port map 
		(WrEn => SigMux24, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj24);
	Reg25: Register37
	port map 
		(WrEn => SigMux25, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj25);
	Reg26: Register37
	port map 
		(WrEn => SigMux26, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj26);
	Reg27: Register37
	port map 
		(WrEn => SigMux27, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj27);
	Reg28: Register37
	port map 
		(WrEn => SigMux28, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj28);
	Reg29: Register37
	port map 
		(WrEn => SigMux29, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj29);
	Reg30: Register37
	port map 
		(WrEn => SigMux30, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj30);
	Reg31: Register37
	port map 
		(WrEn => SigMux31, 
		 Rst => Rst, 
		 Clk => Clk, 
		 Datain => Data,
		 Data => SigMuxj31);
	------------------------------------------MUXES
	Muxj: MUX32bit_32to1
	port map
			 (In0 => SigMuxj0,
			  In1 => SigMuxj1,
			  In2 => SigMuxj2,
			  In3 => SigMuxj3,
			  In4 => SigMuxj4,
			  In5 => SigMuxj5,
			  In6 => SigMuxj6,
			  In7 => SigMuxj7,
			  In8 => SigMuxj8,
			  In9 => SigMuxj9,
			  In10 => SigMuxj10,
			  In11 => SigMuxj11,
			  In12 => SigMuxj12,
			  In13 => SigMuxj13,
			  In14 => SigMuxj14,
			  In15 => SigMuxj15,
			  In16 => SigMuxj16,
			  In17 => SigMuxj17,
			  In18 => SigMuxj18,
			  In19 => SigMuxj19,
			  In20 => SigMuxj20,
			  In21 => SigMuxj21,
			  In22 => SigMuxj22,
			  In23 => SigMuxj23,
			  In24 => SigMuxj24,
			  In25 => SigMuxj25,
			  In26 => SigMuxj26,
			  In27 => SigMuxj27,
			  In28 => SigMuxj28,
			  In29 => SigMuxj29,
			  In30 => SigMuxj30,
			  In31 => SigMuxj31,
           Mout =>SigVj,
           sel => Rj);
		 
	Muxk: MUX32bit_32to1
	port map
			 (In0 => SigMuxj0,
			  In1 => SigMuxj1,
			  In2 => SigMuxj2,
			  In3 => SigMuxj3,
			  In4 => SigMuxj4,
			  In5 => SigMuxj5,
			  In6 => SigMuxj6,
			  In7 => SigMuxj7,
			  In8 => SigMuxj8,
			  In9 => SigMuxj9,
			  In10 => SigMuxj10,
			  In11 => SigMuxj11,
			  In12 => SigMuxj12,
			  In13 => SigMuxj13,
			  In14 => SigMuxj14,
			  In15 => SigMuxj15,
			  In16 => SigMuxj16,
			  In17 => SigMuxj17,
			  In18 => SigMuxj18,
			  In19 => SigMuxj19,
			  In20 => SigMuxj20,
			  In21 => SigMuxj21,
			  In22 => SigMuxj22,
			  In23 => SigMuxj23,
			  In24 => SigMuxj24,
			  In25 => SigMuxj25,
			  In26 => SigMuxj26,
			  In27 => SigMuxj27,
			  In28 => SigMuxj28,
			  In29 => SigMuxj29,
			  In30 => SigMuxj30,
			  In31 => SigMuxj31,
			  Mout => SigVk,
           sel => Rk);

	Vj <= SigVj;
	Vk <= SigVk;
	
	
	Demux: DEMUX32
	port map
			( R => Ri,
           writeMux_out0 => SigMux0,
			  writeMux_out1 => SigMux1,
			  writeMux_out2 => SigMux2,
			  writeMux_out3 => SigMux3,
			  writeMux_out4 => SigMux4,
			  writeMux_out5 => SigMux5,
			  writeMux_out6 => SigMux6,
			  writeMux_out7 => SigMux7,
			  writeMux_out8 => SigMux8,
			  writeMux_out9 => SigMux9,
			  writeMux_out10 => SigMux10,
			  writeMux_out11 => SigMux11,
			  writeMux_out12 => SigMux12,
			  writeMux_out13 => SigMux13,
			  writeMux_out14 => SigMux14,
			  writeMux_out15 => SigMux15,
			  writeMux_out16 => SigMux16,
			  writeMux_out17 => SigMux17,
			  writeMux_out18 => SigMux18,
			  writeMux_out19 => SigMux19,
			  writeMux_out20 => SigMux20,
			  writeMux_out21 => SigMux21,
			  writeMux_out22 => SigMux22,
			  writeMux_out23 => SigMux23,
			  writeMux_out24 => SigMux24,
			  writeMux_out25 => SigMux25,
			  writeMux_out26 => SigMux26,
			  writeMux_out27 => SigMux27,
			  writeMux_out28 => SigMux28,
			  writeMux_out29 => SigMux29,
			  writeMux_out30 => SigMux30,
			  writeMux_out31 => SigMux31);
	-----------------
--process
--	begin
--		wait until Clk'event and Clk ='1';
--
--		if(Rst = '1') then
--			SigSel <= "00000";
--		else
--				SigSel <= Ri;
--		end if;
--	end process;



	-----------------------------------------------------
end Behavioral;

