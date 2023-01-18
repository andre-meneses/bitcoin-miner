library ieee;
use ieee.std_logic_1164.all;

entity combinational is
  port (
    tc, cmp, leq        :  in std_logic;
    e                   :  in std_logic_vector(3 downto 0);

    sw_1, sw_2, sd_1,sd_2,rstw_1,rstw_2, sum_1, sum_2 : out std_logic;
    rst_counter, ld_hash, ldm_1, ldm_2, golden_ticket : out std_logic; 
    s_nonce, ld_h_0, en_cmp                           : out std_logic;

    ne_s                 :   out std_logic_vector(3 downto 0)

  ) ;
end combinational;

architecture main of combinational is


begin

    sw_1 <= ((not e(3)) and (((not e(2)) and e(1) and e(0)))) or 
            (e(2) and (not e(1)) and (not e(0))); 

    sw_2 <= ((not e(3)) and e(2) and e(1) and e(0)) or 
            (e(3) and (not e(2)) and (not e(1)) and (not e(0)));

    sd_1 <= ((not e(3)) and (not e(2)) and e(1)) or 
            ((not e(3)) and e(2) and (not e(1)) and (not e(0)));

    sd_2 <= ((not e(3)) and e(2) and e(1)) 
            or (e(3) and (not e(2)) and (not e(1)) and (not e(0)));

    rstw_1 <= (not e(3)) and (not e(2)) and (not e(1)) and e(0);
    rstw_2 <= (not e(3)) and e(2) and (not e(1)) and e(0);
    sum_1 <= (not e(3)) and e(2) and (not e(1)) and (not e(0));
    sum_2 <= e(3) and (not e(2)) and (not e(1)) and (not e(0));
    rst_counter <= (not e(3)) and (not e(1)) and e(0);
    ld_hash <= e(3) and (not e(2)) and (not e(1)) and (not e(0)); 
    ldm_1 <=  not(e(3) or e(2) or e(1) or e(0));
    ldm_2 <= (not e(3)) and e(2) and (not e(1)) and (not e(0)); 
    golden_ticket <= e(3) and (not e(2)) and e(1) and e(0); 
    s_nonce <= e(3) and (not e(2)) and e(1) and (not e(0));
    ld_h_0 <= not(e(3) or e(2) or e(1) or e(0)); 
    en_cmp <= e(3) and (not e(2)) and (not e(1)) and e(0);

    ne_s(3) <= (tc and (not e(3)) and e(2) and e(1) and e(0)) or 
            (e(3) and (not e(2)) and (not e(1)));

    ne_s(2)<= (tc and (not e(3)) and (not(e(2))) and e(1) and e(0)) or
               (not(e(3)) and e(2) and (not e(1))) or
               ((not e(3)) and e(2) and e(1) and (not e(0))) or
               ((not tc) and (not e(3)) and e(2) and e(1) and e(0));

    ne_s(1)<= ((not e(3)) and (not e(2)) and (not e(1)) and e(0)) or 
            ((not e(3)) and (not e(2)) and e(1) and (not e(0))) or 
            ((not tc) and (not e(3)) and e(1) and e(0)) or 
            ((not e(3)) and e(2) and (not e(1)) and e(0)) or 
            ((not e(3)) and e(2) and e(1) and (not e(0))) or 
            (e(3) and (not e(2)) and (not e(1)) and e(0));

    ne_s(0)<= (not (e(3) or e(2) or e(1) or e(0))) or
            ((not leq) and (not e(3)) and e(1) and (not e(0))) or
            ((not tc) and (not e(3)) and (not e(2)) and e(1) and e(0)) or
            ((not e(3)) and e(2) and (not e(1)) and (not e(0))) or
            ((not tc) and (not e(3)) and e(1) and e(0)) or
            (e(3) and (not e(2)) and (not e(1)) and (not e(0))) or 
            (cmp and e(3) and (not e(2)) and (not e(1)) and e(0)) or
            (e(3) and (not e(2)) and e(1) and (not e(0))); 

end main; --
