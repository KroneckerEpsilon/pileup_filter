library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package sipm is
	type sipmhit is 
		record
			v : integer;
		end record;
	
	function add (

	a : sipmhit;
	b : sipmhit
	) return integer;

	function substract(
	a : sipmhit;
	b : sipmhit
	) return integer;

	function multiply(
	a : integer;
	b : sipmhit
	) return integer;
end package;

package body sipm is
	function add (
	a : sipmhit;
	b : sipmhit
	) return integer is
	begin
		return a.v + b.v;
	end function;

	function substract(
	a : sipmhit;
	b : sipmhit
	) return integer is
	begin
		return a.v - b.v;
	end function;

	function multiply(
	a : integer;
	b : sipmhit
	) return integer is
	begin
		return a * b.v;
	end function;
end package body;	
