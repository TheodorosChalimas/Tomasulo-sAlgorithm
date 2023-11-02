library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Issue is
		Port (---------------------------------INPUTS
				Clk : in  STD_LOGIC;
				Rst : in  STD_LOGIC;
				--FROM RoB 
				Full : in  STD_LOGIC;
				--FROM IF
				FOp : in  STD_LOGIC_VECTOR (1 downto 0);
				FUType : in  STD_LOGIC_VECTOR (1 downto 0);
				Rj : in  STD_LOGIC_VECTOR (4 downto 0);
				Rk : in  STD_LOGIC_VECTOR (4 downto 0);
				Ri : in  STD_LOGIC_VECTOR (4 downto 0);
				Issue : in std_logic;
				--FROM LOCAL CONTROL RS - FU 
				RSAcc : in std_logic;
				---------------------------------OUTPUTS
				--TO IF
				Acc : out  std_logic;
				--TO RF
				RjOut : out  STD_LOGIC_VECTOR (4 downto 0);
				RkOut : out  STD_LOGIC_VECTOR (4 downto 0);
				RiOut : out  STD_LOGIC_VECTOR (4 downto 0);
				--TO LOCAL CONTROL RS - FU
				OpOut : out  STD_LOGIC_VECTOR (1 downto 0);
				FUTypeOut : out std_logic_vector(1 downto 0);
				RSReq : out std_logic); -- Request to RS
end Issue;

architecture Behavioral of Issue is
-----------------------------STATES
	type State is (StRst,StA,StB);
	signal CrntState, NxtState: State;
-----------------------------SIGNALS	
	signal SigFlag : std_logic;
-------------------------------------RESSET STATE / CLOCK EVENT	
begin
	process  						
	begin
		wait until Clk'event and Clk ='1';
		if (Rst = '1') then
			CrntState <= StRst;
		elsif (Clk'event and Clk = '1') then
			CrntState <= NxtState;
		end if;
	end process;
----------------------------NEXT STATE

process
begin
	wait until Clk'event;
		if(Rst = '1') then
			Acc <= '0';
			RSReq <= '0';
			FUTypeOut <= "11";
			SigFlag <= '1';
		else
			if(Issue = '1' and Full = '0')then
				RjOut <= Rj;
				RkOut <= Rk;
				RiOut <= Ri;
				OpOut <= FOp;
				FUTypeOut <= FUType; 
				Acc <= '1';
				RSReq <= '1';
			else
				if (RSAcc = '1') then
				Acc <= '0';
				RSReq <= '0';
				end if;
			end if;
		end if;
end process;

	
end Behavioral;