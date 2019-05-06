library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- definig a 2-to-1 multiplexer for subsequent evaluation

entity m12 is
    Port ( i : in  STD_LOGIC;
	        a : in  STD_LOGIC;
			  b : in  STD_LOGIC;
	        o : out STD_LOGIC
			 );
end m12;

architecture arc_m12 of m12 is

begin

 o <= ((not i) and a) or (i and b);

end arc_m12;

