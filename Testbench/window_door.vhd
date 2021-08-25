library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity window_door is port (
   
	pb       : in  std_logic;  -----------pb(0)
   pb1      : in  std_logic;	-----------pb(1)
	output   : out std_logic;  -----------leds(4)
	output1  : out std_logic   -----------leds(5)
); 
end window_door;

architecture Behavioral of window_door is
-----windows pb(0) to leds(4) and doors pd(1) to leds(5)-----------------------------
begin


  with pb select output <= '1' when '0',      ----------functionality for windows 
                           '0' when others; 
									
									
									
  with pb1 select output1 <= '1' when '0',     ----------functionality for doors
                           '0' when others; 
									
									
							
										
end architecture Behavioral; 





