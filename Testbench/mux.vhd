library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is port (
   
	pb             : in  std_logic;   ------pb(3)
	B		         : in std_logic_vector(3 downto 0); 
	output         : out std_logic_vector(3 downto 0);    ----Bmux
	output1         : out std_logic       -----leds(7) for vacation mode 
   	
); 
end mux;

architecture Behavioral of mux is

 signal vacation	:std_logic_vector (3 downto 0);
 signal vacation1	:std_logic;

-----mux outputs (B_mux) = desired_temp if pb(3) active high and (B_mux) = Vacation value (0100) if pb(3) active low----------------------------
begin

vacation <= "0100";
vacation1 <= '1';

with pb select 
							 output <=  Vacation when '0',
										
											 B when others;	             --------input value determination for comparator
											 
with pb select											 
				          output1 <=  Vacation1 when '0',           -------display for led(7)
							 				 	
											 '0' when others;								 
										
end architecture Behavioral; 



