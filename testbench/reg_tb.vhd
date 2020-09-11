library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity reg_tb is 
	
end entity;

architecture behave of reg_tb is

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

signal clk_sig : std_logic;
signal rst_sig : std_logic;
signal out_en_sig : std_logic;
signal ld_sig : std_logic;
signal input_sig : std_logic_vector(7 downto 0);
signal output_sig : std_logic_vector(7 downto 0);
signal output_alu_sig : std_logic_vector(7 downto 0);

constant clk_period : time := 10 ns;
begin

reg1: reg port map(clk=>clk_sig,rst=>rst_sig,out_en=>out_en_sig,load=>ld_sig,input=>input_sig,output=>output_sig,output_alu=>output_alu_sig);


process
begin

clk_sig<='0';
wait for clk_period/2;
clk_sig<= not clk_sig;
wait for clk_period/2;
end process;



process
begin
rst_sig<='0';
out_en_sig<='0';
ld_sig<='0';
wait for clk_period*5;
input_sig<="00100010";
ld_sig<='1';
wait for clk_period;
ld_sig<='0';
wait for clk_period;
out_en_sig<='1';
wait for clk_period;
out_en_sig<='0';
wait;

end process;

end behave;