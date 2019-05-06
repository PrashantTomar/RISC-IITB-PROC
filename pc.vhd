library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc is 
    port(
        PCEn   : in  std_logic;
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end pc;

architecture behavior of pc is

    signal addr_Output : std_logic_vector(15 downto 0);

begin
    
	o <= addr_Output;
	
    process (PCEn, a, clk) begin
	 
	    if rising_edge(clk) then
        if( PCEn = '1' ) then 
            addr_Output <= a;
        end if;
		 end if; 
	end process;
	
end behavior;