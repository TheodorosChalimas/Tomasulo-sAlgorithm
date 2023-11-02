library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TOPLEVEL is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM IF
				FOp : in  STD_LOGIC_VECTOR (1 downto 0);
				FUType : in  STD_LOGIC_VECTOR (1 downto 0);
				Rj : in  STD_LOGIC_VECTOR (4 downto 0);
				Rk : in  STD_LOGIC_VECTOR (4 downto 0);
				Ri : in  STD_LOGIC_VECTOR (4 downto 0);
				IssueIn : in std_logic;
				---------------------------------OUTPUTS		
				--TO IF
				IFAcc : out std_logic);
end TOPLEVEL;

architecture Behavioral of TOPLEVEL is
---------------------------------COMPONENTS

	
component RoBToP is
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
			  RoBS : out  STD_LOGIC;
			  TAG : out  STD_LOGIC_VECTOR (4 downto 0);
           Vj : out  STD_LOGIC_VECTOR (31 downto 0);
           Vk : out  STD_LOGIC_VECTOR (31 downto 0);
           Qj : out  STD_LOGIC_VECTOR (4 downto 0);
           Qk : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

	
	component Issue is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM RoB 
				Full : in  STD_LOGIC;
				--FROM IF
				FOp : in  STD_LOGIC_VECTOR (1 downto 0);
				FUType : in  STD_LOGIC_VECTOR (1 downto 0);
				Rj : in  STD_LOGIC_VECTOR (4 downto 0);
				Rk : in  STD_LOGIC_VECTOR (4 downto 0);
				Ri : in  STD_LOGIC_VECTOR (4 downto 0);
				Issue : in std_logic;
				--FROM LOCAL CONTROL RS - FU 
				RSAcc : in std_logic;
				---------------------------------OUTPUTS
				--TO IF
				Acc : out  std_logic;
				--TO RF
				RjOut : out  STD_LOGIC_VECTOR (4 downto 0);
				RkOut : out  STD_LOGIC_VECTOR (4 downto 0);
				RiOut : out  STD_LOGIC_VECTOR (4 downto 0);
				--TO LOCAL CONTROL RS - FU
				OpOut : out  STD_LOGIC_VECTOR (1 downto 0);
				FUTypeOut : out std_logic_vector(1 downto 0);
				RSReq : out std_logic); -- Request to RS
	end component;

	component CDBControl is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM FU
				Req : in  STD_LOGIC_VECTOR(1 downto 0);
				QinA : in  STD_LOGIC_VECTOR (4 downto 0);
				DatainA : in  STD_LOGIC_VECTOR (31 downto 0);
				QinL : in  STD_LOGIC_VECTOR (4 downto 0);
				DatainL : in  STD_LOGIC_VECTOR (31 downto 0);
				---------------------------------OUTPUTS
				--TO FU
				Acc : out  STD_LOGIC_VECTOR(1 downto 0);
				--TO CDB
				Q : out  STD_LOGIC_VECTOR (4 downto 0);
				Data : out  STD_LOGIC_VECTOR (31 downto 0));
		end component;
		
	component TOPLEVEL_RSFU_LOGIC is	
				Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM RoB
				TAG : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM ISSUE
				OpOut : in  STD_LOGIC_VECTOR (1 downto 0);
				FUTypeOut : in std_logic_vector(1 downto 0);
				RSReq : in std_logic; -- Request to RS
				--FROM RF
				Vj :   STD_LOGIC_VECTOR (31 downto 0);
				Vk : in  STD_LOGIC_VECTOR (31 downto 0);
				Qj : in  STD_LOGIC_VECTOR (4 downto 0);
				Qk : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM CDB CONTROL
				Acc : in  STD_LOGIC_VECTOR(1 downto 0);
				--FROM CDB
				Q : in  STD_LOGIC_VECTOR (4 downto 0);
				Data : in  STD_LOGIC_VECTOR (31 downto 0);
				---------------------------------OUTPUTS		
				--TO ISSUE
				IssAcc : out std_logic;
				--TO CDB
				CDBData : out std_logic_vector(31 downto 0);
				CDBTAGOut : out std_logic_vector(4 downto 0);
				CDBReq : out std_logic);
	end component;
	
	component TOPLEVEL_RSFU is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM RoB
				RoBS : in  std_logic;
				TAG : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM ISSUE
				OpOut : in  STD_LOGIC_VECTOR (1 downto 0);
				FUTypeOut : in std_logic_vector(1 downto 0);
				RSReq : in std_logic; -- Request to RS
				--FROM RF
				Vj :   STD_LOGIC_VECTOR (31 downto 0);
				Vk : in  STD_LOGIC_VECTOR (31 downto 0);
				Qj : in  STD_LOGIC_VECTOR (4 downto 0);
				Qk : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM CDB CONTROL
				Acc : in  STD_LOGIC_VECTOR(1 downto 0);
				--FROM CDB
				Q : in  STD_LOGIC_VECTOR (4 downto 0);
				Data : in  STD_LOGIC_VECTOR (31 downto 0);
				---------------------------------OUTPUTS		
				--TO ISSUE
				IssAcc : out std_logic;
				--TO CDB
				CDBData : out std_logic_vector(31 downto 0);
				CDBTAGOut : out std_logic_vector(4 downto 0);
				CDBReq : out std_logic);
	end component;
-----------------------------STATES
	type State is (StRst,StA,StB);
	signal CrntState, NxtState: State;
---------------------------------SIGNALS
	signal SigVj,SigVk,SigRegV,RFVj,RFVk,RSVj,RSVk,SigFUDA,SigFUDL,SigCDBD,a : std_logic_vector(31 downto 0);
	signal RFQj,RFQk,SigQj,SigQk,SigRegQ,IssRj,IssRk,IssRi,RSTAG,LocTAG,SigFUQA,SigFUQL,SigCDBQ,SigRFTag,SigRFTagA,SigRFTagL,SigTAG : std_logic_vector(4 downto 0);
	signal LCwrenA,RSREA,RSBUA : std_logic_vector(2 downto 0);
	signal SigCDBAcc,SigFUReq,RSOp,SigRSOp,SigIssOp,LCop,SigIssFU,LCwrenL,RSREL,RSBUL,LCRSel : std_logic_vector(1 downto 0);
	signal SigIssAccL,SigIssAccA,SigIssAcc,SigIssRSReq,SigRSAcc,SigFUBUL,SigFUBUA,LocRunA,LocRunL,selmux,SigFull,SigWrEn,RoBSig : std_logic;
	

-------------------------------------------------PORT MAPS
begin

	----------RoB
	RoB: RoBToP
	port map(Clk => Clk,
				Rst => Rst,
				--FROM ISSUE
				Rj => IssRj,
				Rk => IssRk,
				Ri => IssRi,
				WrEn => IssueIn,
				--FROM CDB
				CDBQ => SigCDBQ,
				CDBData => SigCDBD,
				---------------------------------OUTPUTS
				--TO ISSUE 
			   Full => SigFull, 
				--TO RS
				RoBS => RoBSig,
				TAG => SigTAG,
				Vj => RFVj,
				Vk => RFVk,
				Qj => RFQj,
				Qk => RFQk);


-------------------------------------------------ISSUE
ISSUEa: Issue
	port map(Clk => Clk,
				Rst => Rst,
				--FROM RoB 
				Full => SigFull,
				--FROM IF
				FOp => FOp,
				FUType => FUType,
				Rj => Rj,
				Rk => Rk,
				Ri => Ri,
				Issue => IssueIn,
				--FROM LOCAL CONTROL RS - FU 
				RSAcc => SigIssAcc,
				---------------------------------OUTPUTS
				--TO IF
				Acc => IFAcc,
				--TO RF
				RjOut =>IssRj,
				RkOut =>IssRk,
				RiOut =>IssRi,
				--TO LOCAL CONTROL RS - FU
				OpOut => SigIssOp,
				FUTypeOut => SigIssFU,
				RSReq => SigIssRSReq); -- Request to RS		
				
-------------------------------------------------CDBControl
CDBControla: CDBControl
	port map(---------------------------------INPUTS
				Clk => Clk, 
				Rst => Rst,
				--FROM FU
				Req => SigFUReq,
				QinA => SigFUQA,
				DatainA => SigFUDA,
				QinL => SigFUQL,
				DatainL => SigFUDL,
				---------------------------------OUTPUTS
				--TO RSFU
				Acc => SigCDBAcc,
				Q => SigCDBQ,
				Data => SigCDBD);
				
-------------------------------------------------RSFU LOGIC
RSFULOGIC: TOPLEVEL_RSFU_LOGIC
	PORT MAP (---------------------------------INPUTS
				 Clk => Clk,
				 Rst => Rst,
				 --FROM ISSUE
				 OpOut => SigIssOp,
				 FUTypeOut => SigIssFU,
				 RSReq => SigIssRSReq,
				 --FROM RoB
				 TAG =>SigTAG,
				 Vj => RFVj,
				 Vk => RFVk,
				 Qj => RFQj,
				 Qk => RFQk,
				 --FROM CDB CONTROL
				 Acc => SigCDBAcc,
				 Q => SigCDBQ,
				 Data => SigCDBD,
				 ---------------------------------OUTPUTS
				 --TO ISSUE 
				 IssAcc => SigIssAccL,
				 --TO CDB CONTROL
				 CDBData => SigFUDL,
				 CDBTAGOut => SigFUQL,
				 CDBReq => SigFUReq(1));
		  
-------------------------------------------------RSFU ARITHMETIC
RSFUARM: TOPLEVEL_RSFU
	PORT MAP (---------------------------------INPUTS
				 Clk => Clk,
				 Rst => Rst,
				 --FROM RoB
				 RoBS => RoBSig,
				 TAG =>SigTAG,
				 --FROM ISSUE
				 OpOut => SigIssOp,
				 FUTypeOut => SigIssFU,
				 RSReq => SigIssRSReq,
				 --FROM RF
				 Vj => RFVj,
				 Vk => RFVk,
				 Qj => RFQj,
				 Qk => RFQk,
				 --FROM CDB CONTROL
				 Acc => SigCDBAcc,
				 Q => SigCDBQ,
				 Data => SigCDBD,
				 ---------------------------------OUTPUTS
				 --TO ISSUE 
				 IssAcc => SigIssAccA,
				 --TO CDB CONTROL
				 CDBData => SigFUDA,
				 CDBTAGOut => SigFUQA,
				 CDBReq => SigFUReq(0));
				 
process
	begin
		wait until Clk'event and Clk ='1';
		if(Rst = '1') then
			SigIssAcc <= '0';
			SigRFTag <= "00000";
		else
			if (SigIssAccA = '1' )then 
				SigRFTag <= SigRFTagA;
				SigIssAcc <= '1';
			elsif(SigIssAccL = '1') then
				SigRFTag <= SigRFTagL;
				SigIssAcc <= '1';
			else 
				
				SigIssAcc <= '0';
			end if;
		end if;

	end process;






end Behavioral;