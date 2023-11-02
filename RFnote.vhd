library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RFnote is
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
end RFnote;

architecture Behavioral of RFnote is
---------------------------------COMPONENTS
	component RegisterNote is 
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RF_Note
			  RoBAdd : in STD_LOGIC_VECTOR (4 downto 0);
			  WrEn : in  STD_LOGIC;
			  ---------------------------------OUTPUTS
			  --TO RF_Note
           Data: out  STD_LOGIC_VECTOR (4 downto 0));
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
		
		component MUX5bit_32to1 is
		 Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In1 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In2 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In3 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In4 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In5 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In6 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In7 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In8 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In9 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In10 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In11 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In12 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In13 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In14 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In15 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In16 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In17 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In18 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In19 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In20 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In21 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In22 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In23 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In24 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In25 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In26 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In27 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In28 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In29 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In30 : in  STD_LOGIC_VECTOR (4 downto 0);
				  In31 : in  STD_LOGIC_VECTOR (4 downto 0);
				  Mout : out  STD_LOGIC_VECTOR (4 downto 0);
				  sel : in  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	
	-----------------------------STATES
	type State is (StRst,StA,StB);
	signal CrntState, NxtState: State;
---------------------------------SIGNALS
	signal SigVj,SigVk : std_logic_vector(4 downto 0);
	signal SigQj,SigQk,SigSel,SigTAG,RSTSig : std_logic_vector(4 downto 0);
	--
	signal SigMux0,SigMux1,SigMux2,SigMux3,SigMux4,SigMux5,SigMux6,SigMux7,SigMux8,SigMux9,SigMux10,SigMux11,SigMux12,SigMux13,SigMux14,SigMux15,SigMux16,SigMux17,SigMux18,SigMux19,SigMux20,SigMux21,SigMux22,SigMux23,SigMux24,SigMux25,SigMux26,SigMux27,SigMux28,SigMux29,SigMux30,SigMux31 :  std_logic;
	signal RST_Mux0,RST_Mux1,RST_Mux2,RST_Mux3,RST_Mux4,RST_Mux5,RST_Mux6,RST_Mux7,RST_Mux8,RST_Mux9,RST_Mux10,RST_Mux11,RST_Mux12,RST_Mux13,RST_Mux14,RST_Mux15,RST_Mux16,RST_Mux17,RST_Mux18,RST_Mux19,RST_Mux20,RST_Mux21,RST_Mux22,RST_Mux23,RST_Mux24,RST_Mux25,RST_Mux26,RST_Mux27,RST_Mux28,RST_Mux29,RST_Mux30,RST_Mux31 :  std_logic;
	signal SigMuxj0,SigMuxj1,SigMuxj2,SigMuxj3,SigMuxj4,SigMuxj5,SigMuxj6,SigMuxj7,SigMuxj8,SigMuxj9,SigMuxj10,SigMuxj11,SigMuxj12,SigMuxj13,SigMuxj14,SigMuxj15,SigMuxj16,SigMuxj17,SigMuxj18,SigMuxj19,SigMuxj20,SigMuxj21,SigMuxj22,SigMuxj23,SigMuxj24,SigMuxj25,SigMuxj26,SigMuxj27,SigMuxj28,SigMuxj29,SigMuxj30,SigMuxj31 :  std_logic_vector (4 downto 0);
	
begin
	Reg0: RegisterNote
	port map 
		(WrEn => SigMux0, 
		 Rst => RST_Mux0, 
		 Clk => Clk, 
		 RoBAdd => "00000",
		 Data => SigMuxj0);
	Reg1: RegisterNote
	port map 
		(WrEn => '1', 
		 Rst => RST_Mux1, 
		 Clk => Clk, 
		 RoBAdd => "00000",
		 Data => SigMuxj1);
	Reg2: RegisterNote
	port map 
		(WrEn => '1', 
		 Rst => RST_Mux2, 
		 Clk => Clk, 
		 RoBAdd => "00000",
		 Data => SigMuxj2);
	Reg3: RegisterNote
	port map 
		(WrEn => SigMux3, 
		 Rst => RST_Mux3, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj3);
	Reg4: RegisterNote
	port map 
		(WrEn => SigMux4, 
		 Rst => RST_Mux4, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj4);
	Reg5: RegisterNote
	port map 
		(WrEn => SigMux5, 
		 Rst => RST_Mux5, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj5);
	Reg6: RegisterNote
	port map 
		(WrEn => SigMux6, 
		 Rst => RST_Mux6, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj6);
	Reg7: RegisterNote
	port map 
		(WrEn => SigMux7, 
		 Rst => RST_Mux7, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj7);
	Reg8: RegisterNote
	port map 
		(WrEn => SigMux8, 
		 Rst => RST_Mux8, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj8);
	Reg9: RegisterNote
	port map 
		(WrEn => SigMux9, 
		 Rst => RST_Mux9, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj9);
	Reg10: RegisterNote
	port map 
		(WrEn => SigMux10, 
		 Rst => RST_Mux10, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj10);
	Reg11: RegisterNote
	port map 
		(WrEn => SigMux11, 
		 Rst => RST_Mux11, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj11);
	Reg12: RegisterNote
	port map 
		(WrEn => SigMux12, 
		 Rst => RST_Mux12, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj12);
	Reg13: RegisterNote
	port map 
		(WrEn => SigMux13, 
		 Rst => RST_Mux13, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj13);
	Reg14: RegisterNote
	port map 
		(WrEn => SigMux14, 
		 Rst => RST_Mux14, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj14);
	Reg15: RegisterNote
	port map 
		(WrEn => SigMux15, 
		 Rst => RST_Mux15, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj15);
	Reg16: RegisterNote
	port map 
		(WrEn => SigMux16, 
		 Rst => RST_Mux16, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj16);
	Reg17: RegisterNote
	port map 
		(WrEn => SigMux17, 
		 Rst => RST_Mux17, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj17);
	Reg18: RegisterNote
	port map 
		(WrEn => SigMux18, 
		 Rst => RST_Mux18, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj18);
	Reg19: RegisterNote
	port map 
		(WrEn => SigMux19, 
		 Rst => RST_Mux19, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj19);
	Reg20: RegisterNote
	port map 
		(WrEn => SigMux20, 
		 Rst => RST_Mux20, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj20);
	Reg21: RegisterNote
	port map 
		(WrEn => SigMux21, 
		 Rst => RST_Mux21, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj21);
	Reg22: RegisterNote
	port map 
		(WrEn => SigMux22, 
		 Rst => RST_Mux22, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj22);
	Reg23: RegisterNote
	port map 
		(WrEn => SigMux23, 
		 Rst => RST_Mux23, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj23);
	Reg24: RegisterNote
	port map 
		(WrEn => SigMux24, 
		 Rst => RST_Mux24, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj24);
	Reg25: RegisterNote
	port map 
		(WrEn => SigMux25, 
		 Rst => RST_Mux25, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj25);
	Reg26: RegisterNote
	port map 
		(WrEn => SigMux26, 
		 Rst => RST_Mux26, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj26);
	Reg27: RegisterNote
	port map 
		(WrEn => SigMux27, 
		 Rst => RST_Mux27, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj27);
	Reg28: RegisterNote
	port map 
		(WrEn => SigMux28, 
		 Rst => RST_Mux28, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj28);
	Reg29: RegisterNote
	port map 
		(WrEn => SigMux29, 
		 Rst => RST_Mux29, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj29);
	Reg30: RegisterNote
	port map 
		(WrEn => SigMux30, 
		 Rst => RST_Mux30, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj30);
	Reg31: RegisterNote
	port map 
		(WrEn => SigMux31, 
		 Rst => RST_Mux31, 
		 Clk => Clk, 
		 RoBAdd => RoBTail,
		 Data => SigMuxj31);
	------------------------------------------MUXES
	Muxj: MUX5bit_32to1
	port map
			 (In0 => "00000",
			  In1 => "00000",
			  In2 => "00000",
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
			  Mout(4 downto 0) => SigQj,
           sel => Rj);
Qj <= SigQj;

	Muxk: MUX5bit_32to1
	port map
			 (In0 => "00000",
			  In1 => "00000",
			  In2 => "00000",
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
			  Mout(4 downto 0) => SigQk,
           sel => Rk);


	Qk <= SigQk;
	-----------------
	
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
			  
----------------------------------RESET DEMUX
	DemuxRst: DEMUX32
	port map
			( R => RSTSig,
           writeMux_out0 => RST_Mux0,
			  writeMux_out1 => RST_Mux1,
			  writeMux_out2 => RST_Mux2,
			  writeMux_out3 => RST_Mux3,
			  writeMux_out4 => RST_Mux4,
			  writeMux_out5 => RST_Mux5,
			  writeMux_out6 => RST_Mux6,
			  writeMux_out7 => RST_Mux7,
			  writeMux_out8 => RST_Mux8,
			  writeMux_out9 => RST_Mux9,
			  writeMux_out10 => RST_Mux10,
			  writeMux_out11 => RST_Mux11,
			  writeMux_out12 => RST_Mux12,
			  writeMux_out13 => RST_Mux13,
			  writeMux_out14 => RST_Mux14,
			  writeMux_out15 => RST_Mux15,
			  writeMux_out16 => RST_Mux16,
			  writeMux_out17 => RST_Mux17,
			  writeMux_out18 => RST_Mux18,
			  writeMux_out19 => RST_Mux19,
			  writeMux_out20 => RST_Mux20,
			  writeMux_out21 => RST_Mux21,
			  writeMux_out22 => RST_Mux22,
			  writeMux_out23 => RST_Mux23,
			  writeMux_out24 => RST_Mux24,
			  writeMux_out25 => RST_Mux25,
			  writeMux_out26 => RST_Mux26,
			  writeMux_out27 => RST_Mux27,
			  writeMux_out28 => RST_Mux28,
			  writeMux_out29 => RST_Mux29,
			  writeMux_out30 => RST_Mux30,
			  writeMux_out31 => RST_Mux31);
process
	begin
		wait until Clk'event and Clk ='1';

		if(Rst = '1') then
			RSTSig <= "00000";
		else
			if (RF_WrEn = '1') then
				RSTSig <= RF_Ri;
			else
				RSTSig <= "00000";
			end if;	
		end if;
	end process;



end Behavioral;


