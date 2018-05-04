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
   type t_state is (TEST1, PRINT_MESSAGE, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST1;
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
         next_state <= K12T2
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
   when PRINT_MESSAGE =>
      next_state <= PRINT_MESSAGE;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST1;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST1;
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
   when TEST1 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE =>
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
   end case;
end process output_logic;

end architecture behavioral;
