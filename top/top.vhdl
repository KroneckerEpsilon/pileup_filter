library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use work.sipm.all;

entity x is 
port(	i_clk:		in std_logic;
	i_rst:		in std_logic;
	i_trig:		in std_logic;
	o_main:		out sipmhit
);
end x;

architecture arch of x is
	component fe is 
	port(	i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_trig:		in std_logic;
		o_sipm1:	out sipmhit
	);
	end component;

	component trapezoidal is 
	port(	i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_trig:		in std_logic;
		i_sipm1:	in sipmhit;
		o_sipm1f:	out sipmhit
	);
	end component;

	signal s_sipm1 : sipmhit;

begin
	pulse: fe port map (i_clk=>i_clk, i_rst=>i_rst, i_trig=>i_trig, o_sipm1=>s_sipm1);
	flt: trapezoidal port map (i_clk=>i_clk, i_rst=>i_rst, i_trig=>i_trig, i_sipm1=>s_sipm1, o_sipm1f=>o_main);
end architecture;	
