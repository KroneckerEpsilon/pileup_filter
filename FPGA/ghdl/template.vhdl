library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity a is 
end a;

architecture arch of a is 
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	constant clkperiod : time := 1 ns;
begin
	clk <= not clk after clkperiod / 2;
	rst <= '1' after 3 ns;
end arch;
