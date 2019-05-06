library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity signExtend6 is 
    port(
	    a : in  std_logic_vector(5 downto 0);
		 o : out std_logic_vector(15 downto 0)
         );
end signExtend6;

architecture behavior of signExtend6 is 

	begin
        process(a) begin 
		    if( a(5)='1') then
			    o(5 downto 0)  <= a;
				 o(15 downto 6) <= "1111111111";
			else 
			    o(5 downto 0)  <= a;
				 o(15 downto 6) <= "0000000000";
			end if;
		end process;

end behavior;