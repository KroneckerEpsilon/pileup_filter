library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sipm.all;

entity trapezoidal is 
	generic(
	M	: integer := 1;
	K	: integer := 10;
	L	: integer := 3
	);
	port(	i_clk:		in std_logic;
		i_rst:		in std_logic;
		i_sipm1:	in sipmhit;
		o_sipm1f:	out sipmhit
	);
end trapezoidal;

architecture arch of trapezoidal is

	component m_add is
	port(i_first: 	in sipmhit;
	     i_second:  in sipmhit;
	     o_out: 	out sipmhit
     	);
	end component;
	
	component m_subtract is
	port(i_first: 	in sipmhit;
	     i_second:  in sipmhit;
	     o_out: 	out sipmhit
     	);
	end component;
	
	component m_multiply is
	port(i_first: 	in integer;
	     i_second:  in sipmhit;
	     o_out: 	out sipmhit
     	);
	end component;
	
	constant i : integer := 0;
	constant j : integer := 20;
	
	type sipmhit_array is array(j downto i) of sipmhit;

	signal zero		: sipmhit := 0;
	signal x 		: sipmhit_array;
	signal delayK 		: sipmhit_array;
	signal delayL 		: sipmhit_array;
	signal delayKL 		: sipmhit_array;
	signal b 		: sipmhit_array;
	signal c 		: sipmhit_array;
	signal product 		: sipmhit_array;
	signal y 		: sipmhit_array;
begin
	evol: process (i_clk, i_rst) is
	begin
		if(i_rst = '1') then
			x <= (others => zero);
		end if;
		if(rising_edge(i_clk)) then
			for n in i to j-1 loop
				x(n+1) <= x(n);
				x(0) <= i_sipm1;
			end loop;
		end if;
	end process;
		
		
	
	loop_f: for n in i to j-1 generate
	
		-- First Subtraction
		sub: if(j-K >= n-K and n-K >= 0) generate
		--	report "x(n)" & integer'image(x(n));
		--	report "x(n-K)" & integer'image(x(n-K));
		--	report "delayK(n)" & integer'image(delayK(n));
			st1 : m_subtract port map (x(n), x(n-K), delayK(n));
		else generate
			st1 : m_subtract port map (x(n), zero, delayK(n));
		end generate;
		-- Second Subtraction	
		sub2: if (j-L >= n-L and n-L >= 0) generate
			st2 : m_subtract port map (delayK(n), delayK(n-L), delayKL(n));
		else generate
			st2 : m_subtract port map (delayK(n), zero, delayKL(n));
		end generate;
		-- Multiplication with M
		mp : m_multiply port map (M, delayKL(n), product(n));
		-- Adding of the rest of signals
		adding: if (j-1 >= n-1 and n-1 >= 0) generate 
			acc1 : m_add port map (delayKL(n), b(n-1), b(n));
			add : m_add port map (b(n), product(n), c(n));
			acc2 : m_add port map (c(n), y(n-1), y(n));
		else generate
			acc1 : m_add port map (delayKL(n), zero, b(n));
			add : m_add port map (b(n), product(n), c(n));
			acc2 : m_add port map (c(n), zero, y(n));
		end generate;
	end generate;
--	filter: for n in i to j generate 
--			if (n-K >= 0) generate
--				st1 : m_subtract port map (x(n), x(n-K), delayK(n));
--			else generate
--				st1 : m_subtract port map (x(n), 0, delayK(n));
--			end generate;
--		end loop filter;
--		if (n-L >= 0) then
--			st2 : m_subtract port map (delayK(n), delayK(n-L), delayKL(n));
--		else
--			st2 : m_subtract port map (delayK(n), 0, delayKL(n));
--		end if;
--		mp : m_multiply port map (M, delayKL(n), product(n));
--		
--		if (n-1 >= 0) then
--			acc1 : m_add port map (delayKL(n), b(n-1), b(n));
--			add : m_add port map (b(n), product(n), c(n));
--			acc2 : m_add port map (c(n), y(n-1), y(n));
--		else
--			acc1 : m_add port map (delayKL(n), 0, b(n));
--			add : m_add port map (b(n), product(n), c(n));
--			acc2 : m_add port map (c(n), 0, y(n));
--		end if;
--	--end generate filter;
--	o_sipm1f <= y(0);
end arch;
