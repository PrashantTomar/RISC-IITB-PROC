library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity instructionRegister is 
    port(
          IRWrite      : in  std_logic;
          instrucInput : in  std_logic_vector(15 downto 0);
			 clk          : in std_logic; 
	     	 opCode       : out std_logic_vector(3 downto 0);
          regRA	     : out std_logic_vector(2 downto 0);
		    regRB   	  : out std_logic_vector(2 downto 0);
		    regRC   	  : out std_logic_vector(2 downto 0);
		    imm6         : out std_logic_vector(5 downto 0);
			 imm9         : out std_logic_vector(8 downto 0);
		    unused       : out std_logic;
		    CZ           : out std_logic_vector(1 downto 0)
          );
end instructionRegister;

architecture behavior of instructionRegister is

     signal addr_Output1 : std_logic_vector(3 downto 0);
     signal addr_Output2 : std_logic_vector(2 downto 0);
	  signal addr_Output3 : std_logic_vector(2 downto 0);
	  signal addr_Output4 : std_logic_vector(2 downto 0);
     signal addr_Output5 : std_logic_vector(5 downto 0);
	  signal addr_Output6 : std_logic_vector(8 downto 0);
	  signal addr_Output7 : std_logic;
	  signal addr_Output8 : std_logic_vector(1 downto 0);

begin
    
	opCode    <= addr_Output1;
	regRA     <= addr_Output2;
	regRB     <= addr_Output3;
	regRC     <= addr_Output4;
	imm6      <= addr_Output5;
   imm9      <= addr_Output6;
	unused    <= addr_Output7;
	CZ        <= addr_Output8;
	
    process (IRWrite , instrucInput, clk) begin
	 
       if rising_edge(clk) then 
        if( IRWrite  = '1' ) then 
               addr_Output1 <= instrucInput(15 downto 12);
			      addr_Output2 <= instrucInput(11 downto 9);
			      addr_Output3 <= instrucInput(8 downto 6);
			      addr_Output4 <= instrucInput(5 downto 3);
			      addr_Output5 <= instrucInput(5 downto 0);
			      addr_Output6 <= instrucInput(8 downto 0);
			      addr_Output7 <= instrucInput(2);
					addr_Output8 <= instrucInput(1 downto 0);
			 end if;		
        end if;
	end process;
	
end behavior;