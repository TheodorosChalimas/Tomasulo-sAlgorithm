
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity LocalControlLogic is
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
end LocalControlLogic;

architecture Behavioral of LocalControlLogic is
	-------------------------------------------------STATES
	type State is (StRst,StA,StB,StC);
	signal CrntState0, CrntState1, NxtState0, NxtState1: State;
	-------------------------------------------------SIGNALS
	signal SigTAG : std_logic_vector(4 downto 0);
	signal SigRun,SigAcc,SigWrEn, sigBU : std_logic_vector(1 downto 0);
	signal SigRegSel,SigOp,SigRegRes : std_logic_vector(1 downto 0);
	signal SigFlag,SigFlag2 : std_logic;

begin
	
	process
	begin
	
	wait until clk'event and clk = '1';
	if(Rst = '1') then
		SigWrEn <= "00";
	else
		-------------------------------NEW STUFF
		if(FUType = "00" and IssReq = '1' and SigFlag2 = '0') then
			if(sigBU(0) = '0' and SigRegRes(0) = '0') then 
				SigWrEn <= "01";
				SigOp <= Op;
				IssAcc <= '1';
				SigFlag2 <= '1';
			elsif (sigBU(1)='0' and SigRegRes(1) = '0') then
				SigWrEn <= "10";
				SigOp <= Op;
				IssAcc <= '1';
				SigFlag2 <= '1';
			elsif (sigBU(1)='1' and sigBU(0)='1') then
				IssAcc <= '0';
			end if;
		else
		if (IssReq = '0')then
			SigFlag2 <= '0';
			IssAcc <= '0';
		end if;
		SigWrEn <= "00";
		
		end if;	
	end if;
	end process;
	
	OpOut <= SigOp;
	WrEn <= SigWrEn;

	SigRegSel <= 	"01" when FuAcc = "01" else
						"10" when FuAcc = "10" else
						"00" ;
---------------------------RESSET STATE / CLOCK EVENT
	process  						
	begin
		wait until Clk'event and Clk ='1';
		if (Rst = '1') then
			CrntState0 <= StRst;
			CrntState1 <= StRst;
		elsif (Clk'event and Clk = '1') then
			CrntState0 <= NxtState0;
			CrntState1 <= NxtState1;
		end if;
	end process;
	
	
-------------------------------OLD STUFF rs0
	process
	begin
		
		wait until Clk'event and Clk ='1';
		case CrntState0 is
		-------------------------RESSET STATE
	when StRst =>
		SigRun(0) <= '0';
		SigRegRes(0) <= '1';
		NxtState0 <= StA;
		sigBU(0) <= '0';

	when StA =>
		SigRegRes(0) <= '0';
		if(sigBU(0) = '1' and RE(0) ='1' and FuBu ='0') then
			SigRun(0) <='1';
			NxtState0 <= StB;
		end if;
		if (SigWrEn = "01") then
		 sigBU(0) <= '1';
		end if;
		
	when StB =>
		if(FuBU = '1' and FuAcc = "01")then
			NxtState0 <= StC;
			SigRegRes(0) <= '1';
		end if;
		
	when StC =>
	SigRegRes(0) <= '0';
		SigRun(0) <='0';
		if(FuBu = '0') then
			NxtState0 <= StA;
			sigBU(0) <= '0';
		end if;
		
	when others=>
		null;
	end case;
end process;	
RegRes(0) <= SigRegRes(0);			
-------------------------------OLD STUFF rs1
	process
	begin
		
		wait until Clk'event and Clk ='1';
		case CrntState1 is
		-------------------------RESSET STATE
	when StRst =>
		SigRun(1) <='0';
		SigRegRes(1) <= '1';
		NxtState1 <= StA;
		sigBU(1) <= '0';

	when StA =>
		SigRegRes(1) <= '0';
		if(sigBU(1) = '1' and RE(1) ='1' and FuBu ='0') then
			SigRun(1) <='1';
			NxtState1 <= StB;
		end if;
		if (SigWrEn = "10") then
		 sigBU(1) <= '1';
		end if;
		
	when StB =>
		if(FuBU = '1' and FuAcc = "10")then
			NxtState1 <= StC;
			SigRegRes(1) <= '1';
		end if;
		
	when StC =>
		SigRegRes(1) <= '0';
		SigRun(1) <='0';
		if(FuBu = '0') then
			NxtState1 <= StA;
			sigBU(1) <= '0';
		end if;
	
	when others=>
		null;
	end case;
end process;		
RegRes(1) <= SigRegRes(1);	
Run <= SigRun;
RegSel <= SigRegSel;
RegRes <= SigRegRes;
	
end Behavioral;


