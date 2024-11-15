----------------------------------------------------------------------------------
-- Engineer: Jan Küpperbusch
-- 
-- Create Date: 17.09.2024 16:41:02
-- Design Name: 
-- Module Name: dummy - Behavioral
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


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sipm.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dummy is
port(
     clk:   in std_logic;
     one:   in dsphit;
     o_valid: in std_logic;
     two:   in dsphit;
     t_valid: in std_logic;
     out1:  out dsphit;       --add
     out2:  out arhit;        --multiply 
     out3:  out arhit        --divide
);
end dummy;

architecture Behavioral of dummy is

    COMPONENT mult_gen_0 IS
    PORT (
        CLK : IN STD_LOGIC;
        A   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        P   : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
    END COMPONENT;
    
  COMPONENT div_gen_0 IS
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_divisor_tvalid : IN STD_LOGIC;
    s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_dividend_tvalid : IN STD_LOGIC;
    s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END COMPONENT;
    
    signal multiplied : std_logic_vector(63 downto 0);
    signal divided : std_logic_vector(63 downto 0);
    signal divided_tuser : std_logic_vector(0 downto 0);
    --signal divided_tuser : std_logic;
    signal a : std_logic_vector(31 downto 0);
    signal b : std_logic_vector(31 downto 0);
    signal added : std_logic_vector(31 downto 0);
  
begin
    
    out1 <= dsp_add(one, two);
    --added <= std_logic_vector(unsigned(one.x&one.y)+unsigned(two.x&two.y));
    --out1.x(15 downto 0) <= added(31 downto 16);
    --out1.x(15) <= one.x(15) nand two.x(15);
    --out1.y <= added(15 downto 0);
    --out1.o <= one.o or two.o or (one.x(15) and two.x(15));
    a <= one.x&one.y;
    b <= two.x&two.y;
    mult : mult_gen_0 port map(CLK=>clk, 
                               A=>a, 
                               B=>b, 
                               P=>multiplied);
    out2.x <= multiplied(63 downto 32);
    out2.y <= multiplied(31 downto 0);
    out2.o <= one.o or two.o;
    
    div : div_gen_0 port map(aclk=>clk,
                             s_axis_divisor_tvalid =>o_valid,
                             s_axis_divisor_tdata => a,
                             s_axis_dividend_tvalid =>t_valid,
                             s_axis_dividend_tdata => b,
                             --m_axis_dout_tvalid => divided_tuser(0),
                             m_axis_dout_tuser => divided_tuser,
                             m_axis_dout_tdata => divided);
    out3.x <= divided(63 downto 32);
    out3.y <= divided(31 downto 0);
    out3.o <= divided_tuser(0);   
end Behavioral;
