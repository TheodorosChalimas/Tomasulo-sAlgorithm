
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RSReg is
    Port ( WrEn : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           DataIn : in  STD_LOGIC_VECTOR (75 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (75 downto 0);
			  Update: in std_logic;
			  UpData: in std_logic_vector(73 downto 0);
			  TAGin: in std_logic_vector(4 downto 0);
			  TAGout: out std_logic_vector(4 downto 0));
end RSReg;

architecture Behavioral of RSReg is

begin

	process
	begin
	wait until Clk'Event And Clk='1';
	
	if (Rst = '1') then
			DataOut <=  "0011111000000000000000000000000000000001111100000000000000000000000000000000";
	else
		if (Update = '1') then
			DataOut(73 downto 0) <= UpData(73 downto 0);
		elsif (WrEn = '1') then
			DataOut <= DataIn;
			TAGout <= TAGin;
		end if;
	end if;	
	
end process;
end Behavioral;

