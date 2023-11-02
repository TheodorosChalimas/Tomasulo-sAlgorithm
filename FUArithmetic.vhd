library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity FUArithmetic is
	port (------------------------INPUTS
			Clk : in std_logic;
			Rst : in std_logic;
			--FROM LOCAL CONTROL 
			Run : in std_logic_vector(2 downto 0);
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
			Acc : out std_logic_vector(2 downto 0));		
end FUArithmetic;

architecture Behavioral of FUArithmetic is
-----------------------------STATES
	type State is (StRst,StA,StB,StC);
	signal CrntState, NxtState: State;
-----------------------------SIGNALS	
	signal SigVj,SigVk,SigData : std_logic_vector(31 downto 0);
	signal SigOp : std_logic_vector(1 downto 0);
	signal SigTAG : std_logic_vector(4 downto 0);
	signal SigAcc : std_logic_vector(2 downto 0);
	
begin
	---------------------------RESSET STATE / CLOCK EVENT
	process  						
	begin
		wait until Clk'event and Clk ='1';
		if (Rst = '1') then
			CrntState <= StRst;
		elsif (Clk'event and Clk = '1') then
			CrntState <= NxtState;
		end if;
	end process;
	----------------------------NEXT STATE
	process
	begin
		wait until Clk'event and Clk ='1';
		case CrntState is
		-------------------------RESSET STATE
		when StRst =>
			NxtState <= StA;
			CDBReq <='0';
			FuBU <= '0';
			SigAcc <= "000";
		-------------------------STATE A
		when StA =>
		if(Run(0) = '1') then
			NxtState <= StB;
			FuBU <= '1';
			SigAcc <= "001";
		elsif(Run(1) = '1') then
			NxtState <= StB;
			FuBU <= '1';
			SigAcc <= "010";
		elsif(Run(2) = '1') then
			NxtState <= StB;
			FuBU <= '1';
			SigAcc <= "100";
		else 
			FuBU <= '0';
			NxtState <= StA;
		end if;
		-------------------------STATE B
		when StB =>
		if(SigOp = "00") then
			SigData <= SigVj + SigVk;--ADD
		elsif(SigOp = "01") then
			SigData <= SigVj - SigVk;--SUB
		elsif(SigOp = "10") then
			SigData <= SigVj(30 downto 0) & '0';--SLL
		end if;
		CDBReq <= '1';
		SigAcc <= "000";
		NxtState <= StC;		
		-------------------------STATE C
		when StC =>
		if(CDBAcc ='1') then
			FuBU <= '0';
			CDBReq <='0';
			NxtState <= StA;
		else
			NxtState <= StC;
		end if;
		-------------------------OTHERS
		when others =>
			null;
		end case;
	end process;
	
	SigVj <= Vj;
	SigVk <= Vk;
	SigOp <= Op;
	SigTAG <= TAG;
	CDBData <= SigData ;
	CDBTAGOut <= SigTAG ;
	Acc <= SigAcc ;
end Behavioral;



