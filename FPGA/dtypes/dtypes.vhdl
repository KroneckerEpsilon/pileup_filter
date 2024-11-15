library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use ieee.fixed_pkg.all;
use ieee.fixed_float_types.all;

package sipm is	
	type sipmhit is 
	record 
	   n : signed(15 downto 0);
	   o : std_logic;
	end record;
	type dsphit is 
	record
	   n : sfixed(15 downto -16);
	   o : std_logic;
	end record;
	type arhit is 
	record
	   n : sfixed(31 downto -32);
	   o : std_logic;
	end record;
end package;	

package body sipm is 

end package body;
