library ieee;
use ieee.std_logic_1164.all;

entity flipflop_d is
  port (
    d,clk        :   in std_logic;
    reset        :   in std_logic;
    q            :   out std_logic
  ) ;
end flipflop_d;

architecture main of flipflop_d is

begin

process(d,clk)
begin
    if(clk'event  and clk = '1') then 
      if(reset = '1') then
        q <= '0';
      else 
        q <= d;
      end if;
    end if;
end process;

end main ; -- main
