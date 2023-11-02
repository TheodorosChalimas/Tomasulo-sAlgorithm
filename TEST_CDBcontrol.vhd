--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:27:32 11/25/2018
-- Design Name:   
-- Module Name:   C:/Users/User/Desktop/HMMY/arxitektonikh ypologistwn/ergastirio/3/TOMASULO/TEST_CDBcontrol.vhd
-- Project Name:  TOMASULO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CDBControl
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TEST_CDBcontrol IS
END TEST_CDBcontrol;
 
ARCHITECTURE behavior OF TEST_CDBcontrol IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CDBControl
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Req : IN  std_logic_vector(1 downto 0);
         QinA : IN  std_logic_vector(4 downto 0);
         DatainA : IN  std_logic_vector(31 downto 0);
         QinL : IN  std_logic_vector(4 downto 0);
         DatainL : IN  std_logic_vector(31 downto 0);
         Acc : OUT  std_logic_vector(1 downto 0);
         Q : OUT  std_logic_vector(4 downto 0);
         Data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Req : std_logic_vector(1 downto 0) := (others => '0');
   signal QinA : std_logic_vector(4 downto 0) := (others => '0');
   signal DatainA : std_logic_vector(31 downto 0) := (others => '0');
   signal QinL : std_logic_vector(4 downto 0) := (others => '0');
   signal DatainL : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Acc : std_logic_vector(1 downto 0);
   signal Q : std_logic_vector(4 downto 0);
   signal Data : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CDBControl PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Req => Req,
          QinA => QinA,
          DatainA => DatainA,
          QinL => QinL,
          DatainL => DatainL,
          Acc => Acc,
          Q => Q,
          Data => Data
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Rst <= '1';
      wait for 100 ns;	
		Rst <= '0';
		wait for Clk_period*10;
      -- insert stimulus here 
		Req <= "01"; 
		QinA <= "00110"; 
		DatainA <= "00000000000000000000000000000011";
		QinL <= "11110";
		DatainL <= "00000000000000000000000000001111";
		wait for 10 ns;	
		Req <= "10"; 
		QinA <= "00110"; 
		DatainA <= "00000000000000000000000000000011";
		QinL <= "11110";
		DatainL <= "00000000000000000000000000001111";
      wait;
   end process;

END;
