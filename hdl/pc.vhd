library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity pc is 
	port(
		clk : in std_logic;
		rst	: in std_logic;
		en 	: in std_logic;
		oe 	: in std_logic;
		ld	: in std_logic;
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(3 downto 0)
	);
end entity;


architecture behave of pc is

signal count : std_logic_vector(3 downto 0) := "0000";

begin

process(clk,rst)
begin
	if rst = '1' then
		count<=(others=>'0');
	elsif rising_edge(clk) then
		if ld = '1' then
			count <= input;
		elsif en ='1' then
			count<= count + 1;
		end if;
	end if;

end process;

output <= count when oe = '1' else "ZZZZ";
end behave;