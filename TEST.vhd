-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT TOPLEVEL is
				Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM IF
				FOp : in  STD_LOGIC_VECTOR (1 downto 0);
				FUType : in  STD_LOGIC_VECTOR (1 downto 0);
				Rj : in  STD_LOGIC_VECTOR (4 downto 0);
				Rk : in  STD_LOGIC_VECTOR (4 downto 0);
				Ri : in  STD_LOGIC_VECTOR (4 downto 0);
				IssueIn : in std_logic;
				---------------------------------OUTPUTS		
				--TO IF
				IFAcc : out std_logic);
		END COMPONENT;

   --Inputs
   signal FOp : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal FUType : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal Rj : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
	signal Rk : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
	signal Ri : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
	signal Issue : std_logic := '0';
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';
	--Outputs
	signal IFAcc : std_logic;
	--Constant
	constant Clk_period : time := 10 ns;
          

  BEGIN

  
uut: TOPLEVEL PORT MAP
		(FOp => FOp,
		 FUType => FUType,
		 Rj => Rj,
		 Rk => Rk,
		 Ri => Ri,
		 IssueIn => Issue,
		 Rst => Rst,
		 Clk => Clk,
		 IFAcc => IFAcc);
	
	
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   stim_proc: process
   begin	
		
		Rst <= '1';
		wait for 100 ns;
		Rst <= '0';
		wait for 100 ns;
		
		
		--------ADD R3,R1,R2
		FUType <= "01";
		FOp <= "00";
		Ri <=	"00011";
		Rk <= "00001";
		Rj <= "00010";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 10 ns;

		--------AND R4,R1,R2
		FUType <= "00";
		FOp <= "01";
		Ri <=	"00100";
		Rk <= "00001";
		Rj <= "00010";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 10 ns;

		--------SUB R5,R2,R1
		FUType <= "01";
		FOp <= "01";
		Ri <=	"00101";
		Rj <= "00010";
		Rk <= "00001";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 20 ns;

		--------SLL R6,R3
		FUType <= "01";
		FOp <= "10";
		Ri <=	"00110";
		Rj <= "00011";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 20 ns;

		--------ADD R7,R3,R5
		FUType <= "01";
		FOp <= "00";
		Ri <=	"00111";
		Rk <= "00011";
		Rj <= "00101";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 20 ns;

--------NOT R8,R4
		FUType <= "00";
		FOp <= "10";
		Ri <=	"01000";
		Rk <= "00100";
		Rj <= "00100";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 20 ns;

		--------AND R9,R8,R7
		FUType <= "00";
		FOp <= "01";
		Ri <=	"01001";
		Rk <= "01000";
		Rj <= "00111";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 60 ns;
		
		--------OR R10,R9,R7
		FUType <= "00";
		FOp <= "00";
		Ri <=	"01010";
		Rk <= "01001";
		Rj <= "00111";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 20 ns;

		--------ADD R11,R10,R9
		FUType <= "01";
		FOp <= "00";
		Ri <=	"01011";
		Rk <= "01010";
		Rj <= "01001";
		Issue <= '1';
		wait for 10 ns;
		Issue <= '0';
		wait for 20 ns;
		
		


		

        wait;
     END PROCESS ;
 

  END;


