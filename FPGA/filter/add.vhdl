library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sipm.all;

entity m_add is
	port(	i_first: 	in sipmhit;
		i_second:	in sipmhit;
		o_out:		out sipmhit
	);
end m_add;

architecture arch of m_add is
begin
	o_out <= i_first + i_second;
end arch;

