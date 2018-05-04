-- fsm.vhd: Finite State Machine
-- Author(s): Radoslav Grenčík, xgrenc00@stud.fit.vutbr.cz
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (K12T1, K12T2, K1T3, K2T3, K12T4, K12T5, K1T6, K2T6, K1T7, K2T7, K1T8, K2T8, K1T9, K2T9, K1T10, K2T10, K12T11, SUCCESS, FAIL, NO_ACCESS, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= K12T1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K12T1 =>
      next_state <= K12T1;
      if (KEY(1) = '1') then
         next_state <= K12T2;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K12T2 =>
      next_state <= K12T2;
      if (KEY(1) = '1') then
         next_state <= K1T3;
      elsif (KEY(3) = '1') then
         next_state <= K2T3;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K1T3 =>
      next_state <= K1T3;
      if (KEY(5) = '1') then
         next_state <= K12T4;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K2T3 =>
      next_state <= K2T3;
      if (KEY(0) = '1') then
         next_state <= K12T4;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K12T4 =>
      next_state <= K12T4;
      if (KEY(0) = '1') then
         next_state <= K12T5;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K12T5 =>
      next_state <= K12T5;
      if (KEY(1) = '1') then
         next_state <= K1T6;
      elsif (KEY(2) = '1') then
         next_state <= K2T6;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K1T6 =>
      next_state <= K1T6;
      if (KEY(3) = '1') then
         next_state <= K1T7;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K2T6 =>
      next_state <= K2T6;
      if (KEY(7) = '1') then
         next_state <= K2T7;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K1T7 =>
      next_state <= K1T7;
      if (KEY(9) = '1') then
         next_state <= K1T8;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K2T7 =>
      next_state <= K2T7;
      if (KEY(8) = '1') then
         next_state <= K2T8;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K1T8 =>
      next_state <= K1T8;
      if (KEY(2) = '1') then
         next_state <= K1T9;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K2T8 =>
      next_state <= K2T8;
      if (KEY(4) = '1') then
         next_state <= K2T9;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K1T9 =>
      next_state <= K1T9;
      if (KEY(3) = '1') then
         next_state <= K1T10;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K2T9 =>
      next_state <= K2T9;
      if (KEY(6) = '1') then
         next_state <= K2T10;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K1T10 =>
      next_state <= K1T10;
      if (KEY(0) = '1') then
         next_state <= K12T11;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K2T10 =>
      next_state <= K2T10;
      if (KEY(1) = '1') then
         next_state <= K12T11;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when K12T11 =>
      next_state <= K12T11;
      if (KEY(15) = '1') then
         next_state <= SUCCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when SUCCESS =>
      next_state <= SUCCESS;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FAIL =>
      next_state <= FAIL;
      if (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when NO_ACCESS =>
      next_state <= NO_ACCESS;
      if (CNT_OF = '1') then
        next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= K12T1;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= K12T1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when SUCCESS =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
      FSM_MX_MEM     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when NO_ACCESS =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   end case;
end process output_logic;

end architecture behavioral;
