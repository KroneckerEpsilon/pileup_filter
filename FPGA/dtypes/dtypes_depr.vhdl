library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package sipm is
    constant bdepth_x : integer := 16;
    constant bdepth_y : integer := 16;
	type dsphit is 
		record
			x : STD_LOGIC_VECTOR(bdepth_x-1 DOWNTO 0);
			y : STD_LOGIC_VECTOR(bdepth_y-1 DOWNTO 0);
			o : STD_LOGIC; -- 1 means overflow in type conversion or some other error occured
		end record;
	type arhit is 
		record
			x : STD_LOGIC_VECTOR(2*bdepth_x-1 DOWNTO 0);
			y : STD_LOGIC_VECTOR(2*bdepth_y-1 DOWNTO 0);
			o : STD_LOGIC; -- 1 means some error, divison by zero occured
		end record;
	function ar_to_dsp(v: arhit) return dsphit;
	function dsp_add(one: dsphit:= (x => (others => '0'), y => (others => '0'), o => '0'); 
                     two: dsphit:= (x => (others => '0'), y => (others => '0'), o => '0')) return dsphit;
end package;

package body sipm is

  function ar_to_dsp (v: arhit) return dsphit is 
  variable a: dsphit := (x => (others => '0'), y => (others => '0'), o => '0');
  constant n_vec : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  begin 
  a.o := v.o; -- if v data is faulty, a is too
    if v.x(2*bdepth_x-1 downto bdepth_x) /= n_vec then
        a.x := (others => '1'); -- overflow prevention
        a.o := '1';
    else
        a.x := v.x(bdepth_x-1 downto 0); 
    end if; 
    a.y := v.y(2*bdepth_y-1 downto bdepth_y);
    return a; 
  end ar_to_dsp;
  
  function dsp_add(one: dsphit:= (x => (others => '0'), y => (others => '0'), o => '0'); 
                   two: dsphit:= (x => (others => '0'), y => (others => '0'), o => '0')) return dsphit is
  variable out1: dsphit:= (x => (others => '0'), y => (others => '0'), o => '0');
  variable added: std_logic_vector(31 downto 0);
  begin
  added := std_logic_vector(unsigned(one.x&one.y)+unsigned(two.x&two.y));
    out1.x(15 downto 0) := added(31 downto 16);
    --out1.x(15) <= one.x(15) nand two.x(15);
    out1.y := added(15 downto 0);
    out1.o := one.o or two.o or (one.x(15) and two.x(15));
    return out1;
  end dsp_add;
  
end package body;	
