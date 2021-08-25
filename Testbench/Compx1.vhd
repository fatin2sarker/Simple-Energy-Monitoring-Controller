LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
Entity Compx1 is
port( 
      A,B : IN STD_LOGIC; AGTB, AEQB, ALTB : OUT STD_LOGIC
	 );
end Compx1;


architecture simple_gates of Compx1 is
begin
			
			AGTB <= A AND (NOT B);            --- true if A>B
			AEQB <= A XNOR B;                 --- true if A=B
			ALTB <= (NOT A) AND B;            --- true if A<B  

end simple_gates;

















