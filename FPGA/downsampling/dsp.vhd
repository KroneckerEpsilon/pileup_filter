library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.fixed_pkg.all;

use work.sipm.all;

entity downsampling is 
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
end downsampling;

architecture arch of downsampling is

--- COMPONENT DECLARATION

    COMPONENT div_gen_0 IS
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_divisor_tvalid : IN STD_LOGIC;
    s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axis_dividend_tvalid : IN STD_LOGIC;
    s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tuser : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

    constant ds : integer := 50;
    -- 
    signal v_counter : integer := 0;
    signal s_valid : std_logic := '0';
    signal s_clockout : std_logic := '0';
    signal s_sipm1out : sipmhit := (n => (others => '0'), o => '0');
    signal div_out : std_logic_vector(31 downto 0);
    signal tuser : std_logic_vector(0 downto 0) := (others => '0');
begin    
    counting : process(i_clk, i_rst)
        variable v_sipm1out : sipmhit := (n => (others => '0'), o => '0');
    begin
        if (rising_edge(i_clk)) then
            v_counter <= v_counter + 1;
            v_sipm1out.n := v_sipm1out.n + i_sipm1.n;
            if v_counter = ds-1 then
                s_valid <= '0';
            elsif v_counter = 2*ds-1 then
                s_clockout <= not s_clockout;
                s_sipm1out <= v_sipm1out;
                v_counter <= 0;
                s_valid <= '1';                
                v_sipm1out := (n => (others => '0'), o => '0');
            elsif v_counter = 2*ds then
            end if;
        end if;

    end process counting; 
    o_clk <= s_clockout;
    o_counter <= v_counter; 
    
    div: div_gen_0 port map(aclk => i_clk,
                            s_axis_divisor_tvalid => s_valid,
                            s_axis_divisor_tdata => std_logic_vector(to_signed(ds, 16)),
                            s_axis_dividend_tvalid => s_valid,
                            s_axis_dividend_tdata => std_logic_vector(s_sipm1out.n),
                            m_axis_dout_tvalid => o_dsp_v,
                            m_axis_dout_tuser => tuser,
                            m_axis_dout_tdata => div_out);
    o_sipm1.n <= to_sfixed(signed(div_out),15, -16);
    o_sipm1.o <= tuser(0);
    o_pre_
end arch;