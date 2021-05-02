library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity cpu is 
port(
clk : in std_logic;
rst : in std_logic;
op	 : out std_logic_vector(7 downto 0)
 
);
end entity;



architecture behave of cpu is

component pc is 
	port(
		clk : in std_logic;
		rst	: in std_logic;
		en 	: in std_logic;
		oe 	: in std_logic;
		ld	: in std_logic;
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(3 downto 0)
	);
end component;


component reg is 
port(
	clk : in std_logic;
	rst : in std_logic;
	out_en : in std_logic;
	load	: in std_logic;
	input	: in std_logic_vector(7 downto 0);
	output 	: out std_logic_vector(7 downto 0);
	output_alu : out std_logic_vector(7 downto 0)
);

end component;

component mem is
	port(
		clk : in std_logic;
		load :in std_logic;
		oe	: in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		addr_in : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(7 downto 0)
	);
end component;

component mar is 
port(
	clk : in std_logic;
	rst : in std_logic;
	load	: in std_logic;
	input	: in std_logic_vector(3 downto 0);
	output  : out std_logic_vector(3 downto 0)
);
end component;


component alu is
port(
	en : in std_logic;
	op : in std_logic;
	reg_a_in : in std_logic_vector(7 downto 0);
	reg_b_in : in std_logic_vector(7 downto 0);
	carry_out : out std_logic;
	zero_flag : out std_logic;
	res_out : out std_logic_vector(7 downto 0)
);
end component;


component control_unit is
Port ( 
clk: in std_logic;
rst: in std_logic;
inst: in std_logic_vector(3 downto 0);
do : out std_logic_vector(16 downto 0)
);
end component;


signal main_bus: std_logic_vector(7 downto 0);

signal clk_sig : std_logic;

signal inst_out: std_logic_vector(3 downto 0);
signal cu_out_sig: std_logic_vector(16 downto 0);
signal mar_mem_sig: std_logic_vector(3 downto 0);
signal inst_out_sig:std_logic_vector(7 downto 0);
signal reg_a_alu : std_logic_vector(7 downto 0);
signal reg_b_alu : std_logic_vector(7 downto 0);


signal halt_sig : std_logic;
signal pc_en_sig : std_logic;
signal pc_oe_sig : std_logic;
signal pc_ld_sig : std_logic;
signal mar_ld_sig: std_logic;
signal mem_ld_sig: std_logic;
signal mem_oe_sig: std_logic;
signal inst_ld_sig:std_logic;
signal inst_oe_sig:std_logic;
signal reg_a_ld_sig:std_logic;
signal reg_a_oe_sig:std_logic;
signal reg_b_ld_sig:std_logic;
signal reg_b_oe_sig:std_logic;
signal reg_op_ld_sig:std_logic;
signal reg_op_oe_sig:std_logic;
signal alu_en_sig:std_logic;
signal alu_op_sig:std_logic;


begin

pc_inst : pc port map(
clk=>clk_sig,
rst=>rst,	
en => pc_en_sig,	
oe =>	pc_oe_sig,
ld	=> pc_ld_sig,
input => main_bus(3 downto 0),
output=> main_bus(3 downto 0)
);


cu_inst: control_unit port map(
clk =>clk_sig,
rst =>rst,
inst => inst_out,
do => cu_out_sig
);

mar_inst: mar port map(
clk=>clk_sig,	
rst=>rst,
load => mar_ld_sig,
input=> main_bus(3 downto 0),
output=> mar_mem_sig
);


mem_inst: mem port map(
clk=>clk_sig,
load => mem_ld_sig,
oe => mem_oe_sig,
data_in => main_bus,
addr_in => mar_mem_sig,
data_out => main_bus
);


inst_reg_inst: reg port map(
clk=>clk_sig,		
rst=>rst,		
load	=> inst_ld_sig,
out_en=>	inst_oe_sig,	
input	=> main_bus,	
output_alu => inst_out_sig	
);

inst_out <= inst_out_sig(7 downto 4);
main_bus(3 downto 0) <= inst_out_sig(3 downto 0) when inst_oe_sig = '1' else (others=>'Z');


reg_A_inst: reg port map(
clk=>clk_sig,		
rst=>rst,		
load =>	reg_a_ld_sig,
out_en=>	reg_a_oe_sig,
input	=> main_bus,
output => main_bus,	
output_alu => reg_a_alu

);

reg_B_inst: reg port map(
clk=>clk_sig,		
rst=>rst,		
load	=> reg_b_ld_sig,
out_en=> reg_b_oe_sig,	
input	=> main_bus,
output=> main_bus,	
output_alu => reg_b_alu

);

reg_op_inst:reg port map(
clk=>clk_sig,		
rst=>rst,		
load	=>reg_op_ld_sig,
out_en=>reg_op_oe_sig,	
input	=> main_bus,
output=> open,	
output_alu => op

);
alu_inst: alu port map(
en	=> alu_en_sig,	
op	=>	alu_op_sig,
reg_a_in => reg_a_alu,
reg_b_in => reg_b_alu,
carry_out => open,
zero_flag => open,
res_out => main_bus
);


clk_sig <= clk and (not halt_sig);



halt_sig 	<= cu_out_sig(16);
reg_op_ld_sig 	<=cu_out_sig(15);
reg_op_oe_sig	<=cu_out_sig(14);
alu_op_sig	<= cu_out_sig(13);
alu_en_sig	<= cu_out_sig(12);
pc_en_sig 	<= cu_out_sig(11);
pc_ld_sig	<= cu_out_sig(10);
pc_oe_sig 	<= cu_out_sig(9);
mar_ld_sig 	<= cu_out_sig(8);
mem_ld_sig	<= cu_out_sig(7);
mem_oe_sig	<= cu_out_sig(6);
reg_a_ld_sig<= cu_out_sig(5);
reg_a_oe_sig<= cu_out_sig(4);
reg_b_ld_sig<= cu_out_sig(3);
reg_b_oe_sig<= cu_out_sig(2);
inst_ld_sig	<= cu_out_sig(1);
inst_oe_sig	<= cu_out_sig(0);


end behave;