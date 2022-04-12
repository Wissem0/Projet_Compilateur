----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 11:15:56
-- Design Name: 
-- Module Name: Bench_Register - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bench_Register is
    Port ( Reset : in STD_LOGIC;
           Clock : in STD_LOGIC;
           Ad_A : in STD_LOGIC_VECTOR (3 downto 0);
           Ad_B : in STD_LOGIC_VECTOR (3 downto 0);
           Ad_W : in STD_LOGIC_VECTOR (3 downto 0);
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           W : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Bench_Register;


architecture Behavioral of Bench_Register is
type Reg_Vec  is array(15 downto 0) of std_logic_vector(7 downto 0);
signal tab  :   Reg_Vec;

begin
process
begin

 wait until Clock'Event and Clock = '1';
 if (Reset = '1') then 
               tab(0)   <="00000000";
               tab(1)   <= "00000000";
               tab(3)   <= "00000000";
               tab(4)   <= "00000000";
               tab(5)   <="00000000";
               tab(6)   <= "00000000";
               tab(7)   <= "00000000";
               tab(8)   <= "00000000";
               tab(9)   <= "00000000";
               tab(10)   <= "00000000";
               tab(11)   <= "00000000";
               tab(12)   <= "00000000";
               tab(13)   <= "00000000";
               tab(14)   <= "00000000";
               tab(15)   <= "00000000";
  elsif (W = '0') then 
               QA <= tab(to_integer(unsigned(Ad_A)));
               QB <= tab(to_integer(unsigned(Ad_B)));
  else    
               QA <= tab(to_integer(unsigned(Ad_A)));
               QB <= tab(to_integer(unsigned(Ad_B)));    
               tab(to_integer(unsigned(Ad_W))) <= Data ;         
 end if;          

end process;

end Behavioral;
