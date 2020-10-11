library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity pc_tb is 
	
end entity;

architecture behave of pc_tb is

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

signal clk_sig : std_logic;
signal rst_sig : std_logic;
signal en_sig : std_logic;
signal oe_sig : std_logic;
signal ld_sig : std_logic;
signal input_sig : std_logic_vector(3 downto 0);
signal output_sig : std_logic_vector(3 downto 0);

constant clk_period : time := 10 ns;
begin

pc1: pc port map(clk=>clk_sig,rst=>rst_sig,en=>en_sig,oe=>oe_sig,ld=>ld_sig,input=>input_sig,output=>output_sig);


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
en_sig<='0';
ld_sig<='0';
wait for clk_period*5;
en_sig<='1';
wait for clk_period*5;
en_sig<='0';
oe_sig<='1';
wait for clk_period;
oe_sig<='0';
rst_sig<='1';
wait for clk_period;
en_sig<='1';
rst_sig<='0';
wait for clk_period;
oe_sig<='1';
wait;

end process;











end behave;