library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- defining a full adder for subsequent evaluation

entity fa is
    port (  
	         a : in  STD_LOGIC;
            b : in  STD_LOGIC;
			   cin  : in  STD_LOGIC;
			   o  : out STD_LOGIC;
			   cout : out STD_LOGIC
			);
end fa;

architecture arc_fa of fa is

signal s1, s2, s3, s4: STD_LOGIC;

begin

 s1   <= a and b;
 s2   <= a and cin;
 s3   <= b and cin;
 cout <= s1 or s2 or s3;
 o    <= a xor b xor cin;


end arc_fa;

