
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register37 is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RF
			  Datain : in STD_LOGIC_VECTOR (31 downto 0);
			  WrEn : in  STD_LOGIC;
			  ---------------------------------OUTPUTS
			  --TO RF
           Data: out  STD_LOGIC_VECTOR (31 downto 0));
end Register37;

architecture Behavioral of Register37 is
	signal SigDaTa :  STD_LOGIC_VECTOR (31 downto 0);
begin
	process
	begin
	wait until Clk'Event And Clk='1';
	---------------------------------RESSET
	 if (rst = '1') then
		
		 SigData <= "00000000000000000000000000000000";
	 else
		if (WrEn = '1') then
			SigData <= Datain;
		end if;
	 end if;
	end process;
	
	Data <= SigData;
	
	

end Behavioral;

