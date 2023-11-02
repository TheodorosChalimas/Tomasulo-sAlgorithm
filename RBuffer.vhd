
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RBuffer is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RoB
			  Valuein : in  STD_LOGIC_VECTOR (31 downto 0);
			  Riin : in STD_LOGIC_VECTOR (4 downto 0);
			  Readyin : in  STD_LOGIC;
			  WrEn : in  STD_LOGIC;
			  CDBWrEn : in  STD_LOGIC;
			  ---------------------------------OUTPUTS
			  --TO RoB
           Value : out  STD_LOGIC_VECTOR (31 downto 0);
			  Ri : out STD_LOGIC_VECTOR (4 downto 0);
			  Ready : out  STD_LOGIC);
end RBuffer;

architecture Behavioral of RBuffer is
	signal SigValue :  STD_LOGIC_VECTOR (31 downto 0);
	signal SigRi :  STD_LOGIC_VECTOR (4 downto 0);
	signal SigReady , inst :  STD_LOGIC;
begin
	process
	begin
	wait until Clk'Event And Clk='1';
	---------------------------------RESSET
	 if (rst = '1') then
		SigValue <= "00000000000000000000000000000000";
		SigRi <= "00000";
		SigReady <= '0';
	 else
	---------------------------------INPUT
		 if (WrEn = '1') then
			SigRi <= Riin;
		 end if;
		 if (CDBWrEn = '1') then
			SigValue <= Valuein;
			SigReady <= '1';
		 elsif (Readyin = '1') then
			SigReady <= '0';
		 end if;
	 end if;
	end process;
	---------------------------------OUTPUT
	Value <= SigValue;
	Ri <= SigRi;
	Ready <= SigReady;
	
end Behavioral;

