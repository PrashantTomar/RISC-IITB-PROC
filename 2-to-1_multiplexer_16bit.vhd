library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- defining a 16 bit multiplexer from 2-to-1 multiplexers

entity m1216 is
    Port ( 
	        i : in STD_LOGIC;
	        a : in  STD_LOGIC_VECTOR(15 downto 0);
	        b : in STD_LOGIC_VECTOR(15 downto 0);
			  o : out STD_LOGIC_VECTOR(15 downto 0)
			 );
			  
end m1216;

architecture arc_m1216 of m1216 is

component m12 is
   Port (  i : in  STD_LOGIC;
	        a : in  STD_LOGIC;
			  b : in  STD_LOGIC;
	        o : out STD_LOGIC
			);
end component;

begin

  d1:  m12 port map (i=>i,a=>a(0),b=>b(0),o=>o(0));
  d2:  m12 port map (i=>i,a=>a(1),b=>b(1),o=>o(1));
  d3:  m12 port map (i=>i,a=>a(2),b=>b(2),o=>o(2));
  d4:  m12 port map (i=>i,a=>a(3),b=>b(3),o=>o(3));
  d5:  m12 port map (i=>i,a=>a(4),b=>b(4),o=>o(4));
  d6:  m12 port map (i=>i,a=>a(5),b=>b(5),o=>o(5));
  d7:  m12 port map (i=>i,a=>a(6),b=>b(6),o=>o(6));
  d8:  m12 port map (i=>i,a=>a(7),b=>b(7),o=>o(7));
  d9:  m12 port map (i=>i,a=>a(8),b=>b(8),o=>o(8));
  d10: m12 port map (i=>i,a=>a(9),b=>b(9),o=>o(9));
  d11: m12 port map (i=>i,a=>a(10),b=>b(10),o=>o(10));
  d12: m12 port map (i=>i,a=>a(11),b=>b(11),o=>o(11));
  d13: m12 port map (i=>i,a=>a(12),b=>b(12),o=>o(12));
  d14: m12 port map (i=>i,a=>a(13),b=>b(13),o=>o(13));
  d15: m12 port map (i=>i,a=>a(14),b=>b(14),o=>o(14));
  d16: m12 port map (i=>i,a=>a(15),b=>b(15),o=>o(15));

end arc_m1216;

