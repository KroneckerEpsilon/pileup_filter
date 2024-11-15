library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sipm.all;
use ieee.fixed_pkg.all;

library std;
use std.textio.all;

entity tb is 
end tb;

architecture arch of tb is 
	signal clkin : std_logic := '1';
	signal clkout : std_logic;
	signal rst : std_logic := '0';
	constant freq : time := 2 ns;
    signal s_counter : integer := 0;
	signal s_dsp : dsphit := (n => (others => '0'), o => '0');
	signal o : sipmhit := (n => (others => '0'), o => '0');
	signal m : arhit := (n => (others => '0'), o => '0');
	signal tstamp : std_logic_vector(31 downto 0) := (others => '0');
	signal s_sipm1 : sipmhit := (n => (others => '0'), o => '0');
	signal s_sipm1async : sipmhit := (n => (others => '0'), o => '0');
	signal dsp_v : std_logic := '0';
    signal pre_dsp_v : std_logic := '0';
	component x is 
	port(	
	    i_clk:		in std_logic;
	    o_clk:      out std_logic;
	    o_counter:  out integer;
		i_rst:		in std_logic;
		i_origin1:  in sipmhit;
		o_origin1:	out sipmhit;
		o_dsp:      out dsphit;
		o_main1:	out arhit;
		--o_tstamp:	out std_logic_vector(31 downto 0)
		o_dsp_v:    out std_logic;
	    o_pre_dsp_v:out std_logic
	);
	end component;
begin	
	
	process

        file f_data: text;
		--file f_data 	  	: text open read_mode is "sipm2data0ev4.txt";
		variable fstatus       :file_open_status;
		--file f_data 	  	: text open read_mode is "sipm2data0ev4.txt";
		Variable row 	  	: line;
		Variable v_sipm1  	: sipmhit;
		Variable v_sipm1int : integer := 0;
		Variable v_rcount 	: integer := 0;

	begin
		if rst ='1' then
			v_rcount := 0;
			v_sipm1  := (n =>(others => '0'), o => '0');
		end if;
		file_open(fstatus, f_data, "sipm2data0ev4.txt", read_mode);
		    while not endfile(f_data) loop
				tstamp <= std_logic_vector(unsigned(tstamp)+to_unsigned(1, tstamp'length));
				readline(f_data, row);
				if row'length<=0 or row.all(1)='#' then
				    next;
				end if;
				read(row, v_sipm1int);
				v_sipm1.n := to_signed(v_sipm1int, v_sipm1.n'length);
				v_sipm1.o := '0';
				s_sipm1async <= v_sipm1;
				wait for freq;
			end loop;
	end process;
	
	sync: process(clkin) 
	begin 
	   if rising_edge(clkin) then
	       s_sipm1 <= s_sipm1async;
	   end if;
	end process sync;

	clkin <= not clkin after freq/2;
	--rst <= '1' after 2 us, '0' after 2200 ns;

	complete: x port map(i_clk => clkin, o_clk=>clkout, o_counter=>s_counter, i_rst => rst, i_origin1 => s_sipm1, o_origin1 => o, o_dsp=>s_dsp , o_main1 => m, o_pre_dsp_v => pre_dsp_v, o_dsp_v => dsp_v);
end arch;
