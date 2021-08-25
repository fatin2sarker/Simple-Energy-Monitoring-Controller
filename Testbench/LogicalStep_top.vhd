
-------------------------------------------------The Pushbuttons are not inverted, so pb is always active high(1) and active low(0) when pressed---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab3_top is port (
   clkin_50		: in	std_logic;
	pb				: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the switch content
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	
); 
end LogicalStep_Lab3_top;


architecture Energy_Monitor of LogicalStep_Lab3_top is

--
------------------------------------------------------------------------- Components Used----------------------------------------------------------------------------------------------------------
--SevenSegment----------------------------------------------------------------------------------------------
		component SevenSegment port (
			
			hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
			
			sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
		); 
		end component;
		
--segment_7_mux---------------------------------------------------------------------------------------------
		component segment7_mux port (
					 clk        : in  std_logic := '0';
					 DIN0 		: in  std_logic_vector(6 downto 0);	
					 DIN1 		: in  std_logic_vector(6 downto 0);
					 DOUT			: out	std_logic_vector(6 downto 0);
					 DIG1			: out	std_logic;
					 DIG2			: out	std_logic
				  );
		end component;
		
--mux-------------------------------------------------------------------------------------------------------
		component mux port (
			
						pb             : in  std_logic;   ------pb(3)
						B		         : in std_logic_vector(3 downto 0); 
						output         : out std_logic_vector(3 downto 0);    ----Bmux
						output1         : out std_logic       -----leds(7) for vacation mode 
		); 
		end component;
		
--window_door-----------------------------------------------------------------------------------------------

		component window_door is port (
			
			pb       : in  std_logic;  
			pb1      : in  std_logic;	
			output   : out std_logic;
			output1  : out std_logic
		); 
		end component;
--EMC-------------------------------------------------------------------------------------------------------		
		component EMC is port (
					pb               : in  std_logic;     ------pb(0) for the door
               pb1              : in  std_logic;	--------pb(1) for the window 
					AGTB: in std_logic;
					AEQB: in std_logic;
					ALTB: in std_logic;
					output: out std_logic_vector(3 downto 0)
		); 
		end component;
--Testbench-------------------------------------------------------------------------------------------------		
		component Testbench is port (
					pb    : in  std_logic;
					current_temp: in std_logic_vector (3 downto 0);
					desired_temp: in std_logic_vector (3 downto 0);
					AGTB: in std_logic;
					AEQB: in std_logic;
					ALTB: in std_logic;
					output: out std_logic
 
		); 
		end component;
--Compx4----------------------------------------------------------------------------------------------------
		component Compx4 port (
		A: in std_logic_vector (3 downto 0);
		B: in std_logic_vector (3 downto 0);
		AGTB: out std_logic;
		AEQB: out std_logic;
		ALTB: out std_logic
		); 
		end component;
		
		
		
-- SIGNALS USED -------------------------------------------------------------------------------------------

	
	
	signal current_temp: std_logic_vector (3 downto 0);
	signal desired_temp: std_logic_vector (3 downto 0);
	
	
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	
	signal B_mux : std_logic_vector(3 downto 0);
	
	signal AGTB: std_logic;
	signal AEQB: std_logic;
	signal ALTB: std_logic;
	
	
-- Here the circuit begins----------------------------------------------------------------------------------

begin

current_temp <= sw(3 downto 0);
desired_temp <= sw(7 downto 4);

------------------------------------------------------------------------------------------------------------
		       
	INST1: mux port map (pb(3),desired_temp, B_mux, leds(7));  -----mux outputs (B_mux) = desired_temp if pb(3) active high and (B_mux) = Vacation value (0100) if pb(3) active low.  
	
	INST2: window_door port map (pb(0), pb(1), leds(4), leds(5)); -----windows pb(0) to leds(4) and doors pd(1) to leds(5)
	
   INST3: SevenSegment port map (current_temp, seg7_A); ----current temp binary value to hex value   
	
	INST4: SevenSegment port map (B_mux, seg7_B);   -----b_mux binary value to hex value 
	
	INST5: segment7_mux port map (clkin_50, seg7_A,seg7_B,seg7_data,seg7_char1,seg7_char2);   -----display current temp (sw 3 downto 0) and b-mux (sw 7 downto 4)
                                                                                             -----value on the DIGIT 2 and DIGIT 1 respectively 
	
	INST6: Compx4 port map (current_temp, B_mux, AGTB, AEQB, ALTB);  --compare between current value with desired value or Vacation value to help turn on AC/Furnace/Blower
	
	INST7: Testbench port map (pb(2), current_temp, desired_temp, AGTB, AEQB, ALTB,leds(6));  -----testbench active with pb(2) and displays TRUE or FALSE on leds(6)
	
	INST8: EMC port map (pb(0), pb(1), AGTB, AEQB, ALTB, leds(3 downto 0)); -----ac, furnance, blower leds(3 dpwnto 0) while window pb(0), doors pb(1) needs to be closed 
	 
 
end Energy_Monitor;

