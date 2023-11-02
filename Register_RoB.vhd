
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RegisterNote is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RF_Note
			  RoBAdd : in STD_LOGIC_VECTOR (4 downto 0);
			  WrEn : in  STD_LOGIC;
			  ---------------------------------OUTPUTS
			  --TO RF_Note
           Data: out  STD_LOGIC_VECTOR (4 downto 0));
end RegisterNote;

architecture Behavioral of RegisterNote is
	signal SigDaTa :  STD_LOGIC_VECTOR (4 downto 0);
begin
	process
	begin
	wait until Clk'Event And Clk='1';
	---------------------------------RESSET
	 if (rst = '1') then
		 SigData <= "00000";
	 else
	---------------------------------INPUT
		 if (WrEn = '1') then
			SigData <= RoBAdd; 
		 end if;
	 end if;
	end process;
	---------------------------------OUTPUT
	Data <= SigData;
	
end Behavioral;

