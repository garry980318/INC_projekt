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
   type t_state is (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, ACCESS_OK, NO_ACCESS, FAIL, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= T1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
variable KOD : integer;
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T1 =>
      next_state <= T1;
      if (KEY(1) = '1') then
         next_state <= T2;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T2 =>
      next_state <= T2;
      if (KEY(1) = '1') then
         KOD := 1;
         next_state <= T3;
      elsif (KEY(3) = '1') then
         KOD := 2;
         next_state <= T3;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T3 =>
      next_state <= T3;
      if (KEY(5) = '1') and (KOD = 1) then
         next_state <= T4;
      elsif (KEY(0) = '1') and (KOD = 2) then
         next_state <= T4;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T4 =>
      next_state <= T4;
      if (KEY(0) = '1') then
         next_state <= T5;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T5 =>
      next_state <= T5;
      if (KEY(1) = '1') and (KOD = 1) then
         next_state <= T6;
      elsif (KEY(2) = '1') and (KOD = 2) then
         next_state <= T6;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T6 =>
      next_state <= T6;
      if (KEY(3) = '1') and (KOD = 1) then
         next_state <= T7;
      elsif (KEY(7) = '1') and (KOD = 2) then
         next_state <= T7;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T7 =>
      next_state <= T7;
      if (KEY(9) = '1') and (KOD = 1) then
         next_state <= T8;
      elsif (KEY(8) = '1') and (KOD = 2) then
         next_state <= T8;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T8 =>
      next_state <= T8;
      if (KEY(2) = '1') and (KOD = 1) then
         next_state <= T9;
      elsif (KEY(4) = '1') and (KOD = 2) then
         next_state <= T9;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T9 =>
      next_state <= T9;
      if (KEY(3) = '1') and (KOD = 1) then
         next_state <= T10;
      elsif (KEY(6) = '1') and (KOD = 2) then
         next_state <= T10;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T10 =>
      next_state <= T10;
      if (KEY(0) = '1') and (KOD = 1) then
         next_state <= T11;
      elsif (KEY(1) = '1') and (KOD = 2) then
         next_state <= T11;
      elsif (KEY(15) = '1') then
         next_state <= NO_ACCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when T11 =>
      next_state <= T11;
      if (KEY(15) = '1') then
         next_state <= ACCESS_OK;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= FAIL;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when ACCESS_OK =>
      next_state <= ACCESS_OK;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when NO_ACCESS =>
      next_state <= NO_ACCESS;
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
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= T1;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= T1;
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
   when ACCESS_OK =>
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
   end case;
end process output_logic;

end architecture behavioral;
