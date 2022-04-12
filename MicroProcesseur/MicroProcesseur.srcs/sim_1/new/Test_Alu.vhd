----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 09:07:47
-- Design Name: 
-- Module Name: Test_Alu - Behavioral
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
entity Test_Alu is 

end Test_Alu;



architecture Behavioral of Test_Alu is

component ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC
 );
end component;

--inputs
signal Test_A:  std_logic_vector(7 downto 0) := (others => '0');
signal Test_B :  std_logic_vector(7 downto 0) := (others => '0');
signal Test_Ctrl_Alu: std_logic_vector(2 downto 0) := (others => '0');

--Outputs
signal Test_S : std_logic_vector(7 downto 0);
signal Test_N: std_logic ;
signal Test_O: std_logic ;
signal Test_Z: std_logic ;
signal Test_C: std_logic ;

begin

Label_uut: ALU port map(

A => Test_A,
B => Test_B,
Ctrl_Alu => Test_Ctrl_Alu,
S => Test_S ,
N => Test_N ,
O => Test_O ,
Z => Test_Z ,
C => Test_C 
);


-- Stimulus process
Test_A <= "10000011" ;
Test_B <=  "10001010" , "10000011" after 20ns ;
Test_Ctrl_Alu <= "000", "001" after 20 ns;

end Behavioral;
