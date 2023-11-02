
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX32bit_32to1 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In3 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In4 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In5 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In6 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In7 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In8 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In9 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In10 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In11 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In12 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In13 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In14 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In15 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In16 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In17 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In18 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In19 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In20 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In21 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In22 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In23 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In24 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In25 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In26 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In27 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In28 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In29 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In30 : in  STD_LOGIC_VECTOR (31 downto 0);
			  In31: in  STD_LOGIC_VECTOR (31 downto 0);
           Mout : out  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (4 downto 0));
end MUX32bit_32to1;

architecture Behavioral of MUX32bit_32to1 is
signal a :STD_LOGIC_VECTOR (31 downto 0);
begin
process(sel,a,In0 ,In1 ,In2 ,In3 ,In4 ,In5 ,In6,In7 ,In8,In9 ,In10,In11 ,In12 ,In13 ,In14 ,In15,In16 ,In17 ,In18,In19,In20,In21 ,In22, In23,In24 ,In25,In26 , In27 ,In28 ,In29 ,In30 ,In31 )
begin


case (sel) is
when "00000" =>
	a <= In0;
when "00001" =>
	a <= In1;
when "00010" =>
	a <= In2;
when "00011" =>
	a <= In3;
when "00100" =>
	a <= In4;
when "00101" =>
	a <= In5;
when "00110" =>
	a <= In6;
when "00111" =>
	a <= In7;
when "01000" =>
	a <= In8;
when "01001" =>
	a <= In9;
when "01010" =>
	a <= In10;
when "01011" =>
	a <= In11;
when "01100" =>
	a <= In12;
when "01101" =>
	a <= In13;
when "01110" =>
	a <= In14;
when "01111" =>
	a <= In15;
when "10000" =>
	a <= In16;
when "10001" =>
	a <= In17;
when "10010" =>
	a <= In18;
when "10011" =>
	a <= In19;
when "10100" =>
	a <= In20;
when "10101" =>
	a <= In21;
when "10110" =>
	a <= In22;
when "10111" =>
	a <= In23;
when "11000" =>
	a <= In24;
when "11001" =>
	a <= In25;
when "11010" =>
	a <= In26;
when "11011" =>
	a <= In27;
when "11100" =>
	a <= In28;
when "11101" =>
	a <= In29;
when "11110" =>
	a <= In30;
when "11111" =>
	a <= In31;
when others =>
	a <= "00000000000000000000000000000000";
end case;



Mout <= a;
end process;

end Behavioral;