library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- defining a 16 bit full adder using full adders


entity fa16 is
    port ( 
	        a,b  : in std_logic_vector(15 downto 0);
	        cin  : in std_logic;
			  o    : out std_logic_vector(15 downto 0);
			  cout : out std_logic
			 );
end fa16;

architecture arc_fa16 of fa16 is

component fa is
  port ( 
         a    : in  STD_LOGIC;
         b    : in  STD_LOGIC;
		   cin  : in  STD_LOGIC;
		   o    : out STD_LOGIC;
		   cout : out STD_LOGIC
		 );
end component;

signal passing_carry : std_logic_vector(15 downto 1); 

begin

add1 : fa port map (a=>a(0),b=>b(0),cin=>cin,o=>o(0),cout=>passing_carry(1));
add2 : fa port map (a=>a(1),b=>b(1),cin=>passing_carry(1),o=>o(1),cout=>passing_carry(2));
add3 : fa port map (a=>a(2),b=>b(2),cin=>passing_carry(2),o=>o(2),cout=>passing_carry(3));
add4 : fa port map (a=>a(3),b=>b(3),cin=>passing_carry(3),o=>o(3),cout=>passing_carry(4));
add5 : fa port map (a=>a(4),b=>b(4),cin=>passing_carry(4),o=>o(4),cout=>passing_carry(5));
add6 : fa port map (a=>a(5),b=>b(5),cin=>passing_carry(5),o=>o(5),cout=>passing_carry(6));
add7 : fa port map (a=>a(6),b=>b(6),cin=>passing_carry(6),o=>o(6),cout=>passing_carry(7));
add8 : fa port map (a=>a(7),b=>b(7),cin=>passing_carry(7),o=>o(7),cout=>passing_carry(8));
add9 : fa port map (a=>a(8),b=>b(8),cin=>passing_carry(8),o=>o(8),cout=>passing_carry(9));
add10: fa port map (a=>a(9),b=>b(9),cin=>passing_carry(9),o=>o(9),cout=>passing_carry(10));
add11: fa port map (a=>a(10),b=>b(10),cin=>passing_carry(10),o=>o(10),cout=>passing_carry(11));
add12: fa port map (a=>a(11),b=>b(11),cin=>passing_carry(11),o=>o(11),cout=>passing_carry(12));
add13: fa port map (a=>a(12),b=>b(12),cin=>passing_carry(12),o=>o(12),cout=>passing_carry(13));
add14: fa port map (a=>a(13),b=>b(13),cin=>passing_carry(13),o=>o(13),cout=>passing_carry(14));
add15: fa port map (a=>a(14),b=>b(14),cin=>passing_carry(14),o=>o(14),cout=>passing_carry(15));
add16: fa port map (a=>a(15),b=>b(15),cin=>passing_carry(15),o=>o(15),cout=>cout);

end arc_fa16;

