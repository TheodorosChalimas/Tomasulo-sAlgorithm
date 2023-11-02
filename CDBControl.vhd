
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CDBControl is
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
end CDBControl;

architecture Behavioral of CDBControl is
-----------------------------COMPONENT
	component CDB is
	Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM CDB CONTROL
			  Qin : in  STD_LOGIC_VECTOR (4 downto 0);
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
			  ---------------------------------OUTPUTS
			  --TO RF-RS
			  Q : out  STD_LOGIC_VECTOR (4 downto 0);
           Data : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
-----------------------------STATES
	type State is (StRst,StA,StB);
	signal CrntState, NxtState: State;
-----------------------------SIGNALS
	
	signal SigData : std_logic_vector(31 downto 0);
	signal SigQ : std_logic_vector(4 downto 0);

begin
	-----------------------------PORT MAPS			
	ComonDataBus: CDB
	port map(Clk => Clk,
            Rst => Rst,
				Qin => SigQ,
				Datain => SigData,
				--
				Q => Q,
				Data => Data);
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
	
	
	process
	begin
		wait until Clk'event;
		-------------------------RESSET STATE
	if(Rst = '1')then
			Acc <= "00";
			SigData <= "00000000000000000000000000000000";
		-------------------------STATE A
	else
		if(Req(1) = '1') then
			SigQ <= QinL;
       	SigData <= DatainL;
			Acc <= "10";
		elsif(Req(0) = '1') then
			SigQ <= QinA;
         SigData <= DatainA;
			Acc <= "01";
		else 
			Acc <= "00";
		end if;
	end if;
			
	end process;


end Behavioral;

