library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use dtypes.sipm.all;

entity tb is 
end tb;

architecture arch of tb is 
	signal clk : std_logic := '1';
	signal rst : std_logic := '1';
	signal trig : std_logic := '0';
	variable freq : time := 2 ns;

	signal o : sipmhit;

	component x is 
	port(	i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_trig:		in std_logic;
		o_main:		out sipmhit
	);
	end component;
	
	clk <= not clk after freq/2;
	rst <= '0' after 3 ns;
	trig <= '1' after 5 ns, '0' after 6500 ps;

	all: x port map(i_clk <= clk, i_rst <= rst, i_trig <= trig, o_main <= o);
end arch;
