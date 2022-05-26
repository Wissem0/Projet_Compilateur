----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 10:15:23
-- Design Name: 
-- Module Name: Test_Memoire_donnee - Behavioral
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
entity Test_Memoire_donnee is
--  Port ( );
end Test_Memoire_donnee ;

architecture Behavioral of Test_Memoire_donnee is

component Memoire_donnee is
     Port ( Reset : in STD_LOGIC;
            RW : in STD_LOGIC;
            Adresse : in STD_LOGIC_VECTOR (7 downto 0);
            Entre : in STD_LOGIC_VECTOR (7 downto 0);
            Clock : in STD_LOGIC;
            Sortie : out STD_LOGIC_VECTOR (7 downto 0));
end component;


--inputs
signal Test_Reset:  STD_LOGIC := '0' ;
signal Test_RW: STD_LOGIC :='0' ;
signal Test_Adresse:  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal Test_Entre: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal Test_Clock: STD_LOGIC :='0' ;


--Outputs
signal Test_Sortie: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

constant Clock_period : time := 10 ns;
begin

Label_uut: Memoire_donnee port map(

Reset =>Test_Reset,
RW => Test_RW,
Adresse => Test_Adresse,
Entre => Test_Entre,
Sortie => Test_Sortie,
Clock => Test_Clock
);

Clock_process : process
begin
Test_Clock <= not(Test_Clock);
wait for Clock_period/2;
end process;
-- Stimulus process

Test_Reset <= '1', '0' after 20ns ;
Test_RW <= '0';
Test_Adresse <= "00001000";
Test_Entre <= "10001000";


end Behavioral;
