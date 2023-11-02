
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity LocalControlArithmetic is
Port (------------------------------------INPUTS
		Rst    : in  std_logic;
		Clk   : in  std_logic;
		--FROM ROB
		RoBS : in  std_logic;
		--FROM ISSUE
		IssReq : in  std_logic;
		FUType : in  std_logic_vector(1 downto 0);
		Op : in std_logic_vector(1 downto 0);
		--FROM FU
		FuAcc : in std_logic_vector(2 downto 0);
		FuBU : in std_logic;
		--FROM RS
		BU : in  std_logic_vector(2 downto 0);
		RE : in std_logic_vector(2 downto 0);
		------------------------------------OUTPUTS
		--TO ISSUE
		IssAcc : out  std_logic;
		--TO FU
		Run : out std_logic_vector(2 downto 0);
		--TO RS
		RegRes : out std_logic_vector(2 downto 0);
		OpOut : out std_logic_vector(1 downto 0);
		RegSel : out std_logic_vector(2 downto 0);
		WrEn : out std_logic_vector(2 downto 0));
end LocalControlArithmetic;

architecture Behavioral of LocalControlArithmetic is
	-------------------------------------------------STATES
	type State is (StRst,StA,StB,StC);
	signal CrntState0, CrntState1, CrntState2,CrntStateTAG, NxtState0, NxtState1, NxtState2,NxtStateTAG: State;
	-------------------------------------------------SIGNALS
	signal SigTAG : std_logic_vector(4 downto 0);
	signal SigRegSel,SigRun,SigAcc,SigWrEn, sigBU,SigRegRes : std_logic_vector(2 downto 0);
	signal SigOp : std_logic_vector(1 downto 0);
	signal SigFlag,SigFlag2 : std_logic;
begin
	
	process
	begin
	
	wait until clk'event and clk = '1';
	if(Rst = '1') then
		SigWrEn <= "000";
	else
		-------------------------------NEW STUFF
		if(FUType = "01" and IssReq = '1' and SigFlag2 = '0') then
			if(sigBU(0) = '0' and SigRegRes(0) = '0') then 
				SigWrEn <= "001";
				SigOp <= Op;
				IssAcc <= '1';
				SigFlag2 <= '1';
			elsif (sigBU(1)='0' and SigRegRes(1) = '0') then
				SigWrEn <= "010";
				SigOp <= Op;
				IssAcc <= '1';
				SigFlag2 <= '1';
			elsif (sigBU(2)='0' and SigRegRes(2) = '0') then
				SigWrEn <= "100";
				SigOp <= Op;
				IssAcc <= '1';
				SigFlag2 <= '1';
			elsif (sigBU(2)='1' and sigBU(1)='1' and sigBU(0)='1') then
				IssAcc <= '0';
			end if;
		--elsif(RoBS = '0' and SigFlag2 = '0')then	
			--SigWrEn <= "000";
		else
			SigWrEn <= "000";
			if (IssReq = '0')then
				SigFlag2 <= '0';
				IssAcc <= '0';	
			end if;
		end if;	
	end if;
	end process;

	OpOut <= SigOp;
	WrEn <= SigWrEn;

	SigRegSel <= FuAcc;
						
--------------------------------------TAG Dynamic					
--process 
--	begin 
--	wait until clk'event and clk = '1';
--	case CrntStateTAG is
--	
--	when StRst =>
--			SigTag <= "11111";
--			NxtStateTAG <= StA;
--	when StA =>
--			if ( FUType = "01" and IssReq = '1') then
--				SigTag <= "01001";
--				NxtStateTAG <= StB;
--			end if;
--	when StB =>
--			if ( FUType = "01" and IssReq = '1') then
--				SigTag <= "01010";
--				NxtStateTAG <= StC;
--			end if;
--	when StC =>
--			if ( FUType = "01" and IssReq = '1') then
--				SigTag <= "01100";
--				NxtStateTAG <= StB;
--			end if;
--			
--	when others=>
--		null;
--	end case;
--end process;
--TAG <= SigTag;		
			
	
	---------------------------RESSET STATE / CLOCK EVENT
	process  						
	begin
		wait until Clk'event and Clk ='1';
		if (Rst = '1') then
			CrntState0 <= StRst;
			CrntState1 <= StRst;
			CrntState2 <= StRst;
		elsif (Clk'event and Clk = '1') then
			CrntState0 <= NxtState0;
			CrntState1 <= NxtState1;
			CrntState2 <= NxtState2;
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
		if (SigWrEn = "001") then
		 sigBU(0) <= '1';
		end if;
		
	when StB =>
		if(FuBU = '1' and FuAcc = "001")then
			SigRegRes(0) <= '1';
			NxtState0 <= StC;
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
		if (SigWrEn = "010") then
		 sigBU(1) <= '1';
		end if;
		
	when StB =>
		if(FuBU = '1' and FuAcc = "010")then
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
-------------------------------OLD STUFF rs2
	process
	begin
		
		wait until Clk'event and Clk ='1';
		case CrntState2 is
		-------------------------RESSET STATE
	when StRst =>
		SigRun(2) <='0';
		SigRegRes(2) <= '1';
		NxtState2 <= StA;
		sigBU(2) <= '0';

	when StA =>
	SigRegRes(2) <= '0';
		if(sigBU(2) = '1' and RE(2) ='1' and FuBu ='0') then
			SigRun(2) <='1';
			NxtState2 <= StB;
		end if;
		if (SigWrEn = "100") then
		 sigBU(2) <= '1';
		end if;
		
	when StB =>
		if(FuBU = '1' and FuAcc = "100")then
			NxtState2 <= StC;
			SigRegRes(2) <= '1';
		end if;
		
	when StC =>
		SigRegRes(2) <= '0';
		SigRun(2) <='0';
		if(FuBu = '0') then
			NxtState2 <= StA;
			sigBU(2) <= '0';
		end if;
		
	when others=>
		null;
	end case;
end process;	
RegRes(2) <= SigRegRes(2);	
Run <= SigRun;
RegSel <= SigRegSel;
	
end Behavioral;
