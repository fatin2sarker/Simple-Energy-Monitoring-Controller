library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Compx4 is port (
						A: in std_logic_vector (3 downto 0);    ----
						B: in std_logic_vector (3 downto 0);    ----
						AGTB: out std_logic;
						AEQB: out std_logic;
						ALTB: out std_logic
	
); 
end Compx4;

architecture Behavioral of Compx4 is

		component Compx1 port( 
					A,B : IN STD_LOGIC; AGTB, AEQB, ALTB : OUT STD_LOGIC
		 );
		end component Compx1;
		

  
	signal A0GTB0     : std_logic;
	signal A0EQB0     : std_logic;
	signal A0LTB0     : std_logic;
	
	signal A1GTB1     : std_logic;
	signal A1EQB1     : std_logic;
	signal A1LTB1     : std_logic;
	
	signal A2GTB2     : std_logic;
	signal A2EQB2     : std_logic;
	signal A2LTB2     : std_logic;
	
	signal A3GTB3     : std_logic;
	signal A3EQB3     : std_logic;
	signal A3LTB3     : std_logic;

----------------------------------------------------------
begin
		INST1: Compx1 port map (A(0), B(0), A0GTB0, A0EQB0, A0LTB0);
		INST2: Compx1 port map (A(1), B(1), A1GTB1, A1EQB1, A1LTB1);
		INST3: Compx1 port map (A(2), B(2), A2GTB2, A2EQB2, A2LTB2);
		INST4: Compx1 port map (A(3), B(3), A3GTB3, A3EQB3, A3LTB3);
		
		
		AGTB <= A3GTB3 OR ( A3EQB3 AND A2GTB2) OR (A3EQB3 AND A2EQB2 AND A1GTB1) OR (A3EQB3 AND A2EQB2 AND A1EQB1 AND A0GTB0);       ----- A>B
		AEQB <= A0EQB0 AND A1EQB1 AND A2EQB2 AND A3EQB3;
		ALTB <= A3LTB3 OR ( A3EQB3 AND A2LTB2) OR (A3EQB3 AND A2EQB2 AND A1LTB1) OR (A3EQB3 AND A2EQB2 AND A1EQB1 AND A0LTB0);       ------A<B


										
end architecture Behavioral; 
