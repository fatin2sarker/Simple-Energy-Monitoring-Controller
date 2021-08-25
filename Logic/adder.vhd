library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is port (
   hexA	         : in  std_logic_vector(3 downto 0);  
	hexB	         : in  std_logic_vector(3 downto 0); 
	sum            : out std_logic_vector (7 downto 0)    --8 bit sum output 
	
); 
end adder;

architecture Behavioral of adder is

	signal add_inpA : std_logic_vector (7 downto 0);
   signal add_inpB : std_logic_vector (7 downto 0);
	


begin

add_inpA <=  "0000" & hexA;   ---concatenate the 4 bit 4 to 8 bit 8
add_inpB <=  "0000" & hexB;

sum (7 downto 0) <= std_logic_vector(unsigned(add_inpA) + unsigned(add_inpB));    --recasting

										
end architecture Behavioral; 