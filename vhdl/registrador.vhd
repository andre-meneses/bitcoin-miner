library ieee;
use ieee.std_logic_1164.all;

entity registrador is
  port (
      i            :   in std_logic_vector(3 downto 0);
      clk,reset    :   in std_logic;
      q            :   out std_logic_vector(3 downto 0)
  ) ;
end registrador;

architecture main of registrador is

component flipflop_d is
  port (
    d,clk        :   in std_logic;
    reset        :   in std_logic;
    q            :   out std_logic
  ) ;
end component;

begin

    r3: flipflop_d port map(i(3),clk,reset,q(3));
    r2: flipflop_d port map(i(2),clk,reset,q(2));
    r1: flipflop_d port map(i(1),clk,reset,q(1));
    r0: flipflop_d port map(i(0),clk,reset,q(0));

end main ; -- main
