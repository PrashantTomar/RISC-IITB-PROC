library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity register_file is
port 
	(
		clk: in std_logic;
		RegWrite: in std_logic;
		RFA3: in std_logic_vector(2 downto 0);
		RFD3: in std_logic_vector(15 downto 0);
		RFA1: in std_logic_vector(2 downto 0);
		RFD1: out std_logic_vector(15 downto 0);
		RFA2: in std_logic_vector(2 downto 0);
		RFD2: out std_logic_vector(15 downto 0)
	);
end register_file;

architecture Behavioral of register_file is

type reg_type is array (0 to 7 ) of std_logic_vector (15 downto 0);

signal reg_array: reg_type;

begin

 process(clk) 

 begin
   if(rising_edge(clk)) then
    if(RegWrite='1') then
     reg_array(to_integer(unsigned(RFA3))) <= RFD3;
    end if;
   end if;
 end process;

 RFD1 <= reg_array(to_integer(unsigned(RFA1)));
 RFD2 <= reg_array(to_integer(unsigned(RFA2)));

end Behavioral;