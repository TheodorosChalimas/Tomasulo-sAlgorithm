library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TOPLEVEL_RSFU_LOGIC is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM ISSUE
				OpOut : in  STD_LOGIC_VECTOR (1 downto 0);
				FUTypeOut : in std_logic_vector(1 downto 0);
				RSReq : in std_logic; -- Request to RS
				--FROM RoB
				TAG : in  STD_LOGIC_VECTOR (4 downto 0);
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
end TOPLEVEL_RSFU_LOGIC;

architecture Behavioral of TOPLEVEL_RSFU_LOGIC is
---------------------------------COMPONENTS
component LocalControlLogic is
		Port (------------------------------------INPUTS
				Clk : in std_logic;
				Rst : in std_logic;
				--FROM ISSUE
				IssReq : in  std_logic;
				FUType : in  std_logic_vector(1 downto 0);
				Op : in std_logic_vector(1 downto 0);
				--FROM FU
				FuAcc : in std_logic_vector(1 downto 0);
				FuBU : in std_logic;
				--FROM RS
				BU : in  std_logic_vector(1 downto 0);
				RE : in std_logic_vector(1 downto 0);
				------------------------------------OUTPUTS

				--TO Issue
				IssAcc :out std_logic; 
				--TO FU
				Run: out std_logic_vector(1 downto 0);
				--TO RS
				RegRes : out std_logic_vector(1 downto 0);
				OpOut : out std_logic_vector(1 downto 0);
				RegSel : out std_logic_vector(1 downto 0);
				WrEn : out std_logic_vector(1 downto 0));
		end component;
		
		component FULogic is
		port (------------------------INPUTS
				Clk : in std_logic;
				Rst : in std_logic;
				--FROM LOCAL CONTROL 
				Run : in std_logic_vector(1 downto 0);
				--FROM RS
				Op: in std_logic_vector(1 downto 0);
				Vj : in std_logic_vector(31 downto 0);
				Vk : in std_logic_vector(31 downto 0);
				TAG : in std_logic_vector(4 downto 0);
				--FROM CDB 
				CDBAcc : in std_logic;
				------------------------OUTPUTS
				--TO CDB
				CDBData : out std_logic_vector(31 downto 0);
				CDBTAGOut : out std_logic_vector(4 downto 0);
				CDBReq : out std_logic;	
				--TO LOCAL CONTROL
				FuBU : out std_logic;
				Acc : out std_logic_vector(1 downto 0));		
		end component;
		
		
		component ReservatioStationLogic is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM RoB
			   RoBTaG : in  STD_LOGIC_VECTOR (4 downto 0);
				--FROM RF
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
		end component;
		
---------------------------------SIGNALS
	signal SigVj,SigVk,SigRegV,RFVj,RFVk,RSVj,RSVk,SigFUDA,SigFUDL,SigCDBD : std_logic_vector(31 downto 0);
	signal RFQj,RFQk,SigQj,SigQk,SigRegQ,IssRj,IssRk,IssRi,RSTAG,LocTAG,SigFUQA,SigFUQL,SigCDBQ : std_logic_vector(4 downto 0);
	signal LCwrenA,RSREA,RSBUA,LocRunA,LocRunL,SigAcc : std_logic_vector(1 downto 0);
	signal SigCDBAcc,SigFUReq,RSOp,SigRSOp,SigIssOp,LCop,SigIssFU,LCwrenL,RSREL,RSBUL,LCRSel,SigRegRes : std_logic_vector(1 downto 0);
	signal SigIssAccL,SigIssAcc,SigIssRSReq,SigRSAcc,SigFUBUL,SigFUBUA : std_logic;

-------------------------------------------------PORT MAPS
begin
-------------------------------------------------LocalControlArithmetic
LogicControl: LocalControlLogic
	port map(------------------------------------INPUTS
				Clk => Clk,
				Rst => Rst,
				--FROM ISSUE
				IssReq => RSReq,
				Op => OpOut,
				FUType => FUTypeOut,
				--FROM FU
				FuAcc => SigAcc,
				FuBU => SigFUBUA,
				--FROM RS
				BU => RSBUA,
				RE => RSREA,
				------------------------------------OUTPUTS,
				--TO Issue
				IssAcc => IssAcc, 
				--TO FU
				Run => LocRunA,
				--TO RS
				RegRes => SigRegRes,
				OpOut => LCop,
				RegSel => LCRSel,
				WrEn => LCwrenA);
				
				
-------------------------------------------------FUArithmetic
FunctionalUnitLogic: FULogic
	port map(------------------------INPUTS
				Clk => Clk,
				Rst => Rst,
				--FROM LOCAL CONTROL 
				Run => LocRunA,
				--FROM RS
				Op => RSOp,
				Vj => RSVj,
				Vk => RSVk,
				TAG => RSTAG,
				--FROM CDB 
				CDBAcc => Acc(1),
				------------------------OUTPUTS
				--TO CDB
				CDBData =>CDBData,
				CDBTAGOut =>CDBTAGOut,
				CDBReq =>CDBReq,	
				--TO LOCAL CONTROL
				FuBU => SigFUBUA,
				Acc => SigAcc);
				
				
-------------------------------------------------ReservatioStationArithmetic
ReservatioStationLog: ReservatioStationLogic
	port map(---------------------------------INPUTS
			Clk => Clk,
			Rst => Rst,
			--FROM RoB
			RoBTaG => TAG,
			VjIn => Vj,
			VkIn => Vk,
			Qj => Qj,
			Qk => Qk,
			--FROM CDB
			CDBData => Data,
			CDBQ => Q,
			--FROM LOCAL CONTROL
			RegRes => SigRegRes,
			OpIn => LCop,
			WrEn => LCwrenA,
			RegSel => LCRSel,
			---------------------------------OUTPUTS
			--TO FU
			OpOut => RSOp,
			VjOut => RSVj,
			VkOut => RSVk,
			TAG => RSTAG,
			--TO LOCAL CONTROL
			RE => RSREA,
			BU => RSBUA);				
end Behavioral;