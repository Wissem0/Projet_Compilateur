----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 11:37:46
-- Design Name: 
-- Module Name: LI_DI - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LI_DI is
    Port ( Clock : in STD_LOGIC;
           OP_entre : in STD_LOGIC_VECTOR (7 downto 0);
           A_entree : in STD_LOGIC_VECTOR (7 downto 0);
           B_entree : in STD_LOGIC_VECTOR (7 downto 0);
           C_entree : in STD_LOGIC_VECTOR (7 downto 0);
           Sortie_op : out STD_LOGIC_VECTOR (7 downto 0);
           Sortie_A : out STD_LOGIC_VECTOR (7 downto 0);
           Sortie_B : out STD_LOGIC_VECTOR (7 downto 0);
           Sortie_C : out STD_LOGIC_VECTOR (7 downto 0));
end LI_DI;

architecture Behavioral of LI_DI is

begin

process (Clock)
begin

      Sortie_op <= OP_entre;
      Sortie_A <= A_entree;
      Sortie_B <= B_entree;
      Sortie_C <= C_entree;
end process;      

end Behavioral;
