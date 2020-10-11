library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity mem_tb is 
	
end entity;

architecture behave of mem_tb is

component mar is
port(
	clk : in std_logic;
	rst : in std_logic;
	load	: in std_logic;
	input	: in std_logic_vector(3 downto 0);
	output  : out std_logic_vector(3 downto 0)
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

signal clk_sig : std_logic;
signal rst_sig : std_logic;

signal load_mar: std_logic;
signal load_mem: std_logic;
signal mar_input: std_logic_vector(3 downto 0);
signal mar_out: std_logic_vector(3 downto 0);

signal mem_en_sig : std_logic;
signal mem_ld_sig : std_logic;
signal mem_input_sig : std_logic_vector(7 downto 0);
signal mem_output_sig : std_logic_vector(7 downto 0);

constant clk_period : time := 10 ns;
begin

mar1: mar port map(clk=>clk_sig,rst=>rst_sig,load=>load_mar,input=>mar_input,output=>mar_out);
mem1: mem port map(clk=>clk_sig,load=>mem_ld_sig,oe=>mem_en_sig,data_in=>mem_input_sig,addr_in=>mar_out,data_out=>mem_output_sig);


process
begin

clk_sig<='0';
wait for clk_period/2;
clk_sig<= not clk_sig;
wait for clk_period/2;
end process;



process
begin
--rst_sig<='0';
--mar_input<="0001";
--load_mar<='1';
--wait for clk_period;
--load_mar<='0';
--mem_input_sig<="11111111";
--mem_ld_sig<='1';
--wait for clk_period;
--mem_ld_sig<='0';
--wait for clk_period;
--mem_en_sig<='1';

mar_input<="0000";
load_mar<='1';
mem_en_sig<='0';
wait for clk_period;
load_mar<='0';
mem_en_sig<='1';
wait for clk_period;
mar_input<="0001";
load_mar<='1';
mem_en_sig<='0';
wait for clk_period;
load_mar<='0';
mem_en_sig<='1';
wait for clk_period;
mar_input<="0010";
load_mar<='1';
mem_en_sig<='0';
wait for clk_period;
load_mar<='0';
mem_en_sig<='1';
wait for clk_period;


wait;

end process;











end behave;