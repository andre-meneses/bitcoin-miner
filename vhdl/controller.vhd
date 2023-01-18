library ieee;
use ieee.std_logic_1164.all;

entity controller is
  port (
    clk, tc, cmp, leq:  in std_logic;
    reset            :   in std_logic;

    sw_1, sw_2, sd_1,sd_2,rstw_1,rstw_2, sum_1, sum_2 : out std_logic;
    rst_counter, ld_hash, ldm_1, ldm_2, golden_ticket : out std_logic; 
    s_nonce, ld_h_0, en_cmp:   out std_logic

  ) ;
end controller;

architecture main of controller is

component registrador is
  port (
      i            :   in std_logic_vector(3 downto 0);
      clk,reset    :   in std_logic;
      q            :   out std_logic_vector(3 downto 0)
  ) ;
end component;

component combinational is
  port (
    tc, cmp, leq        :  in std_logic;
    e                   :  in std_logic_vector(3 downto 0);

    sw_1, sw_2, sd_1,sd_2,rstw_1,rstw_2, sum_1, sum_2 : out std_logic;
    rst_counter, ld_hash, ldm_1, ldm_2, golden_ticket : out std_logic; 
    s_nonce, ld_h_0, en_cmp                           : out std_logic;

    ne_s                 :   out std_logic_vector(3 downto 0)

  ) ;
end component;

signal s: std_logic_vector(3 downto 0);
signal n: std_logic_vector(3 downto 0);

begin

    comb: combinational port map(tc, cmp, leq,s,
                                sw_1, sw_2, sd_1,sd_2,rstw_1,rstw_2, sum_1, sum_2,
                                rst_counter, ld_hash, ldm_1, ldm_2, golden_ticket,
                                s_nonce, ld_h_0, en_cmp, n);

    reg: registrador port map(n,clk,reset,s);
end main; -- main
