----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2021 04:16:59 PM
-- Design Name: 
-- Module Name: cu_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cu_test is
--  Port ( );
end cu_test;

architecture Behavioral of cu_test is

component control_unit is 
Port ( 
clk: in std_logic;
rst: in std_logic;
inst: in std_logic_vector(3 downto 0);
do : out std_logic_vector(16 downto 0)
);
end component;


signal clk_sig: std_logic:='0';
signal inst_sig:std_logic_vector(3 downto 0):="0000";
signal rst_sig:std_logic;
signal control_op:std_logic_vector(16 downto 0);
constant clk_period : time := 10 ns;

signal pc_out:std_logic;
signal mar_in:std_logic;

begin

process
begin

clk_sig<='0';
wait for clk_period/2;
clk_sig<= not clk_sig;
wait for clk_period/2;
end process;


cu_inst: control_unit port map(clk=>clk_sig,rst=>rst_sig,inst=>inst_sig,do=>control_op);

pc_out<=control_op(9);
mar_in<=control_op(8);

process
begin

rst_sig<='1';
wait for clk_period*5;
rst_sig<='0';

wait;
end process;



end Behavioral;
