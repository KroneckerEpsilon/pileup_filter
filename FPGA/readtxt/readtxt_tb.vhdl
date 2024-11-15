library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use work.sipm.all;

entity fe_tb is
end fe_tb;

architecture arch of fe_tb is 
	signal clk : 	std_logic := '1';
	signal rst : 	std_logic := '0';
	signal trig: 	std_logic := '1';
	signal hit:  	integer;
	signal tstamp:	integer;

	component fe is
	port( 	i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_trig:		in std_logic;
		o_sipm1:	out sipmhit;
		o_tstamp:	out integer
	);
	end component;
begin
	clk <= not clk after 1 ns;
	pulse: fe port map(clk, rst, trig, hit, tstamp);
end arch;	
