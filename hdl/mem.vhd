library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

use IEEE.STD_LOGIC_TEXTIO.ALL;

library STD;
use STD.TEXTIO.ALL;

entity mem is
	port(
		clk : in std_logic;
		load :in std_logic;
		oe	: in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		addr_in : in std_logic_vector(3 downto 0);
		data_out : out std_logic_vector(7 downto 0)
	);
end entity;


architecture behave of mem is

type mem_type is array(0 to 15) of std_logic_vector(7 downto 0);


--function init(file_name:string) return mem_type is
--
--file file_data:text;
--variable fstatus : file_open_status;
--variable text_line:line;
--variable line_content:std_logic_vector(7 downto 0);
--variable i:integer:=0; 
--
--variable temp_mem:mem_type;
--
--begin
--
--	file_open(fstatus,file_data,file_name,READ_MODE);
--	if fstatus = OPEN_OK then
--		while(i<16) loop
--			readLine(file_data,text_line);
--			read(text_line,line_content);
--			temp_mem(i):=line_content;
--			i:=i+1;
--		end loop;
--	end if;
--return temp_mem;
--end function init;


signal mem_obj:mem_type :=(x"0E",x"2F",x"1E",x"5E",x"41",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"01");
begin

process(clk)
begin
	if rising_edge(clk) then
		if load = '1' then
			mem_obj(to_integer(unsigned(addr_in)))<=data_in;
		end if;
		
		if oe = '1' then
			data_out <= mem_obj(to_integer(unsigned(addr_in)));
		else
			data_out<="ZZZZZZZZ";
		end if;
	end if;
end process;

end behave;








