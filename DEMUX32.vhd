library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX32 is
    Port ( R : in  std_logic_vector (4 downto 0);
           writeMux_out0 : out  std_logic;
			  writeMux_out1 : out  std_logic;
			  writeMux_out2 : out  std_logic;
			  writeMux_out3 : out  std_logic;
			  writeMux_out4 : out  std_logic;
			  writeMux_out5 : out  std_logic;
			  writeMux_out6 : out  std_logic;
			  writeMux_out7 : out  std_logic;
			  writeMux_out8 : out  std_logic; 
			  writeMux_out9 : out  std_logic;
			  writeMux_out10 : out  std_logic;
			  writeMux_out11 : out  std_logic;
			  writeMux_out12 : out  std_logic;
			  writeMux_out13 : out  std_logic;
			  writeMux_out14 : out  std_logic;
			  writeMux_out15 : out  std_logic;
			  writeMux_out16 : out  std_logic;
			  writeMux_out17 : out  std_logic;
			  writeMux_out18 : out  std_logic;
			  writeMux_out19 : out  std_logic;
			  writeMux_out20 : out  std_logic;
			  writeMux_out21 : out  std_logic;
			  writeMux_out22 : out  std_logic;
			  writeMux_out23 : out  std_logic;
			  writeMux_out24 : out  std_logic;
			  writeMux_out25 : out  std_logic;
			  writeMux_out26 : out  std_logic;
			  writeMux_out27 : out  std_logic;
			  writeMux_out28 : out  std_logic;
			  writeMux_out29 : out  std_logic;
			  writeMux_out30 : out  std_logic;
			  writeMux_out31 : out  std_logic);
end DEMUX32;

architecture Behavioral of DEMUX32 is

begin
process (R)
begin

if(R = "00000") then
	writeMux_out0 <= '0';
else
	writeMux_out0 <= '0';
end if;
if(R = "00001") then
	writeMux_out1 <= '1';
else
	writeMux_out1 <= '0';
end if;
if(R = "00010") then
	writeMux_out2 <= '1';
else
	writeMux_out2 <= '0';
end if;
if(R = "00011") then
	writeMux_out3 <= '1';
else
	writeMux_out3 <= '0';
end if;
if(R = "00100") then
	writeMux_out4 <= '1';
else
	writeMux_out4 <= '0';
end if;
if(R = "00101") then
	writeMux_out5 <= '1';
else
	writeMux_out5 <= '0';
end if;
if(R = "00110") then
	writeMux_out6 <= '1';
else
	writeMux_out6 <= '0';
end if;
if(R = "00111") then
	writeMux_out7 <= '1';
else
	writeMux_out7 <= '0';
end if;
if(R = "01000") then
	writeMux_out8 <= '1';
else
	writeMux_out8 <= '0';
end if;
if(R = "01001") then
	writeMux_out9 <= '1';
else
	writeMux_out9 <= '0';
end if;
if(R = "01010") then
	writeMux_out10 <= '1';
else
	writeMux_out10 <= '0';
end if;
if(R = "01011") then
	writeMux_out11 <= '1';
else
	writeMux_out11 <= '0';
end if;
if(R = "0110") then
	writeMux_out12 <= '1';
else
	writeMux_out12 <= '0';
end if;
if(R = "01101") then
	writeMux_out13 <= '1';
else
	writeMux_out13 <= '0';
end if;
if(R = "01110") then
	writeMux_out14 <= '1';
else
	writeMux_out14 <= '0';
end if;
if(R = "01111") then
	writeMux_out15 <= '1';
else
	writeMux_out15 <= '0';
end if;
if(R = "10000") then
	writeMux_out16 <= '1';
else
	writeMux_out16 <= '0';
end if;
if(R = "10001") then
	writeMux_out17 <= '1';
else
	writeMux_out17 <= '0';
end if;
if(R = "10010") then
	writeMux_out18 <= '1';
else
	writeMux_out18 <= '0';
end if;
if(R = "10011") then
	writeMux_out19 <= '1';
else
	writeMux_out19 <= '0';
end if;
if(R = "10100") then
	writeMux_out20 <= '1';
else
	writeMux_out20 <= '0';
end if;
if(R = "10101") then
	writeMux_out21 <= '1';
else
	writeMux_out21 <= '0';
end if;
if(R = "10110") then
	writeMux_out22 <= '1';
else
	writeMux_out22 <= '0';
end if;
if(R = "10111") then
	writeMux_out23 <= '1';
else
	writeMux_out23 <= '0';
end if;
if(R = "11000") then
	writeMux_out24 <= '1';
else
	writeMux_out24 <= '0';
end if;
if(R = "11001") then
	writeMux_out25 <= '1';
else
	writeMux_out25 <= '0';
end if;
if(R = "11010") then
	writeMux_out26 <= '1';
else
	writeMux_out26 <= '0';
end if;
if(R = "11011") then
	writeMux_out27 <= '1';
else
	writeMux_out27 <= '0';
end if;
if(R = "11100") then
	writeMux_out28 <= '1';
else
	writeMux_out28 <= '0';
end if;
if(R = "11101") then
	writeMux_out29 <= '1';
else
	writeMux_out29 <= '0';
end if;
if(R = "11110") then
	writeMux_out30 <= '1';
else
	writeMux_out30 <= '0';
end if;
if(R = "11111") then
	writeMux_out31 <= '1';
else
	writeMux_out31 <= '0';
end if;
end process;
end Behavioral;

