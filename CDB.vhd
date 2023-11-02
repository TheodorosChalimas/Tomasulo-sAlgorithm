
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CDB is
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
end CDB;

architecture Behavioral of CDB is
-----------------------------SIGNALS	
	signal SigData : std_logic_vector(31 downto 0);
	signal SigQ : std_logic_vector(4 downto 0);
begin
	process
	begin
		wait until Clk'event and Clk ='1';
		if (Rst = '1') then
			SigData <= "00000000000000000000000000000000";
			SigQ <= "11000";
		else 
			SigData <= Datain;
			SigQ <= Qin;
		end if;
	end process;
	
	Data <= SigData;
	Q <= SigQ;
end Behavioral;