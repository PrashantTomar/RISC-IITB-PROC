library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- defining a 2-to-4 multiplexer for subsequent evaluation

entity m24 is
    Port ( c0      : in  STD_LOGIC;
           c1      : in  STD_LOGIC;
			  a,b,c,d : in STD_LOGIC;
			  o       : out STD_LOGIC
			 );
end m24;

architecture arc_m24 of m24 is

 signal s1,s2,s3,s4 : std_logic;

begin
 
 s1 <= (not c0) and (not c1) and a;
 s2 <= (c0) and (not c1) and b;
 s3 <= (not c0) and c1 and c;
 s4 <= c0 and c1 and d;
 o  <= s1 or s2 or s3 or s4;
 

end arc_m24;

