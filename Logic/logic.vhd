library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic is port (
	
	pb     : in  std_logic_vector(3 downto 0);
	hexA		   :in std_logic_vector(3 downto 0);
	hexB 			:in std_logic_vector(3 downto 0);
   output       :out std_logic_vector(7 downto 0)
	
); 
end logic;

architecture Behavioral of logic is



begin

  
	with pb select
						output <= ("0000" & (hexA AND hexB)) when "0001",    ---AND
									 ("0000" & (hexA OR hexB)) when "0010",    ---OR
									 ("0000" & (hexA XOR hexB)) when "0100";    ---XOR
	
	
										
end architecture Behavioral; 