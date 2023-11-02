--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:08:00 12/14/2018
-- Design Name:   
-- Module Name:   C:/Users/User/Desktop/HMMY/arxitektonikh ypologistwn/ergastirio/3/TOMASULO/RfNoteTest.vhd
-- Project Name:  TOMASULO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RFnote
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
 
ENTITY RfNoteTest IS
END RfNoteTest;
 
ARCHITECTURE behavior OF RfNoteTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RFnote
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Rj : IN  std_logic_vector(4 downto 0);
         Rk : IN  std_logic_vector(4 downto 0);
         Ri : IN  std_logic_vector(4 downto 0);
         WrEn : IN  std_logic;
         RoBTail : IN  std_logic_vector(4 downto 0);
         RoBHead : IN  std_logic_vector(4 downto 0);
         RF_WrEn : IN  std_logic;
         RF_Ri : IN  std_logic_vector(4 downto 0);
         Qj : OUT  std_logic_vector(4 downto 0);
         Qk : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Rj : std_logic_vector(4 downto 0) := (others => '0');
   signal Rk : std_logic_vector(4 downto 0) := (others => '0');
   signal Ri : std_logic_vector(4 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal RoBTail : std_logic_vector(4 downto 0) := (others => '0');
   signal RoBHead : std_logic_vector(4 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_Ri : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Qj : std_logic_vector(4 downto 0);
   signal Qk : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RFnote PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rj => Rj,
          Rk => Rk,
          Ri => Ri,
          WrEn => WrEn,
          RoBTail => RoBTail,
          RoBHead => RoBHead,
          RF_WrEn => RF_WrEn,
          RF_Ri => RF_Ri,
          Qj => Qj,
          Qk => Qk
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
