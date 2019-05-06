library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

entity RISC_IITB is
port
     (
			clk        : in std_logic;
			reset      : in std_logic;
			pc_out     : out std_logic_vector(15 downto 0);
			alu_result : out std_logic_vector(15 downto 0)
      );
end RISC_IITB;

architecture Behavioral of RISC_IITB is

 signal pc_signal: std_logic_vector(15 downto 0);
 signal ir_signal, ir_i: std_logic_vector(15 downto 0);
 signal opcode_signal         : std_logic_vector(3 downto 0);
 signal reset_signal          : std_logic;
 signal clk_signal            : std_logic;
 signal MemWrite_signal, IRWrite_signal, PCWrite_signal, Branch_signal, RegWrite_signal : std_logic;
 signal MemtoReg_signal, RegDst_signal, IorD_signal, ALUSrcA_signal              : std_logic;   
 signal PCSrc_signal, ALUSrcB_signal : std_logic_vector(1 downto 0);
 signal ALUOp_signal          : std_logic_vector(3 downto 0);
 signal SE_signal             : std_logic_vector(1 downto 0);
 signal PCEn_signal, unused_signal   : std_logic;
 signal pc_a   : std_logic_vector(15 downto 0);
 signal pc_o   : std_logic_vector(15 downto 0);
 signal alu_o  : std_logic_vector(15 downto 0);
 signal addr   : std_logic_vector(15 downto 0);
 signal RFA3_signal  : std_logic_vector(2 downto 0);
 signal RFD3_signal  : std_logic_vector(15 downto 0);
 signal RFA1_signal  : std_logic_vector(2 downto 0);
 signal RFD1_signal  : std_logic_vector(15 downto 0);
 signal RFA2_signal  : std_logic_vector(2 downto 0);
 signal RFD2_signal  : std_logic_vector(15 downto 0);
 signal T1_o,T2_o    : std_logic_vector(15 downto 0);
 signal	mem_access_addr_signal, mem_write_data_signal,mem_read_data_signal : std_logic_Vector(15 downto 0);
 signal  CZ_signal : std_logic_vector(1 downto 0);
 signal  imm6_signal : std_logic_vector(5 downto 0);
 signal  imm9_signal : std_logic_vector(8 downto 0);
	   
 
component Data_Memory is
port (
	clk: in std_logic;
	mem_access_addr: in std_logic_Vector(15 downto 0);
	mem_write_data: in std_logic_Vector(15 downto 0);
	mem_write_en,mem_read:in std_logic;
	mem_read_data: out std_logic_Vector(15 downto 0)
);
end component; 
 
component signExtend6 is 
    port(
	    a : in  std_logic_vector(5 downto 0);
		 o : out std_logic_vector(15 downto 0)
         );
end component;
 
component signExtend9 is 
    port(
	    a : in  std_logic_vector(8 downto 0);
		 o : out std_logic_vector(15 downto 0)
         );
end component;

component offsetExtend9 is 
    port(
	    a : in  std_logic_vector(8 downto 0);
		 o : out std_logic_vector(15 downto 0)
         );
end component; 

component instructionRegister is 
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
end component;

component pc is 
    port(
        PCEn   : in  std_logic;
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end component;

component register_file is
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
end component;

component T1 is 
    port(
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end component;

component T2 is 
    port(
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end component;

component T_mem is 
    port(
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end component;

component ALU_out is 
    port(
		  clk    : in std_logic;
        a      : in  std_logic_vector(15 downto 0);
        o      : out std_logic_vector(15 downto 0)
    );
end component;

component ALU is
port(
       a,b           : in std_logic_vector(15 downto 0); 
       alu_control   : in std_logic_vector(1 downto 0); 
       o             : out std_logic_vector(15 downto 0);
	    z_flag        : out std_logic;
		 c_flag        : out std_logic
		 
 );
end component;

component ALU_control is
port(
      ALUOp        : in std_logic_vector(3 downto 0);
		alu_control  : out std_logic_vector(1 downto 0)
     );
end component;

component Control_unit is
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
end component;

component m24 is
    Port ( c0      : in  STD_LOGIC;
           c1      : in  STD_LOGIC;
			  a,b,c,d : in STD_LOGIC;
			  o       : out STD_LOGIC
			 );
end component;

component m12 is
    Port ( i : in  STD_LOGIC;
	        a : in  STD_LOGIC;
			  b : in  STD_LOGIC;
	        o : out STD_LOGIC
			 );
end component;

component m1216 is
    Port ( 
	        i : in STD_LOGIC;
	        a : in  STD_LOGIC_VECTOR(15 downto 0);
	        b : in STD_LOGIC_VECTOR(15 downto 0);
			  o : out STD_LOGIC_VECTOR(15 downto 0)
			 );
			  
end component;
 
 
begin

		
control1: Control_unit port map (reset=> '0', opcode=> ir_signal(3 downto 0), clk=>clk_signal, MemWrite=>MemWrite_signal, IRWrite=>IRWrite_signal, PCWrite=>PCWrite_signal, Branch=>Branch_signal, 
                                 RegWrite=>RegWrite_signal, MemtoReg=>MemtoReg_signal, RegDst=>RegDst_signal, IorD=>IorD_signal, ALUSrcA=>ALUSrcA_signal, PCSrc=>PCSrc_signal, 
											ALUSrcB=>ALUSrcB_signal, ALUOp=>ALUOp_signal, SE=>SE_signal );

pc_1: pc port map (PCEn=>PCEn_signal,clk=>clk_signal,a=>pc_a,o=>pc_o);
mux1: m1216 port map (i=>IorD_signal,a=>pc_o,b=>alu_o,o=>addr);

mm: Data_Memory port map (	clk=>clk_signal, mem_access_addr=>pc_o, mem_write_data=>RFD3_signal, mem_write_en=>MemWrite_signal,mem_read=>'1',	mem_read_data=>ir_i);





mux2: m12 port map (i=>RegDst_Signal,a=>ir_signal(11),b=>ir_signal(5),o=>RFA3_signal(2));
mux3: m12 port map (i=>RegDst_Signal,a=>ir_signal(10),b=>ir_signal(4),o=>RFA3_signal(1));
mux4: m12 port map (i=>RegDst_Signal,a=>ir_signal(9),b=>ir_signal(3),o=>RFA3_signal(0));

regfile: register_file port map (clk=>clk_signal ,RegWrite=>RegWrite_signal, RFA1=>RFA1_signal, RFA2=>RFA2_signal, RFA3=>RFA3_signal, RFD1=>RFD1_signal, RFD2=>RFD2_signal, 
                                 RFD3=>RFD3_signal);
											
iregfile: instructionRegister port map (IRWrite => IRWrite_signal, instrucInput=>ir_i, clk=>clk_signal, opCode=>OPCode_signal, regRA=>RFA1_signal, regRB=>RFA2_signal, regRC=>RFA3_signal,
                                        imm6=>imm6_signal, imm9=>imm9_signal, unused=>unused_signal, CZ=>CZ_signal);

t1_1: T1 port map (clk=>clk_signal, a=>RFD1_signal, o=>T1_o);
t2_1: T2 port map (clk=>clk_signal, a=>RFD2_signal, o=>T2_o);										
											

											

end Behavioral;