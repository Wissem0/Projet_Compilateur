----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 08:46:48
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal Aux : STD_LOGIC_VECTOR (7 downto 0)  := "00000000";
signal tmp: std_logic_vector (8 downto 0);

begin 
--if (Aux = "00000000") then Z <= '1';
--else Z <= '0';
--end if;


process (A,B,Ctrl_Alu)
begin

case Ctrl_Alu is 
when "000" => Aux <= A + B;
when "001" => Aux <= A - B;
when "010" => Aux <=  std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),8)) ;
when "011" => Aux(6 downto 0) <= A (7 downto 1);
when others => Aux <= "00000000";
end case;




end process;


S <= Aux;
tmp <= ('0' & A) + ('0' & B);
C <= tmp(8);
Z <= '1' when Aux = "00000000" else '0';
end Behavioral;
