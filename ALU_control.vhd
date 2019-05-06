library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_control is
port(
      ALUOp        : in std_logic_vector(3 downto 0);
		alu_control  : out std_logic_vector(1 downto 0)
     );
end ALU_control;

architecture Behavioral of ALU_control is

begin

process(ALUOp)
 begin
  case ALUOp is
  
	when "0000" => 
		  alu_control <= "00";
				
	when "0010" => 
		  alu_control <= "10";
				
	when "1100" => 
		  alu_control <= "01";
		
	when others => 
			alu_control <= "00";
			
end case;

end process;

end Behavioral;