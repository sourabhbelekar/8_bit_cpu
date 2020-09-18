library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity alu_tb is 
	
end entity;

architecture behave of alu_tb is

component alu is 
port(
	en : in std_logic;
	op : in std_logic;
	reg_a_in : in std_logic_vector(7 downto 0);
	reg_b_in : in std_logic_vector(7 downto 0);
	carry_out : out std_logic;
	res_out : out std_logic_vector(7 downto 0)
);
end component;

signal clk_sig : std_logic;
signal en_sig : std_logic;
signal op_sig : std_logic;
signal reg_a_sig : std_logic_vector(7 downto 0);
signal reg_b_sig : std_logic_vector(7 downto 0);
signal res_out_sig : std_logic_vector(7 downto 0);
signal carry_sig : std_logic;

constant clk_period : time := 10 ns;
begin

alu1: alu port map(en=>en_sig,op=>op_sig,reg_a_in=>reg_a_sig,reg_b_in=>reg_b_sig,carry_out=>carry_sig,res_out=>res_out_sig);


process
begin

clk_sig<='0';
wait for clk_period/2;
clk_sig<= not clk_sig;
wait for clk_period/2;
end process;



process
begin

reg_a_sig<="11111111";
reg_b_sig<="00000001";

en_sig<='0';
op_sig<='1';
wait for clk_period*5;
en_sig<='1';
wait for clk_period*5;
op_sig<='0';

wait;

end process;











end behave;