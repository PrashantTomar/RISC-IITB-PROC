library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity offsetExtend9 is 
    port(
	    a : in  std_logic_vector(8 downto 0);
		 o : out std_logic_vector(15 downto 0)
         );
end offsetExtend9;

architecture behavior of offsetExtend9 is 

 begin
 
 o(15 downto 7) <= a;
 o(6 downto 0) <= "0000000";
 
		
end behavior;