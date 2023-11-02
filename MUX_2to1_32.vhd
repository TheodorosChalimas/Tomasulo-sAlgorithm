

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX_2to1_32 is
    Port ( Clk : in std_logic;
			  In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC;
           Data : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_2to1_32;

architecture Behavioral of MUX_2to1_32 is
	signal Sig :STD_LOGIC_VECTOR (31 downto 0);
begin
--	process(sel)
--	begin
--	--wait until Clk'event and Clk ='1';
--	case (sel) is
--		when '0' =>
--			Data <= In0;
--		when '1' => 
--			Data <= In1;
--		when others =>
--			null;
--		end case;
--	end process;

Data <= In0 when sel = '0' else 
In1 when sel = '1' ; 

end Behavioral;