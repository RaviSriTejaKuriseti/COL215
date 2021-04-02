ENTITY four_to_seven IS
PORT(Q:IN bit_vector(3 DOWNTO 0); Y:OUT bit_vector(6 DOWNTO 0));
END four_to_seven;

ARCHITECTURE fts OF four_to_seven IS
SIGNAL A0:BIT;
SIGNAL A1:BIT;
SIGNAL A2:BIT;
SIGNAL A3:BIT;
BEGIN 
A0<= NOT Q(0);
A1<= NOT Q(1);
A2<= NOT Q(2);
A3<= NOT Q(3);
B<=A0 AND A1;
C<=A0 OR A1;
D1<=Q(0) XOR Q(1);
D2<=Q(0) XOR Q(2);
D3<= Q(1) XOR Q(2);

Y(6)<=(Q(3) OR D3) OR (Q(1) AND A0);
Y(5)<=(Q(3) OR B) OR (Q(2) AND C);
Y(4)<=A0 AND (Q(1) OR A2);
Y(3)<=(Q(3) OR (A2 AND C)) OR D1;
Y(2)<=(Q(0) OR Q(2)) OR A1;
Y(1)<=(A2 OR NOT(D1));
Y(0)<=(Q(1) OR Q(3)) OR NOT(D2);

END ARCHITECTURE fts;


#####
ENTITY eight_to_two_fours IS
PORT(I:IN bit_vector(7 DOWNTO 0); Z1:OUT bit_vector(3 DOWNTO 0); Z2:OUT bit_vector(3 DOWNTO 0));
END four_to_seven;

ARCHITECTURE ettf OF eight_to_two_fours IS
SIGNAL J0:BIT;
SIGNAL J1:BIT;
SIGNAL J2:BIT;
SIGNAL J3:BIT;
SIGNAL J4:BIT;
SIGNAL J5:BIT;
BEGIN 
J0<=NOT I(0);
J1<=NOT I(1);
J2<=NOT I(2);
J3<=NOT I(3);
J4<=NOT I(4);
J5<= J4 AND I(2);

Z1(3)<=0
Z1(2)<=0
Z1(1)<=I(4) AND I(2)
Z1(0)<=I(3) AND (I(1) OR I(2)) OR (I(4) AND J2)
Z2(3)<=((I(3) AND J1) OR (I(4) AND I(1))) AND J2
Z2(2)<=J5 AND (J3  OR I(1)) OR ((J2 AND J1) AND I(4))
Z2(1)<=(J4 AND (J3 AND J1)) OR ((J3 AND I(2)) AND I(1)) OR ((I(3) AND I(2)) AND J1) OR ((I(4) AND J2) AND J1)
Z2(0)<=I(0)

END ARCHITECTURE ettf;
#####

ENTITY mod_six IS
PORT(clk:IN BIT; SIX:OUT bit_vector(3 DOWN TO 0))
END modsix;

ARCHITECTURE ms OF mod_six IS
SIGNAL t<=bit_vector(3 DOWN TO 0)
BEGIN
PROCESS (clk) BEGIN
IF (clk = '0' AND clk'EVENT) THEN
IF (t = “0110”) THEN t <= “0000”;
ELSE t <= t + 1;
END IF;
END IF;
END PROCESS;
SIX <= t;
END ARCHITECTURE ms;

######
ENTITY mod_ten IS
PORT(ck:IN BIT; TEN:OUT bit_vector(3 DOWN TO 0))
END modten;

ARCHITECTURE mt OF mod_ten IS
SIGNAL n<=bit_vector(3 DOWN TO 0)
BEGIN
PROCESS (ck) BEGIN
IF (ck = '0' AND ck'EVENT) THEN
IF (n = “1010”) THEN n <= “0000”;
ELSE n <= n + 1;
END IF;
END IF;
END PROCESS;
TEN <= n;
END ARCHITECTURE mt;
#####

ENTITY hours IS
PORT(clo:IN BIT; TFR:OUT bit_vector(7 DOWN TO 0))
END hours;


ARCHITECTURE hs OF hours IS
SIGNAL hh<=bit_vector(7 DOWN TO 0)
BEGIN
PROCESS (clo) BEGIN
IF (clo = '0' AND clo'EVENT) THEN
IF (hh = “00011000”) THEN hh <= “00000000”;
ELSE hh <= hh + 1;
END IF;
END IF;
END PROCESS;
TFR <= hh;
END ARCHITECTURE hs;
#######

ENTITY flash IS
PORT(w:IN BIT; x:OUT BIT)
END flash

ARCHITECTURE blink OF flash IS
BEGIN
PROCESS(clk) BEGIN
IF(clo='0' AND clk'EVENT) THEN
x<=w;
ELSE x<=0;
END IF;
END PROCESS;
END ARCHITECTURE blink;












