----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 11:55:42
-- Design Name: 
-- Module Name: EX_Mem - Behavioral
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

entity EX_Mem is
    Port ( 
        Clock : in STD_LOGIC;
        OP_entre : in STD_LOGIC_VECTOR (7 downto 0);
        A_entree : in STD_LOGIC_VECTOR (7 downto 0);
        B_entree : in STD_LOGIC_VECTOR (7 downto 0);
        Sortie_op : out STD_LOGIC_VECTOR (7 downto 0);
        Sortie_A : out STD_LOGIC_VECTOR (7 downto 0);
        Sortie_B : out STD_LOGIC_VECTOR (7 downto 0));
end EX_Mem;


architecture Behavioral of EX_Mem is

begin

process (Clock)
begin
      Sortie_op <= OP_entre;
      Sortie_A <= A_entree;
      Sortie_B <= B_entree;
end process;


end Behavioral;
