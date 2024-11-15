------------------------
--TODO 17.09.24
--Implement addition and multiplication correctly
--
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.fixed_float_types.all; -- ieee_proposed for VHDL-93 version
use ieee.fixed_pkg.all; -- ieee_proposed for compatibility version
use work.sipm.all;

library std;
use std.textio.all;

entity tb is 
end tb;

architecture arch of tb is 
	signal clkin : std_logic := '1';
	constant freq : time := 2 ns;
	constant n : integer := 8;
	
	signal s_sipm1int : dsphit := (x => (others =>'0'), y => (others => '0'), o => '0');
	signal s_sipm2int : dsphit := (x => (others =>'0'), y => (others => '0'), o => '0');
	
	--signal s_sipm1f : ufixed(15 downto -16) := (others => '0');
	--signal s_sipm2f : ufixed(15 downto -16) := (others => '0');
	
	signal o_v : std_logic := '0';
	signal t_v : std_logic := '0';	

	signal out1 : dsphit := (x => (others =>'0'), y => (others => '0'), o => '0');
    signal out2 : arhit := (x => (others =>'0'), y => (others => '0'), o => '0');
    signal out3 : arhit := (x => (others =>'0'), y => (others => '0'), o => '0');
    
    
    component dummy is
    port(
        clk:   in std_logic;
        one:   in dsphit;
        o_valid: in std_logic;
        two:   in dsphit;
        t_valid: in std_logic;
        out1:  out dsphit;
        out2:  out arhit;
        out3:  out arhit);
    end component;

begin
	process
        
        variable fstatus       :file_open_status;
        file f_data: text;
		file f_data2: text;
		--file f_data 	  	: text open read_mode is "sipm2data0ev4.txt";
		file f_out          : text open write_mode is "sipm.log";
		Variable row 	  	: line;
		Variable row2 	  	: line;
		Variable v_sipm1  	: dsphit;
		Variable v_sipm1int : integer := 0;
		Variable v_sipm2int : integer := 0;
		Variable v_rcount 	: integer := 0;
		Variable outline    : line;

	begin
		file_open(fstatus, f_data2, "16bittest2.txt", read_mode);
		file_open(fstatus, f_data, "16bittest.txt", read_mode);
		while(not endfile(f_data)) loop 
			--tstamp <= tstamp+std_logic_vector(to_unsigned(1, tstamp'length));
			--if rising_edge(clkin)
			readline(f_data, row);	
			if row'length=0 or row.all(1)='#' then
				next;
			end if;
			read(row, v_sipm1int);
			--s_sipm1f <= to_ufixed(v_sipm1int, 15, -16);
			s_sipm1int.x <= std_logic_vector(to_unsigned(v_sipm1int, s_sipm1int.x'length)); 
			writeline(f_out, outline);
			--end if;
			wait for n * freq;
			end loop;
			
		while(not endfile(f_data2)) loop 
			--tstamp <= tstamp+std_logic_vector(to_unsigned(1, tstamp'length));
			--if rising_edge(clkin)
			readline(f_data2, row2);	
			if row2'length=0 or row2.all(1)='#' then
				next;
			end if;
			read(row2, v_sipm2int);
			--s_sipm2f <= to_ufixed(v_sipm2int, 15, -16);
			s_sipm2int.x <= std_logic_vector(to_unsigned(v_sipm2int, s_sipm1int.x'length)); 
			--writeline(f_out, outline);
			--end if;
			wait for n * freq;
			end loop;
		wait;
		
	end process;
	
	
	sync : process(clkin) 	
	variable c : integer := 0;
	begin
	   if rising_edge(clkin) then
	   c := c+1;
	       if c = n-1 then
	       --s_sipm2int.y <= s_sipm1int.x;
	       --s_sipm1int.y <= s_sipm2int.y;
	       --s_sipm2int.y <= s_sipm1int.y;
	       --c := 0;
	       --c := 0;
	       o_v <= '1';
	       t_v <= '1';
	       elsif c = n then
	       o_v <= '0';
	       t_v <= '0';
	       c := 0;
	       end if;
	   end if;
	end process sync;
        
	clkin <= not clkin after freq/2;
	
    dm: dummy port map(clk=>clkin, 
    one=>s_sipm1int, 
    o_valid => o_v, 
    two=>s_sipm2int, 
    t_valid => t_v, 
    out1=>out1, 
    out2=>out2, 
    out3=>out3);
end arch;
