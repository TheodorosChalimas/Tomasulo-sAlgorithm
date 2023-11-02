--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:42:43 11/04/2018
-- Design Name:   
-- Module Name:   D:/Desktop/LAB5_FINAL/TOMASULO/RSTest.vhd
-- Project Name:  TOMASULO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ReservatioStationArithmetic
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
 
ENTITY RSTest IS
END RSTest;
 
ARCHITECTURE behavior OF RSTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ReservatioStationArithmetic
    PORT(
         OpIn : IN  std_logic_vector(1 downto 0);
         VjIn : IN  std_logic_vector(31 downto 0);
         VkIn : IN  std_logic_vector(31 downto 0);
         Qj : IN  std_logic_vector(4 downto 0);
         Qk : IN  std_logic_vector(4 downto 0);
         CDBData : IN  std_logic_vector(31 downto 0);
         CDBQ : IN  std_logic_vector(4 downto 0);
         RegSel : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         OpOut : OUT  std_logic_vector(1 downto 0);
         VjOut : OUT  std_logic_vector(31 downto 0);
         VkOut : OUT  std_logic_vector(31 downto 0);
         TAG : OUT  std_logic_vector(4 downto 0);
         RE : OUT  std_logic_vector(2 downto 0);
         BU : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal OpIn : std_logic_vector(1 downto 0) := (others => '0');
   signal VjIn : std_logic_vector(31 downto 0) := (others => '0');
   signal VkIn : std_logic_vector(31 downto 0) := (others => '0');
   signal Qj : std_logic_vector(4 downto 0) := (others => '0');
   signal Qk : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBData : std_logic_vector(31 downto 0) := (others => '0');
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal RegSel : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal OpOut : std_logic_vector(1 downto 0);
   signal VjOut : std_logic_vector(31 downto 0);
   signal VkOut : std_logic_vector(31 downto 0);
   signal TAG : std_logic_vector(4 downto 0);
   signal RE : std_logic_vector(2 downto 0);
   signal BU : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ReservatioStationArithmetic PORT MAP (
          OpIn => OpIn,
          VjIn => VjIn,
          VkIn => VkIn,
          Qj => Qj,
          Qk => Qk,
          CDBData => CDBData,
          CDBQ => CDBQ,
          RegSel => RegSel,
          Clk => Clk,
          Rst => Rst,
          OpOut => OpOut,
          VjOut => VjOut,
          VkOut => VkOut,
          TAG => TAG,
          RE => RE,
          BU => BU
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
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
