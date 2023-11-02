--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:42:42 12/15/2018
-- Design Name:   
-- Module Name:   C:/Users/User/Desktop/HMMY/arxitektonikh ypologistwn/ergastirio/3/TOMASULO/fgsdfgsdfgsdfgs.vhd
-- Project Name:  TOMASULO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RoBToP
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
 
ENTITY fgsdfgsdfgsdfgs IS
END fgsdfgsdfgsdfgs;
 
ARCHITECTURE behavior OF fgsdfgsdfgsdfgs IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RoBToP
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Rj : IN  std_logic_vector(4 downto 0);
         Rk : IN  std_logic_vector(4 downto 0);
         Ri : IN  std_logic_vector(4 downto 0);
         WrEn : IN  std_logic;
         Op : IN  std_logic_vector(1 downto 0);
         FU : IN  std_logic_vector(1 downto 0);
         CDBQ : IN  std_logic_vector(4 downto 0);
         CDBData : IN  std_logic_vector(31 downto 0);
         Full : OUT  std_logic;
         TAG : OUT  std_logic_vector(4 downto 0);
         Vj : OUT  std_logic_vector(31 downto 0);
         Vk : OUT  std_logic_vector(31 downto 0);
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
   signal Op : std_logic_vector(1 downto 0) := (others => '0');
   signal FU : std_logic_vector(1 downto 0) := (others => '0');
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Full : std_logic;
   signal TAG : std_logic_vector(4 downto 0);
   signal Vj : std_logic_vector(31 downto 0);
   signal Vk : std_logic_vector(31 downto 0);
   signal Qj : std_logic_vector(4 downto 0);
   signal Qk : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RoBToP PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rj => Rj,
          Rk => Rk,
          Ri => Ri,
          WrEn => WrEn,
          Op => Op,
          FU => FU,
          CDBQ => CDBQ,
          CDBData => CDBData,
          Full => Full,
          TAG => TAG,
          Vj => Vj,
          Vk => Vk,
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
