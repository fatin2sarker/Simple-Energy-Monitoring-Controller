library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Testbench is port (
					pb          : in  std_logic;
					current_temp: in std_logic_vector (3 downto 0);
					desired_temp: in std_logic_vector (3 downto 0);
					AGTB: in std_logic;
					AEQB: in std_logic;
					ALTB: in std_logic;
					output: out std_logic
); 
end  Testbench;

architecture Behavioral of Testbench is             
         
	
	signal TEST_PASS: std_logic;
	
----------------------------------------------------------
begin

Testbench:
PROCESS (pb, current_temp, desired_temp, AGTB, AEQB, ALTB) is 

variable EQ_PASS, LT_PASS, GT_PASS :std_logic := '0';

begin
		IF ((current_temp = desired_temp) AND (AEQB ='1')) THEN 
		EQ_PASS := '1';
		GT_PASS := '0';
		LT_PASS := '0';
		
		ELSIF ((current_temp > desired_temp) AND (AGTB ='1')) THEN 
		EQ_PASS := '0';
		GT_PASS := '1';
		LT_PASS := '0';
		
		ELSIF ((current_temp < desired_temp) AND (ALTB ='1')) THEN 
		EQ_PASS := '0';
		GT_PASS := '0';
		LT_PASS := '1';
		
		ELSE
		EQ_PASS := '0';
		GT_PASS := '0';
		LT_PASS := '0';
		
		END IF;
		TEST_PASS <= (NOT pb) AND (EQ_PASS OR GT_PASS OR LT_PASS);      ----The Pushbuttons are not inverted, so pb is always active high(1) and active low(0) when pressed------
		output <= TEST_PASS;                                            -------output on leds(6)
		   	
end process;


										
end architecture Behavioral; 
