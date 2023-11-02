
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Reorder_Buffer is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RFnote
           Rj : in  STD_LOGIC_VECTOR (4 downto 0);
           Rk : in  STD_LOGIC_VECTOR (4 downto 0);
			  --FROM ISSUE
			  Ri : in  STD_LOGIC_VECTOR (4 downto 0);
			  WrEn : in  STD_LOGIC;
			  --FROM CDB
			  CDBQ : in  STD_LOGIC_VECTOR (4 downto 0);
			  CDBData : in  STD_LOGIC_VECTOR (31 downto 0);

			  ---------------------------------OUTPUTS
			  --TO ISSUE 
			  Full : out STD_LOGIC;
			  --TO RS
			  Ready1 : out  STD_LOGIC;
			  Ready2 : out  STD_LOGIC;
			  Vj : out  STD_LOGIC_VECTOR (31 downto 0);
			  Vk : out  STD_LOGIC_VECTOR (31 downto 0);
			  --TO RFnote//RF
			  RoBTail : out  STD_LOGIC_VECTOR (4 downto 0);
           RoBHead : out  STD_LOGIC_VECTOR (4 downto 0);
			  RF_WrEn : out  STD_LOGIC;
           RF_Ri: out STD_LOGIC_VECTOR (4 downto 0);
			  RF_Data : out  STD_LOGIC_VECTOR (31 downto 0));
end Reorder_Buffer;

architecture Behavioral of Reorder_Buffer is

component RBuffer is
		Port (---------------------------------INPUTS
			  Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  --FROM RoB
			  Valuein : in  STD_LOGIC_VECTOR (31 downto 0);
			  Riin : in STD_LOGIC_VECTOR (4 downto 0);
			  Readyin : in  STD_LOGIC;
			  WrEn : in  STD_LOGIC;
			  CDBWrEn : in  STD_LOGIC;
			  ---------------------------------OUTPUTS
			  --TO RoB
           Value : out  STD_LOGIC_VECTOR (31 downto 0);
			  Ri : out STD_LOGIC_VECTOR (4 downto 0);
			  Ready : out  STD_LOGIC);
end component;

	--Buffer Signals
	signal SigReady0,SigReady1,SigReady2,SigReady3,SigReady4,SigReady5,SigReady6,SigReady7:  STD_LOGIC;
	signal SigReadyIN0,SigReadyIN1,SigReadyIN2,SigReadyIN3,SigReadyIN4,SigReadyIN5,SigReadyIN6,SigReadyIN7 :  STD_LOGIC;
	signal SigBWrEn0,SigBWrEn1,SigBWrEn2,SigBWrEn3,SigBWrEn4,SigBWrEn5,SigBWrEn6,SigBWrEn7 :  STD_LOGIC;
	signal SigCDBWrEn0,SigCDBWrEn1,SigCDBWrEn2,SigCDBWrEn3,SigCDBWrEn4,SigCDBWrEn5,SigCDBWrEn6,SigCDBWrEn7 : STD_LOGIC;
	signal SigRi0,SigRi1,SigRi2,SigRi3,SigRi4,SigRi5,SigRi6,SigRi7:  STD_LOGIC_VECTOR (4 downto 0);
	signal SigRiin0,SigRiin1,SigRiin2,SigRiin3,SigRiin4,SigRiin5,SigRiin6,SigRiin7:  STD_LOGIC_VECTOR (4 downto 0);
	signal SigValue0,SigValue1,SigValue2,SigValue3,SigValue4,SigValue5,SigValue6,SigValue7 : STD_LOGIC_VECTOR (31 downto 0);
	signal SigCDBData0,SigCDBData1,SigCDBData2,SigCDBData3,SigCDBData4,SigCDBData5,SigCDBData6,SigCDBData7 : STD_LOGIC_VECTOR (31 downto 0);

	signal Sig1,Sig2 : STD_LOGIC;
	--HEAD//TAIL
	signal SigHead, SigTail,SigTailB, SigRiIss , SigPrev,Flag : STD_LOGIC_VECTOR (4 downto 0);
	--RoB Full
	signal SigFull,SigIss : STD_LOGIC;
	--STATES
	type State is (StRst,StA,StB,StC);
	signal CrntState, NxtState: State;

begin


Reg1: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData1,
				  Riin => Ri,
				  Readyin => SigReadyIN1,
				  WrEn => SigBWrEn1,
				  CDBWrEn => SigCDBWrEn1,
				  Value => SigValue1,
				  Ri => SigRi1,
				  Ready => SigReady1);
Reg2: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData2,
				  Riin => Ri,
				  Readyin => SigReadyIN2,
				  WrEn => SigBWrEn2,
				  CDBWrEn => SigCDBWrEn2,
				  Value => SigValue2,
				  Ri => SigRi2,
				  Ready => SigReady2);
Reg3: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData3,
				  Riin => Ri,
				  Readyin => SigReadyIN3,
				  WrEn => SigBWrEn3,
				  CDBWrEn => SigCDBWrEn3, 
				  Value => SigValue3,
				  Ri => SigRi3,
				  Ready => SigReady3);
Reg4: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData4,
				  Riin => Ri,
				  Readyin => SigReadyIN4,
				  WrEn => SigBWrEn4,
				  CDBWrEn => SigCDBWrEn4,
				  Value => SigValue4,
				  Ri => SigRi4,
				  Ready => SigReady4);
Reg5: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData5,
				  Riin => Ri,
				  Readyin => SigReadyIN5,
				  WrEn => SigBWrEn5,
				  CDBWrEn => SigCDBWrEn5,
				  Value => SigValue5,
				  Ri => SigRi5,
				  Ready => SigReady5);
Reg6: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData6,
				  Riin => Ri,
				  Readyin => SigReadyIN6,
				  WrEn => SigBWrEn6,
				  CDBWrEn => SigCDBWrEn6,
				  Value => SigValue6,
				  Ri => SigRi6,
				  Ready => SigReady6);
				  
Reg7: RBuffer
	Port Map ( Clk => Clk,
				  Rst => Rst,
				  Valuein => SigCDBData7,
				  Riin => Ri,
				  Readyin => SigReadyIN7,
				  WrEn => SigBWrEn7,
				  CDBWrEn => SigCDBWrEn7,
				  Value => SigValue7,
				  Ri => SigRi7,
				  Ready => SigReady7);
				  
--------------------------------------------------------------------------------------------------------- TO RF/RNote	
process 
	begin
		wait until Clk'event and Clk ='1';
		--RESET
		if(Rst = '1') then	
		
			SigReadyIN0 <= '0';
			SigReadyIN1 <= '0';
			SigReadyIN2 <= '0';
			SigReadyIN3 <= '0';
			SigReadyIN4 <= '0';
			SigReadyIN5 <= '0';
			SigReadyIN6 <= '0';
			SigReadyIN7 <= '0';
		
			RF_Ri <= "00000";
			RF_WrEn <= '0';
			RF_Data <= "00000000000000000000000000000000";
			SigHead <= "00000";
			SigFull <= '0';
		else	
		--WRITE TO RF FROM ROB READY HEAD
			if (SigHead = "00001" and SigReady1 = '1' and SigCDBWrEn1 = '0') then
				SigHead <= "00010";
				RF_Ri <= SigRi1;
				RF_Data <= SigValue1;
				RF_WrEn <= '1';
				SigReadyIN1 <= '1';
				SigFull <= '0';
			elsif ( SigHead = "00010" and SigReady2 = '1' and SigCDBWrEn2 = '0') then
				SigHead <= "00011";
				RF_Ri <= SigRi2;
				RF_Data <= SigValue2;
				RF_WrEn <= '1';
				SigReadyIN2 <= '1';
				SigFull <= '0';
			elsif ( SigHead = "00011" and SigReady3 = '1' and SigCDBWrEn3 = '0') then
				SigHead <= "00100";
				RF_Ri <= SigRi3;
				RF_Data <= SigValue3;
				RF_WrEn <= '1';
				SigReadyIN3 <= '1';
				SigFull <= '0';
			elsif ( SigHead = "00100" and SigReady4 = '1' and SigCDBWrEn4 = '0') then
				SigHead <= "00101";
				RF_Ri <= SigRi4;
				RF_Data <= SigValue4;
				RF_WrEn <= '1';
				SigReadyIN4 <= '1';
				SigFull <= '0';
			elsif ( SigHead = "00101" and SigReady5 = '1' and SigCDBWrEn5 = '0') then
				SigHead <= "00110";
				RF_Ri <= SigRi5;
				RF_Data <= SigValue5;
				RF_WrEn <= '1';
				SigReadyIN5 <= '1';
				SigFull <= '0';
			elsif ( SigHead = "00110" and SigReady6 = '1' and SigCDBWrEn6 = '0') then
				SigHead <= "00111";
				RF_Ri <= SigRi6;
				RF_Data <= SigValue6;
				RF_WrEn <= '1';
				SigReadyIN6 <= '1';
				SigFull <= '0';
			elsif (SigHead = "00111" and SigReady7 = '1' and SigCDBWrEn7 = '0')  then
				SigHead <= "00001";
				RF_Ri <= SigRi7;
				RF_Data <= SigValue7;
				RF_WrEn <= '1';
				SigReadyIN7 <= '1';
				SigFull <= '0';
			else
				RF_WrEn <= '0';
				SigReadyIN7 <= '0';
				SigReadyIN0 <= '0';
				SigReadyIN1 <= '0';
				SigReadyIN2 <= '0';
				SigReadyIN3 <= '0';
				SigReadyIN4 <= '0';
				SigReadyIN5 <= '0';
				SigReadyIN6 <= '0';
				SigReadyIN7 <= '0';
			end if;
			
			if (SigHead = "00000" and WrEn = '1') then
				SigHead <= "00001";
			end if;
			
			if (SigTail = SigHead and WrEn = '1') then
				SigFull <= '1';
			end if;
		end if;
end process;
RoBHead <= SigHead;

--------------------------------------------------------------------------------------------------------- FULL RoB		

Full <= SigFull;	
--------------------------------------------------------------------------------------------------------- FROM ISSUE		
process
	begin	
		wait until Clk'event and Clk ='1';	
		--RESSET STATE
		if ( Rst = '1') then				
			SigBWrEn0 <= '0';
			SigBWrEn1 <= '0';
			SigBWrEn2 <= '0';
			SigBWrEn3 <= '0';
			SigBWrEn4 <= '0';
			SigBWrEn5 <= '0';
			SigBWrEn6 <= '0';
			SigBWrEn7 <= '0';	
			
			SigRiin0 <= "00000";
			SigRiin1 <= "00000";
			SigRiin2 <= "00000";
			SigRiin3 <= "00000";
			SigRiin4 <= "00000";
			SigRiin5 <= "00000";
			SigRiin6 <= "00000";
			SigRiin7 <= "00000";	
			
			SigTail <= "00001";
			SigRiIss <= Ri;

		else
		--FORM ISSUE // TAIL MOVEMENT
			SigRiIss <= Ri;
			if (SigHead /= SigTail and WrEn = '1' and SigFull = '0') then
				if ( SigTail = "00001" ) then
					if (SigHead = "00000") then
						SigReadyIN0 <= '1';
					else 
						SigReadyIN0 <= '0';
					end if;
					SigTailB <= SigTail;
					SigTail <= "00010";
					SigBWrEn1 <= '1';
					SigRiin1 <= SigRiIss;
					  
				elsif ( SigTail = "00010" ) then
					SigTailB <= SigTail;
					SigTail <= "00011";
					SigBWrEn2 <= '1';
					SigRiin2 <= SigRiIss;
					  
				elsif ( SigTail = "00011" ) then
					SigTailB <= SigTail;
					SigTail <= "00100";
					SigBWrEn3 <= '1';
					SigRiin3 <= SigRiIss;
					  
				elsif ( SigTail = "00100" ) then
					SigTailB <= SigTail;
					SigTail <= "00101";
					SigBWrEn4 <= '1';
					SigRiin4 <= SigRiIss;
					  
				elsif ( SigTail = "00101" ) then
					SigTailB <= SigTail;
					SigTail <= "00110";
					SigBWrEn5 <= '1';
					SigRiin5 <= SigRiIss;
					  
				elsif ( SigTail = "00110" ) then
					SigTailB <= SigTail;
					SigTail <= "00111";
					SigBWrEn6 <= '1';
					SigRiin6 <= SigRiIss;
					  
				elsif ( SigTail = "00111" ) then
					SigTailB <= SigTail;
					SigTail <= "00001";
					SigBWrEn7 <= '1';
					SigRiin7 <= SigRiIss;
					  
				else 
					null;
				end if;
				

			else 
				SigBWrEn1 <= '0';
				SigBWrEn2 <= '0';
				SigBWrEn3 <= '0';
				SigBWrEn4 <= '0';
				SigBWrEn5 <= '0';
				SigBWrEn6 <= '0';
				SigBWrEn7 <= '0';
			end if;
		end if;
end process;
RoBTail <= SigTailB;	

--------------------------------------------------------------------------------------------------------- FROM CDB				  
process
	begin
		wait until Clk'event and Clk ='1';
		--RESSET STATE
		if ( Rst = '1') then
			
			SigCDBWrEn0 <= '0';
			SigCDBWrEn1 <= '0';
			SigCDBWrEn2 <= '0';
			SigCDBWrEn3 <= '0';
			SigCDBWrEn4 <= '0';
			SigCDBWrEn5 <= '0';
			SigCDBWrEn6 <= '0';
			SigCDBWrEn7 <= '0';			
				
			SigCDBData0 <= "00000000000000000000000000000000";
			SigCDBData1 <= "00000000000000000000000000000000";
			SigCDBData2 <= "00000000000000000000000000000000";
			SigCDBData3 <= "00000000000000000000000000000000";
			SigCDBData4 <= "00000000000000000000000000000000";
			SigCDBData5 <= "00000000000000000000000000000000";
			SigCDBData6 <= "00000000000000000000000000000000";
			SigCDBData7 <= "00000000000000000000000000000000";
			
			Flag <= "00000";
			
			
		--GET CDB INPUT
		else 

		
		
			if ( CDBQ = "00001" and SigReady1 = '0') then
				SigCDBData1 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn1 <= '0';
				else
					SigCDBWrEn1 <= '1';
				end if;
				SigCDBWrEn2 <= '0';
				SigCDBWrEn3 <= '0';
				SigCDBWrEn4 <= '0';
				SigCDBWrEn5 <= '0';
				SigCDBWrEn6 <= '0';
				SigCDBWrEn7 <= '0';		
				Flag <= CDBQ;
			elsif ( CDBQ = "00010" and SigReady2 = '0') then
				SigCDBData2 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn2 <= '0';
				else
					SigCDBWrEn2 <= '1';
				end if;
				SigCDBWrEn1 <= '0';
				SigCDBWrEn3 <= '0';
				SigCDBWrEn4 <= '0';
				SigCDBWrEn5 <= '0';
				SigCDBWrEn6 <= '0';
				SigCDBWrEn7 <= '0';
				Flag <= CDBQ;
			elsif ( CDBQ = "00011" and SigReady3 = '0') then
				SigCDBData3 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn3 <= '0';
				else
					SigCDBWrEn3 <= '1';
				end if;
				SigCDBWrEn1 <= '0';
				SigCDBWrEn2 <= '0';
				SigCDBWrEn4 <= '0';
				SigCDBWrEn5 <= '0';
				SigCDBWrEn6 <= '0';
				SigCDBWrEn7 <= '0';
				Flag <= CDBQ;
			elsif ( CDBQ = "00100" and SigReady4 = '0') then
				SigCDBData4 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn4 <= '0';
				else
					SigCDBWrEn4 <= '1';
				end if;
				SigCDBWrEn1 <= '0';
				SigCDBWrEn3 <= '0';
				SigCDBWrEn2 <= '0';
				SigCDBWrEn5 <= '0';
				SigCDBWrEn6 <= '0';
				SigCDBWrEn7 <= '0';
				Flag <= CDBQ;
			elsif ( CDBQ = "00101" and SigReady5 = '0') then
				SigCDBData5 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn5 <= '0';
				else
					SigCDBWrEn5 <= '1';
				end if;
				SigCDBWrEn1 <= '0';
				SigCDBWrEn3 <= '0';
				SigCDBWrEn4 <= '0';
				SigCDBWrEn2 <= '0';
				SigCDBWrEn6 <= '0';
				SigCDBWrEn7 <= '0';
				Flag <= CDBQ;
			elsif ( CDBQ = "00110" and SigReady6 = '0') then
				SigCDBData6 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn6 <= '0';
				else
					SigCDBWrEn6 <= '1';
				end if;
				SigCDBWrEn1 <= '0';
				SigCDBWrEn3 <= '0';
				SigCDBWrEn4 <= '0';
				SigCDBWrEn5 <= '0';
				SigCDBWrEn2 <= '0';
				SigCDBWrEn7 <= '0';
				Flag <= CDBQ;
			elsif ( CDBQ = "00111" and SigReady7 = '0') then
				SigCDBData7 <= CDBData;
				if(Flag = CDBQ)then
					SigCDBWrEn7 <= '0';
				else
					SigCDBWrEn7 <= '1';
				end if;
				SigCDBWrEn1 <= '0';
				SigCDBWrEn3 <= '0';
				SigCDBWrEn4 <= '0';
				SigCDBWrEn5 <= '0';
				SigCDBWrEn6 <= '0';
				SigCDBWrEn2 <= '0';
				Flag <= CDBQ;
			end if;
		end if;	
end process;
			  				  				  
			  		  
		  
process 
	begin
		wait until Clk'event and Clk ='1';
		--RESET
		if(Rst = '1') then
			Ready1 <= '0';
			Vj <= "00000000000000000000000000000000";
		else		
			if ( Rj = "00001" ) then
				Ready1 <= SigReady1;
			   Vj <= SigValue1;
			elsif ( Rj = "00010" ) then
				Ready1 <= SigReady2;
			   Vj <= SigValue2;
			elsif ( Rj = "00011" ) then
				Ready1 <= SigReady3;
			   Vj <= SigValue3;
			elsif ( Rj = "00100" ) then
				Ready1 <= SigReady4;
			   Vj <= SigValue4;
			elsif ( Rj = "00101" ) then
				Ready1 <= SigReady5;
			   Vj <= SigValue5;
			elsif ( Rj = "00110" ) then
				Ready1 <= SigReady6;
			   Vj <= SigValue6;
			elsif ( Rj = "00111" ) then
				Ready1 <= SigReady7;
			   Vj <= SigValue7;
			else
				Ready1 <= '0';
			end if;

		end if;
end process;
	
	
	
	process 
	begin
		wait until Clk'event and Clk ='1';
		--RESET
		if(Rst = '1') then
			Ready2 <= '0';
			Vk <= "00000000000000000000000000000000";
		else		
			if ( Rk = "00001" ) then
				Ready2 <= SigReady1;
			   Vk <= SigValue1;
			elsif ( Rk = "00010" ) then
				Ready2 <= SigReady2;
			   Vk <= SigValue2;
			elsif ( Rk = "00011" ) then
				Ready2 <= SigReady3;
			   Vk <= SigValue3;
			elsif ( Rk = "00100" ) then
				Ready2 <= SigReady4;
			   Vk <= SigValue4;
			elsif ( Rk = "00101" ) then
				Ready2 <= SigReady5;
			   Vk <= SigValue5;
			elsif ( Rk = "00110" ) then
				Ready2 <= SigReady6;
			   Vk <= SigValue6;
			elsif ( Rk = "00111" ) then
				Ready2 <= SigReady7;
			   Vk <= SigValue7;
			else
				Ready2 <= '0';
			end if;

		end if;

end process;
end Behavioral;

