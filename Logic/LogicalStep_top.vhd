library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;
                                                                                                         
architecture SimpleCircuit of LogicalStep_Lab2_top is
-- Components Used ---


------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	
--VHDL Component Declaration for seg7_mux (Fig 66)-----------------	
	component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN0 		: in  std_logic_vector(6 downto 0);	
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG1			: out	std_logic;
			 DIG2			: out	std_logic
        );
	end component;


---component of mux.vhdl----------------------------------------------------------------	
	component mux port (
		
		pushbutton     : in  std_logic_vector(3 downto 0);
		hex_A		   :in std_logic_vector(3 downto 0);
		hex_B 			:in std_logic_vector(3 downto 0); 
		sum	         : in  std_logic_vector(7 downto 0);    --adder output         
		muxout         : out std_logic_vector(7 downto 0)
	); 
	end component;
	
---component of mux1.vhdl----------------------------------------------------------------	
	component mux1 port (
		
		pushbutton     : in  std_logic_vector(3 downto 0);
		hex_A		   :in std_logic_vector(3 downto 0);
		hex_B 			:in std_logic_vector(3 downto 0); 
		sum	         : in  std_logic_vector(7 downto 0);    --adder output         
		muxout         : out std_logic_vector(7 downto 0)
	); 
	end component;
	
	
---component of adder.vhdl-----------------------------------------------------------------
	component adder port (
		hexA	         : in  std_logic_vector(3 downto 0);  
		hexB	         : in  std_logic_vector(3 downto 0); 
		sum            : out std_logic_vector (7 downto 0)   --8 bit sum output 
		
	); 
	end component;
--------------------------------------------------------------------


--  signals
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);   --OPERAND1
	signal seg7_B		: std_logic_vector(6 downto 0);
	signal hex_B		: std_logic_vector(3 downto 0);   --OPERAND2
	signal sum        : std_logic_vector(7 downto 0);  
	signal muxout     : std_logic_vector(7 downto 0);
	
	
	
-- Here the circuit begins
begin
  
	hex_A <= sw(3 downto 0);    
	hex_B <= sw(7 downto 4);
	
	
--component hookup
--generate the seven segment coding

	INST1: adder port map (hex_A, hex_B, sum);
	INST2: mux port map (pb, hex_A, hex_B, sum, muxout);            ------display "88" and all the LEDS ON when more than one pb is active
	INST3: SevenSegment port map (muxout(3 downto 0), seg7_A);     -----half 8bit muxout to two 4bit
	INST4: SevenSegment port map (muxout(7 downto 4), seg7_B);
	INST5: segment7_mux port map (clkin_50, seg7_A,seg7_B,seg7_data,seg7_char1,seg7_char2);     
	INST6: mux1 port map (pb, hex_A, hex_B, sum, leds);            ------display on the LEDS and all the LEDS ON when more than one pb is active
	
 
end SimpleCircuit;

