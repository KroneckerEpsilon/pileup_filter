library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use dtypes.sipm.all;

entity a is 
port(	i_clk:		in std_logic;
	i_rst:		in std_logic;
	i_trig: 	in std_logic;
	o_sipm1:	out sipmhit
);
end a;

architecture arch of a is
	p_read : process(s_clk, s_rst)

		file f_data 	  	: text open read_mode is "text.txt";
		Variable row 	  	: line;
		Variable v_sipm1  	: integer := 0;
		Variable v_rcount 	: integer := 0;

	begin
		if(i_rst ='1') then
			v_rcount := 0;
			v_sipm1  := 0;
		elsif(rising_edge(i_clk) and rising_edge(i_trig)) then
			if(not endfile(f_data)) then 
				v_rcount := v_rcount + 1;
				readline(f_data, row);
			end if;
			read(row, v_sipm1);
		end if;
	o_sipm1.v <= v_sipm1;
	end process p_read;
end arch;