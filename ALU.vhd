library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;

entity ALU is
port(
       a,b           : in std_logic_vector(15 downto 0); 
       alu_control   : in std_logic_vector(1 downto 0); 
       o             : out std_logic_vector(15 downto 0);
	    z_flag        : out std_logic;
		 c_flag        : out std_logic
		 
 );
end ALU;

architecture Behavioral of ALU is

component fa16 is
    port ( 
	        a,b  : in std_logic_vector(15 downto 0);
	        cin  : in std_logic;
			  o    : out std_logic_vector(15 downto 0);
			  cout : out std_logic
			 );
end component;

signal result: std_logic_vector(15 downto 0);

begin
process(alu_control,a,b)
begin
 case alu_control is
 
 when "00" =>
  result <= a + b;
  
  when "01" =>
  result <= a - b;
  
 when "10" => 
  result <= a nand b; 
  
 when others => 
 result <= a + b;
 
end case;
end process;

  z_flag <= '1' when result="0000000000000000" else '0';
  add1: fa16 port map (a=>a, b=>b, cin=>'0', cout=>c_flag);
  
  o <= result;
  
end Behavioral;