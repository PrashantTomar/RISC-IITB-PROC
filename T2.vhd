library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity T2 is 
    port(
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end T2;

architecture behavior of T2 is

    signal ot : std_logic_vector(15 downto 0);

begin
    
	o <= ot;
	
    process (a, clk) begin
	 
	    if rising_edge(clk) then 
            ot <= a ;
		 end if; 
	end process;
	
end behavior;