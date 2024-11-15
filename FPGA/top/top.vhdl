library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.fixed_pkg.all;

library std;
use std.textio.all;
use work.sipm.all;

entity x is 
port(	
    i_clk:		in std_logic;
    o_clk:      out std_logic;
	i_rst:		in std_logic;
	i_origin1:  in sipmhit;
	o_origin1:	out sipmhit;
	o_dsp:      out dsphit; -- new clock domain averaged signal TODO: implement radix with 
	o_counter:  out integer; -- dsp counter TODO: implement as std_logic_vector
	o_main1:	out arhit; -- filtered signel in new clock domain
	--o_tstamp:	out std_logic_vector(31 downto 0)
	o_dsp_v:out std_logic;
	o_pre_dsp_v:out std_logic
);
end x;

architecture arch of x is

    signal s_sipm1 : dsphit;
    signal s_clk : std_logic;

    component downsampling is
    port(
        i_clk :     in std_logic;
        o_clk :     out std_logic;
        o_counter : out integer;
        i_rst:		in std_logic;
		i_sipm1:	in sipmhit;
		o_sipm1:	out dsphit;
		o_pre_dsp_v:  out std_logic;
	    o_dsp_v:    out std_logic
    );
    end component;
    
	component trapezoidal is 
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
	end component;

begin
	dsp: downsampling port map(i_clk=>i_clk, o_clk=>s_clk, o_counter=>o_counter, i_rst=>i_rst, i_sipm1=>i_origin1, o_sipm1=>s_sipm1, o_pre_dsp_v=> o_pre_dsp_v, o_dsp_v=> o_dsp_v);
	flt: trapezoidal port map (i_clk=>s_clk, i_rst=>i_rst, i_sipm1=>s_sipm1, o_sipm1f=>o_main1);
	o_origin1 <= i_origin1;
	o_dsp <= s_sipm1;
	o_clk <= s_clk;
end architecture;	
