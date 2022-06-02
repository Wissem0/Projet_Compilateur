----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 10:54:41
-- Design Name: 
-- Module Name: Memoire_instruction - Behavioral
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

entity Memoire_instruction is
    Port ( Clock : in STD_LOGIC;
           Adresse : in STD_LOGIC_VECTOR (7 downto 0);
           Sortie : out STD_LOGIC_VECTOR (31 downto 0));
end Memoire_instruction;

architecture Behavioral of Memoire_instruction is
type Reg_Vec  is array(255 downto 0) of std_logic_vector(31 downto 0);
signal tab  :   Reg_Vec;

begin
tab(0) <= x"060F0F00";
tab(1) <= x"060F0F00";
tab(2) <= x"060F0F00";
tab(3) <= x"060F0F00";
tab(4) <= x"060F0F00";
tab(5) <= x"05100000";
tab(6) <= x"060F0F00";
tab(7) <= x"060F0F00";
tab(8) <= x"060F0F00";
tab(9) <= x"060F0F00";
tab(10) <= x"01200F1F";
tab(11) <= x"02300F1F";
tab(12) <= x"03400F1F";
tab(13) <= x"060F0F00";
tab(14) <= x"060F0F00";
tab(15) <= x"060F0F00";
tab(16) <= x"08012000";
tab(17) <= x"060F0F00";
tab(18) <= x"060F0F00";
tab(19) <= x"060F0F00";
tab(20) <= x"060F0F00";
tab(21) <= x"060F0F00";
tab(22) <= x"07800100";
process
begin

 wait until Clock'Event and Clock = '1';
       Sortie <= tab(to_integer(unsigned(Adresse)));         
                               
end process;

end Behavioral;
