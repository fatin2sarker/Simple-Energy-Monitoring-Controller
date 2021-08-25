library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EMC is port (
					pb               : in  std_logic;     ------pb(0) for the door
               pb1               : in  std_logic;	--------pb(1) for the window 
					AGTB: in std_logic;
					AEQB: in std_logic;
					ALTB: in std_logic;
					output: out std_logic_vector(3 downto 0)
 
); 
end EMC;

architecture Behavioral of EMC is             -----Energy Monitoring Controller
      
----------------------------------------------------------
begin


EMC:
PROCESS (pb, pb1, AEQB, ALTB, AGTB) is 

begin
		
		IF (AEQB = '1') THEN 
		output <= "0010";              ----at temp 
		
		ELSIF ((AGTB = '1') AND (pb ='1') AND (pb1 ='1')) THEN 
		output <= "1100";             ----ac on and blower on, windows, doors closed
		
		ELSIF ((ALTB = '1') AND (pb ='1') AND (pb1 = '1')) THEN 
		output <= "1001";            ----furnace on and blower on, windows, doors closed
		
		ELSE
		 output <= "0000";
		 
		END IF;
		
		
end process;
							  

										
end architecture Behavioral; 
