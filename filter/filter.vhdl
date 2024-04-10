library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use dtypes.sipm.all;

entity trapezoidal is 
	port(	i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_trig:		in std_logic;
		i_sipm1:	in sipmhit;
		o_sipm1f:	out sipmhit
	);
	generic(
	M	: time := 3 ns;
	K	: integer := 10;
	L	: integer := 3
	);
	end component;
end trapezoidal;

architecture arch of trapezoidal is 

begin
	filter: for n in i to j generate
	st1 : m_subtract port map (x(n), x(n-K), delayK(n));
	st2 : m_subtract port map (delayK(n), delayK(n-L), delayKL(n));
	mp : m_multiply port map (M, delayKL(n), product(n));
	acc1 : m_add port map (delayKL(n), b(n-1), b(n));
	add : m_add port map ((b(n), product(n), c(n));
	acc2 : m_add port map (c(n), y(n-1), y(n));
	end generate filter;

end arch;
