----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2022 10:52:24
-- Design Name: 
-- Module Name: Test_MicroProcesseur - Behavioral
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

entity Test_MicroProcesseur is
--  Port ( );
end Test_MicroProcesseur;

architecture Behavioral of Test_MicroProcesseur is

component MicroProcesseur is
    Port ( Clock : in STD_LOGIC;
          Adresse : in STD_LOGIC_VECTOR (7 downto 0)
 );
end component;

--inputs
signal Test_Clock:  STD_LOGIC :='0' ;
signal Test_Adresse :  std_logic_vector(7 downto 0) := (others => '0');

constant Clock_period : time := 10 ns;
begin

Label_uut: MicroProcesseur port map(
Clock => Test_Clock,
Adresse => Test_Adresse
);



Clock_process : process
begin
Test_Clock <= not(Test_Clock);
wait for Clock_period/2;
end process;
-- Stimulus process


Test_Adresse <= "00000000",  "00000001" after 200ns, "00000010" after 400ns, "00000011" after 600ns, "00000100" after 800ns;



end Behavioral;
