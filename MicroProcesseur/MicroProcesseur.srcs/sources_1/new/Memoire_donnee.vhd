----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 10:02:42
-- Design Name: 
-- Module Name: Memoire_donnee - Behavioral
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

entity Memoire_donnee is
    Port ( Reset : in STD_LOGIC;
           RW : in STD_LOGIC;
           Adresse : in STD_LOGIC_VECTOR (7 downto 0);
           Entre : in STD_LOGIC_VECTOR (7 downto 0);
           Clock : in STD_LOGIC;
           Sortie : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_donnee;

architecture Behavioral of Memoire_donnee is
type Reg_Vec  is array(255 downto 0) of std_logic_vector(7 downto 0);
signal tab  :   Reg_Vec;
begin
process
begin
 wait until Clock'Event and Clock = '1';
 if (Reset = '1') then 
    tab <= (others => "00000000"); 
 elsif (RW ='1') then
    Sortie <= tab(to_integer(unsigned(Adresse)));
 else 
    tab(to_integer(unsigned(Adresse))) <= Entre;
 end if;
end process;

end Behavioral;
