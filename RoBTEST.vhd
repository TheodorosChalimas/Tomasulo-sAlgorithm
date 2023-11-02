--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:00:56 12/10/2018
-- Design Name:   
-- Module Name:   C:/Users/User/Desktop/HMMY/arxitektonikh ypologistwn/ergastirio/3/TOMASULO/RoBTEST.vhd
-- Project Name:  TOMASULO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Reorder_Buffer
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
 
ENTITY RoBTEST IS
END RoBTEST;
 
ARCHITECTURE behavior OF RoBTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reorder_Buffer
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Rj : IN  std_logic_vector(4 downto 0);
         Rk : IN  std_logic_vector(4 downto 0);
         Ri : IN  std_logic_vector(4 downto 0);
         WrEn : IN  std_logic;
         CDBQ : IN  std_logic_vector(4 downto 0);
         CDBData : IN  std_logic_vector(31 downto 0);
         RoBTail : OUT  std_logic_vector(4 downto 0);
         RoBHead : OUT  std_logic_vector(4 downto 0);
         RF_WrEn : OUT  std_logic;
         RF_Ri : OUT  std_logic_vector(4 downto 0);
         RF_Data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Rj : std_logic_vector(4 downto 0) := (others => '0');
   signal Rk : std_logic_vector(4 downto 0) := (others => '0');
   signal Ri : std_logic_vector(4 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal CDBQ : std_logic_vector(4 downto 0) := (others => '0');
   signal CDBData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal RoBTail : std_logic_vector(4 downto 0);
   signal RoBHead : std_logic_vector(4 downto 0);
   signal RF_WrEn : std_logic;
   signal RF_Ri : std_logic_vector(4 downto 0);
   signal RF_Data : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reorder_Buffer PORT MAP (
          Clk => Clk,
          Rst => Rst,
          Rj => Rj,
          Rk => Rk,
          Ri => Ri,
          WrEn => WrEn,
          CDBQ => CDBQ,
          CDBData => CDBData,
          RoBTail => RoBTail,
          RoBHead => RoBHead,
          RF_WrEn => RF_WrEn,
          RF_Ri => RF_Ri,
          RF_Data => RF_Data
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
      wait for 100 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "00111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "01111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "11111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "00111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "01111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "11111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;
		          Rj <= "00011";
          Rk <= "00010";
          Ri <= "00111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "01111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;	
          Rj <= "00011";
          Rk <= "00010";
          Ri <= "11111";
          WrEn <= '1';
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;     
          WrEn <= '0';
		wait for 10 ns;
          WrEn <= '0';
          CDBQ <= "00001";
          CDBData <= "00000000000000000000000000000011";
      wait for 10 ns;         
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
		wait for 10 ns;		
          WrEn <= '0';
          CDBQ <= "00011";
          CDBData <= "00000000000000000000000000000011";
      wait for 10 ns;         
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;
		    WrEn <= '0';
          CDBQ <= "00010";
          CDBData <= "00000000000000000000000000000011";
      wait for 10 ns;         
          CDBQ <= "00000";
          CDBData <= "00000000000000000000000000000000";
      wait for 10 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
