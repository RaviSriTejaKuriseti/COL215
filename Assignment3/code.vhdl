ENTITY helper_circuit IS
PORT(A:IN bit; B:IN bit; Y:OUT bit_vector(1 DOWN TO 0));
END helper_circuit;


ARCHITECTURE archi OF helper_circuit IS
BEGIN
PROCESS(CLOCK) BEGIN
 CASE STATE IS
 WHEN S0=>
  IF A='1' THEN
   IF B='0' THEN
   STATE<=S1;
  ELSE STATE<=S2;
 ENDIF;
WHEN OTHERS=>
IF A='1' THEN STATE<=S0;
ENDIF;
END CASE;
END PROCESS;
 
PROCESS(STATE,A,B) BEGIN
CASE STATE IS
WHEN S0=>
IF A='1' AND B='0' THEN Y<=01;
ELSIF A='1' AND B='1' THEN Y<=10;
ENDIF;

WHEN OTHERS
IF A='1' THEN Y<=00;
ELSE Y<=11;
END IF;

END CASE;
END PROCESS;

 END ARCHITECTURE archi;

#######################

ENTITY final_circuit IS
PORT(
A_in:IN BIT;
B_in:IN BIT;
clk:IN std_logic;
ctrl:IN std_logic;
IMAGE_ADDRESS:IN std_logic_vector(15 DOWN TO 0);
COEFF_ADDRESS:IN std_logic_vector(4 DOWN TO 0);
 )
END final_circuit;


ARCHITECTURE multiplier OF final_circuit IS

SIGNAL X:std_logic_vector(1 DOWN TO 0);
SIGNAL AA:std_logic;
SIGNAL AB:std_logic;
SIGNAL ZZ:std_logic_vector(7 DOWN TO 0);
SIGNAL YY: std_logic_vector(8 DOWN TO 0);
SIGNAL READROM:std_logic;
SIGNAL SUM:std_logic_vector(17 downto 0);
SIGNAL TEMP:std_logic;
SIGNAL ADDEND1:std_logic_vector(17 downto 0);
SIGNAL ADDEND2:std_logic_vector(17 downto 0);
SIGNAL D:std_logic_vector(17 downto 0);
SIGNAL OUT: std_logic_vector(7 DOWN TO 0);


COMPONENT RAM_64Kx8 PORT MAP(
clock=> clk;
read_enable=> AA;
write_enable => AB;
address=>IMAGE_ADDRESS;
data_in =>ZZ;
data_out =>OUT;

)
END COMPONENT;

COMPONENT ROM_32X9 PORT MAP(
clock => clk;
read_enable => READROM;
address : COEFF_ADDRESS; 
data_out : YY;

)
END COMPONENT;
COMPONENT MAC PORT MAP(
clock => clk;
control=>TEMP;
data_in1=>ADDEND1;
data_in2 =>ADDEND2;
data_out=>SUM; 

)
END COMPONENT;
COMPONENT helper_circuit MAP(
A => A_in;
B => B_in;
Y=>X;

)
END COMPONENT;

BEGIN
IF X='01' THEN 
 for I in 1 to m-2 loop
   for J in 1 to n-2 loop
   D=0;
   for i in -1 to 1 loop
     for j in -1 to 1 loop
  SUM+=IMAGE_ADDR(i+I,j+J)*COEFF_ADDR(i,j);
        D=D+SUM;
   for L in 1 to 7 loop
  D=right_shift(D);
  IF D(0) AND 1 THEN 
   write_to_RAM(0);
 ELSE
   write_to_RAM(D);
 ENDIF;
  
ELSIF  X='10' THEN 

 for I in 1 to m-2 loop
   for J in 1 to n-2 loop
   D=0;
   for i in -1 to 1 loop
     for j in -1 to 1 loop

  SUM+=IMAGE_ADDR(i+I,j+J)*COEFF_ADDR(i+2^16,j+2^16);
        D=D+SUM;
       
   for L in 1 to 7 loop
  D=right_shift(D);
  IF D(0) AND 1 THEN 
   write_to_RAM(0);
 ELSE
   write_to_RAM(D);
 ENDIF;
  
END IF;

END ARCHITECTURE;






