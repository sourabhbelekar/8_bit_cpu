library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity top is
port(
clk_in		: IN std_logic;	
rst			: IN std_logic;
mem_prog	: IN std_logic;
ext_mem_clk	: IN std_logic;
ext_mem_addr: IN std_logic_vector(3 downto 0);
ext_mem_bus	: IN std_logic_vector(7 downto 0);
Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);
LED_out : out STD_LOGIC_VECTOR (6 downto 0)
);

end entity;


architecture behave of top is 

SIGNAL rst_db			: std_logic;
SIGNAL mem_prog_db		: std_logic;
SIGNAL ext_mem_clk_db	: std_logic;
SIGNAL clk_10Hz			: std_logic;

signal count : STD_LOGIC_VECTOR(20 downto 0):=(others=>'0');
signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0):=(others=>'0');
signal displayed_number: STD_LOGIC_VECTOR (15 downto 0);
signal LED_activating_counter: std_logic_vector(1 downto 0);
signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);


signal cpu_op : STD_LOGIC_VECTOR(7 downto 0);

component cpu is
	port(
		clk			: IN std_logic;
		rst			: IN std_logic;
		mem_prog	: IN std_logic;
		ext_mem_clk	: IN std_logic;
		ext_mem_addr: IN std_logic_vector(3 downto 0);
		ext_mem_bus	: IN std_logic_vector(7 downto 0);
		op			: OUT std_logic_vector(7 downto 0)		
	);

end component;

component debounce is
PORT(
    clk     : IN  STD_LOGIC; 
    button  : IN  STD_LOGIC; 
    result  : OUT STD_LOGIC);
end component;

begin

debounce_rst		: debounce port map(clk => clk_in,button => rst , result => rst_db);
debounce_mem_prog	: debounce port map(clk => clk_in,button => mem_prog , result => mem_prog_db);
debounce_ext_mem_clk: debounce port map(clk => clk_in,button => ext_mem_clk , result => ext_mem_clk_db);

cpu_obj				: cpu port map(clk => clk_10Hz,rst=>rst_db,mem_prog=>mem_prog_db,ext_mem_clk=>ext_mem_clk_db,ext_mem_addr=>ext_mem_addr,ext_mem_bus=>ext_mem_bus,op=>cpu_op);

process(clk_in)
begin
if rising_edge(clk_in) then
	if rst_db = '1' then
		count<=(others=>'0');
	else
		count<= count + 1;
	
	end if;
end if;
end process;

clk_10Hz <= count(20);

process(clk_in,rst_db)
begin 
    if(rst_db='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clk_in)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
 LED_activating_counter <= refresh_counter(19 downto 18);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= displayed_number(15 downto 12);
        -- the first hex digit of the 16-bit number
    when "01" =>
        Anode_Activate <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= displayed_number(11 downto 8);
        -- the second hex digit of the 16-bit number
    when "10" =>
        Anode_Activate <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= displayed_number(7 downto 4);
        -- the third hex digit of the 16-bit number
    when "11" =>
        Anode_Activate <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= displayed_number(3 downto 0);
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;

process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => LED_out <= "0000001"; -- "0"     
    when "0001" => LED_out <= "1001111"; -- "1" 
    when "0010" => LED_out <= "0010010"; -- "2" 
    when "0011" => LED_out <= "0000110"; -- "3" 
    when "0100" => LED_out <= "1001100"; -- "4" 
    when "0101" => LED_out <= "0100100"; -- "5" 
    when "0110" => LED_out <= "0100000"; -- "6" 
    when "0111" => LED_out <= "0001111"; -- "7" 
    when "1000" => LED_out <= "0000000"; -- "8"     
    when "1001" => LED_out <= "0000100"; -- "9" 
    when "1010" => LED_out <= "0000010"; -- a
    when "1011" => LED_out <= "1100000"; -- b
    when "1100" => LED_out <= "0110001"; -- C
    when "1101" => LED_out <= "1000010"; -- d
    when "1110" => LED_out <= "0110000"; -- E
    when "1111" => LED_out <= "0111000"; -- F
    end case;
end process;



displayed_number(15 downto 8) <= ext_mem_addr & "0000" when mem_prog_db = '1' else (others=>'0');
displayed_number(7 downto 0) <= ext_mem_bus when mem_prog_db = '1' else cpu_op;


end behave;