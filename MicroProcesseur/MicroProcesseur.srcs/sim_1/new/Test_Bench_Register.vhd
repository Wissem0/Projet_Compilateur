----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2022 11:48:19
-- Design Name: 
-- Module Name: Test_Bench_Register - Behavioral
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

entity Test_Bench_Register is
--  Port ( );
end Test_Bench_Register;

architecture Behavioral of Test_Bench_Register is

component Bench_Register is
    Port ( Reset : in STD_LOGIC;
           Clock : in STD_LOGIC;
           Ad_A : in STD_LOGIC_VECTOR (3 downto 0);
           Ad_B : in STD_LOGIC_VECTOR (3 downto 0);
           Ad_W : in STD_LOGIC_VECTOR (3 downto 0);
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           W : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--inputs
signal Test_Reset:  STD_LOGIC := '0' ;
signal Test_Clock: STD_LOGIC :='0' ;
signal Test_Ad_A :  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Test_Ad_B: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Test_Ad_W: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Test_W:  STD_LOGIC;
signal Test_Data: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');





--Outputs
signal Test_QA: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal Test_QB: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

constant Clock_period : time := 10 ns;
begin

Label_uut: Bench_Register port map(

Reset =>Test_Reset,
Clock => Test_Clock,
Ad_A =>Test_Ad_A,
Ad_B =>Test_Ad_B,
Ad_W =>Test_Ad_W,
Data =>Test_Data,
W =>Test_W,
QA =>Test_QA,
QB =>Test_QB
);

Clock_process : process
begin
Test_Clock <= not(Test_Clock);
wait for Clock_period/2;
end process;
-- Stimulus process
Test_Reset <= '1', '0' after 20ns ;
Test_Data <= "10000101" after 20ns ;
Test_Ad_W <="0001" after 20ns ;
Test_W <= '1' after 20ns ;
Test_Ad_A <= "0000" after 20ns ;
Test_Ad_B <= "0001" after 20ns ;
end Behavioral;