----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2024 16:51:41
-- Design Name: 
-- Module Name: sipmtypes - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.fixed_pkg.all;
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

