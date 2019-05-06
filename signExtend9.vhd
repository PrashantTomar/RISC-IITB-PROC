library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity signExtend9 is 
    port(
	    a : in  std_logic_vector(8 downto 0);
		 o : out std_logic_vector(15 downto 0)
         );
end signExtend9;

architecture behavior of signExtend9 is 

	begin
        process(a) begin 
		    if( a(8)='1') then
			    o(8 downto 0)  <= a;
				 o(15 downto 9) <= "1111111";
			else 
			    o(8 downto 0)  <= a;
				 o(15 downto 9) <= "0000000";
			end if;
		end process;

end behavior;