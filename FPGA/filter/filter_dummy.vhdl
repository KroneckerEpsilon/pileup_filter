library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sipm.all;
use ieee.fixed_pkg.all;

entity trapezoidal is 
	generic(
	    M	: integer := 1;
	    K	: integer := 10;
	    L	: integer := 3
	);
	port(	
	    i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_sipm1:	in dsphit;
		o_sipm1f:	out arhit
	);
end trapezoidal;

architecture arch of trapezoidal is
	
	constant i : integer := 0;
	constant j : integer := 20;
	
	--type sipmhit_array is array(j downto i) of sipmhit;

	signal zero		: sipmhit := (n => (others => '0'), o => '0');
	--signal x 		: sipmhit_array;
	signal x     : sipmhit := (n => (others => '0'), o => '0');
	--signal delayK 		: sipmhit_array;
	--signal delayL 		: sipmhit_array;
	--signal delayKL 		: sipmhit_array;
	--signal b 		: sipmhit_array;
	--signal c 		: sipmhit_array;
	--signal product 		: sipmhit_array;
	--signal y 		: sipmhit_array;
begin
	evol: process (i_clk, i_rst) is
	begin
		if(i_rst = '1') then
			x <= (n => (others => '0'), o => '0');
		end if;
		if(rising_edge(i_clk)) then
			--x <= i_sipm1;
		end if;
	end process;
	o_sipm1f.n <= to_sfixed(x.n, 31, -32);
	o_sipm1f.o <= x.o;
end arch;
