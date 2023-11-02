--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:40:48 11/22/2018
-- Design Name:   
-- Module Name:   D:/Desktop/LAB5_FINAL/TOMASULO/try2.vhd
-- Project Name:  TOMASULO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOPLEVEL_RSFU
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
 
ENTITY try2 IS
END try2;
 
ARCHITECTURE behavior OF try2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOPLEVEL_RSFU
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         OpOut : IN  std_logic_vector(1 downto 0);
         FUTypeOut : IN  std_logic_vector(1 downto 0);
         RSReq : IN  std_logic;
         Vj : IN  std_logic_vector(31 downto 0);
         Vk : IN  std_logic_vector(31 downto 0);
         Qj : IN  std_logic_vector(4 downto 0);
         Qk : IN  std_logic_vector(4 downto 0);
         Acc : IN  std_logic_vector(1 downto 0);
         Q : IN  std_logic_vector(4 downto 0);
         Data : IN  std_logic_vector(31 downto 0);
         CDBData : OUT  std_logic_vector(31 downto 0);
         CDBTAGOut : OUT  std_logic_vector(4 downto 0);
         CDBReq : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal OpOut : std_logic_vector(1 downto 0) := (others => '0');
   signal FUTypeOut : std_logic_vector(1 downto 0) := (others => '0');
   signal RSReq : std_logic := '0';
   signal Vj : std_logic_vector(31 downto 0) := (others => '0');
   signal Vk : std_logic_vector(31 downto 0) := (others => '0');
   signal Qj : std_logic_vector(4 downto 0) := (others => '0');
   signal Qk : std_logic_vector(4 downto 0) := (others => '0');
   signal Acc : std_logic_vector(1 downto 0) := (others => '0');
   signal Q : std_logic_vector(4 downto 0) := (others => '0');
   signal Data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal CDBData : std_logic_vector(31 downto 0);
   signal CDBTAGOut : std_logic_vector(4 downto 0);
   signal CDBReq : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOPLEVEL_RSFU PORT MAP (
          Clk => Clk,
          Rst => Rst,
          OpOut => OpOut,
          FUTypeOut => FUTypeOut,
          RSReq => RSReq,
          Vj => Vj,
          Vk => Vk,
          Qj => Qj,
          Qk => Qk,
          Acc => Acc,
          Q => Q,
          Data => Data,
          CDBData => CDBData,
          CDBTAGOut => CDBTAGOut,
          CDBReq => CDBReq
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
		Rst <= '1';
		----ADD 1 + 2
		wait for 90 ns;
		Rst <= '0';
		WAIT FOR 10 NS;
      OpOut <= "00";
      FUTypeOut <= "01";
      RSReq <= '1';
      Vj <= "00000000000000000000000000000001";
      Vk <= "00000000000000000000000000000010";
		Qj <= "00000";
		Qk <= "00000";
		Acc <= "00";
		Q <= "11010";
		Data <= "00000000000000000000000000011111";
		wait for 10 ns;
		RSReq <= '0';
		wait for 10 ns;
		Acc <= "01";
		---SUB 35 - 2
		wait for 30 ns;
      OpOut <= "01";
      FUTypeOut <= "01";
      RSReq <= '1';
      Vj <= "00000000000000000000000000100011";
      Vk <= "00000000000000000000000000000010";
		Acc <= "00";
		wait for 10 ns;
		RSReq <= '0';
		wait for 10 ns;
		Acc <= "01";
		--SLL VJ
		wait for 10 ns;
		OpOut <= "10";
      FUTypeOut <= "01";
      RSReq <= '1';
      Vj <= "00000000000000000000000000000111";
      Vk <= "00000000000000000000000000000001";
		Acc <= "00";
		wait for 10 ns;
		RSReq <= '0';
		wait for 10 ns;
		Acc <= "01";
		----ADD 1 + 2
		wait for 10 ns;
		Rst <= '0';
      OpOut <= "00";
      FUTypeOut <= "01";
      RSReq <= '1';
      Vj <= "00000000000000000000000000000010";
      Vk <= "00000000000000000000000000000010";
		Qj <= "00000";
		Qk <= "00000";
		Acc <= "00";
		Q <= "11010";
		Data <= "00000000000000000000000000011111";
		wait for 10 ns;
		RSReq <= '0';
		wait for 10 ns;
		Acc <= "01";
		---SUB 35 - 2
		wait for 120 ns;
      OpOut <= "01";
      FUTypeOut <= "01";
      RSReq <= '1';
      Vj <= "00000000000000000000000000100011";
      Vk <= "00000000000000000000000000100000";
		Acc <= "00";
		wait for 10 ns;
		RSReq <= '0';
		wait for 10 ns;
		Acc <= "01";
		--SLL VJ
		wait for 100 ns;
		OpOut <= "10";
      FUTypeOut <= "01";
      RSReq <= '1';
      Vj <= "00000000000000000000000000000110";
      Vk <= "00000000000000000000000000000010";
		Acc <= "00";
		wait for 10 ns;
		RSReq <= '0';
		Acc <= "01";
		wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
