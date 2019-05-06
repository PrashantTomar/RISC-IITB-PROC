library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
port 
	(
		opcode         : in std_logic_vector(3 downto 0);
		reset          : in std_logic;
		clk            : in std_logic;
		MemWrite, IRWrite, PCWrite, Branch, RegWrite : out std_logic;
		MemtoReg, RegDst, IorD, ALUSrcA            : out std_logic;   
		PCSrc, ALUSrcB : out std_logic_vector(1 downto 0);
		ALUOp          : out std_logic_vector(3 downto 0);
		SE             : out std_logic_vector(1 downto 0)
  
	);
end Control_unit;

architecture Behavioral of Control_unit is

begin

type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15); 
signal current_s,next_s: state_type; 

begin

process (clk,reset,opcode) begin

 if (reset='1') then
  current_s <= s0;  
  
 elsif (rising_edge(clk)) then
  current_s <= next_s;  
end if;
end process;

process (current_s,input) begin
  case current_s is
  
     when s0 =>               -- Fetch
     
      IorD    <= '0';
		AluSrcA <= '0';
		ALUSrcB <= "01";
		ALUOp   <= "0000";
		PCSrc   <= "00";
		IRWrite <= '1';
		PCWrite <= '1';
      next_s <= s1;
		
      

    when s1 =>                -- Decode 
    if(opcode ="0000") then       --add
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "0000";
		next_s  <= s6;
      
    else if(opcode ="0010") then  --nand
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "0010";
		next_s  <= s6;
	 
	 else if(opcode ="0100") then  --lw
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "0100";
		next_s  <= s2;
	 
	 else if(opcode ="0101") then  --sw
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "0101";
		next_s  <= s2;
	 
	 
	 else if(opcode ="0001") then --adi
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "0001";
		next_s  <= s9;
	
	 
	 else if(opcode ="1100") then --BEQ
      ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "1100";	 
		next_s  <= s8;
	 
	 
	 else if(opcode ="1000") then  --JLR
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "1000";	 
		next_s  <= s13;
	 
	 else if(opcode ="1001") then  --JAL
	   ALUSrcA <= '0';
		ALUSrcB <= "11";
		ALUOp   <= "1001";	 
		next_s  <= s13;
	 
	 else 
	   next_s <= s0;     
    end if;

    when s2 =>         -- MemAddr
    if(opcode ="0100") then   -- lw
	   ALUSrcA <= '1';
		ALUSrcB <= "10";
		ALUOp   <= "0100";
		next_s  <= s3;
	 
	 else if(opcode ="0101") then  --sw
	   ALUSrcA <= '1';
		ALUSrcB <= "10";
		ALUOp   <= "0101"; 
      next_s  <= s5;
		
     else 
	    next_s <= s0;	
	  end if;		
		


  when s3 =>         --MemRead (lw)
	   IorD    <= '1';
		nesxt_s <= s4;  	
   
	
  when s4 =>         --MemWriteBack (lw)
	   RegDst    <= '0';
		MemtoReg  <= '1';
		RegWrite  <= '1';
		nesxt_s <= s0;    
	
  when s5 =>         
	   IorD     <= '1';
		MemWrite <= '1';
		nesxt_s  <= s0;      
    
	
  when s6 =>           -- Execute
    if(opcode = "0000") then  --ADD
	   ALUSrcA <= '1';
		ALUSrcB <= "00";
		ALUOp   <= "0000";
		nesxt_s <= s7; 
    
     if(opcode = "0010") then  --NAND
	   ALUSrcA <= '1';
		ALUSrcB <= "00";
		ALUOp   <= "0010";
		nesxt_s <= s7; 
     else
	   next_s  <= s0;  
    end if;
	
  when s7 =>           -- ALUWriteBack
    if(opcode = "0000") then  --ADD
	   RegDst   <= '1';
		MemtoReg <= '0';
		MemWrite <= '1';
		ALUOp    <= "0000";
		nesxt_s <= s0; 
    
     if(opcode = "0010") then  --NAND
	   RegDst   <= '1';
		MemtoReg <= '0';
		MemWrite <= '1';
		ALUOp    <= "0010";
		nesxt_s <= s0;
     else
	   next_s  <= s0;  
    end if;	
	 
	when s8 =>     --Branch
	   ALUSrcA  <='1';
		ALUSrcB  <="00";
		ALUOp    <="1100";
		PCSrc    <="01";
		Branch   <='1';
		next_s   <= s0;
		
	when s9 =>   --ADDIExecute
	   ALUSrcA  <='1';
		ALUSrcB  <="10";
		ALUOp    <="0001";
		Next_s   <=s10;
		
  when s10 =>   --ADDIWriteBack
      RegDst    <='0';
	   MemtoReg  <='0';
	   RegWrite	 <='1';
		next_s    <= s0;
		
  when s11 =>   --Jump
      PCSrc   <= "10";
		PCWrite <= '1';
	   next_s  <= s0;	
		
  when s13 =>    -- JLR/JAL
     if(opcode="1001") then
      ALUSrcA   <='0'; 
	   ALUSrcB   <="01";
	   ALUOp     <="1001";
	   MemtoReg  <='0';
		RegtoDst  <='0';
		next_s    <=s14;
		
	  else if (opcode="1000") then
	   ALUSrcA   <='0'; 
	   ALUSrcB   <="01";
	   ALUOp     <="1000";
	   MemtoReg  <='0';
		RegtoDst  <='0';
		next_s    <=s15;
	 
	  else
	    next_s <= s0; 
		 
  when s14 =>	       --JLR
      RegWrite <='1';
		PCSrc    <="11";
		PCWrite  <='1';
		next_s   <=s0;
		
  when s15 =>        --JAL
      RegWrite <='1';
		PCSrc    <="10";
		PCWrite  <='1';
		next_s   <=s0; 
	 
  end case;
  
  
end process;

end Behavioral;