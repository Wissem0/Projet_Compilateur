----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 12:06:12
-- Design Name: 
-- Module Name: MicroProcesseur - Behavioral
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
use ieee.NUMERIC_STD.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MicroProcesseur is
 Port ( 
          Clock : in STD_LOGIC;
          Adresse : in STD_LOGIC_VECTOR (7 downto 0));
end MicroProcesseur;

architecture Behavioral of MicroProcesseur is


----------------------------------Déclaration Component -----------------------------------------------------


--Mémoire instruction
component Memoire_instruction is
    Port (  Clock : in STD_LOGIC;
          Adresse : in STD_LOGIC_VECTOR (7 downto 0);
          Sortie : out STD_LOGIC_VECTOR (31 downto 0)
 );
end component;


--LI_DI 
component LI_DI is
    Port ( Clock : in STD_LOGIC;
           OP_entre : in STD_LOGIC_VECTOR (7 downto 0);
           A_entree : in STD_LOGIC_VECTOR (7 downto 0);
           B_entree : in STD_LOGIC_VECTOR (7 downto 0);
           C_entree : in STD_LOGIC_VECTOR (7 downto 0);
           Sortie_op : out STD_LOGIC_VECTOR (7 downto 0);
           Sortie_A : out STD_LOGIC_VECTOR (7 downto 0);
           Sortie_B : out STD_LOGIC_VECTOR (7 downto 0);
           Sortie_C : out STD_LOGIC_VECTOR (7 downto 0));
end component;


--EX_MEm
component EX_Mem is
    Port ( 
        Clock : in STD_LOGIC;
        OP_entre : in STD_LOGIC_VECTOR (7 downto 0);
        A_entree : in STD_LOGIC_VECTOR (7 downto 0);
        B_entree : in STD_LOGIC_VECTOR (7 downto 0);
        Sortie_op : out STD_LOGIC_VECTOR (7 downto 0);
        Sortie_A : out STD_LOGIC_VECTOR (7 downto 0);
        Sortie_B : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--Bench of Register
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

--ALU
component ALU is
    Port (
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end component;

--Mem de données
component Memoire_donnee is
    Port ( Reset : in STD_LOGIC;
           RW : in STD_LOGIC;
           Adresse : in STD_LOGIC_VECTOR (7 downto 0);
           Entre : in STD_LOGIC_VECTOR (7 downto 0);
           Clock : in STD_LOGIC;
           Sortie : out STD_LOGIC_VECTOR (7 downto 0));
end component;



----------------------------------Fin Déclaration Component -----------------------------------------------------



----------------------------------Debut signal Interne---------------------------------------------------------------

-- Sortie du mémoire instruction 
signal Sortie_mem_instruction : std_logic_vector(31 downto 0);

--Sortie LI_DI
signal Sortie_op_LI_DI : STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_A_LI_DI :  STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_B_LI_DI :  STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_C_LI_DI :  STD_LOGIC_VECTOR (7 downto 0);

--Sortie DI_EX
signal Sortie_op_DI_EX : STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_A_DI_EX :  STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_B_DI_EX :  STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_C_DI_EX :  STD_LOGIC_VECTOR (7 downto 0);

--Sortie EX_Mem
signal Sortie_op_EX_Mem : STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_A_EX_Mem :  STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_B_EX_Mem :  STD_LOGIC_VECTOR (7 downto 0);

--Sortie Mem_Re
signal Sortie_op_Mem_Re : STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_A_Mem_Re :  STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_B_Mem_Re :  STD_LOGIC_VECTOR (7 downto 0);

--Sortie Bench_Register
signal QA_Mem_Re : STD_LOGIC_VECTOR (7 downto 0);
signal QB_Mem_Re : STD_LOGIC_VECTOR (7 downto 0);


--LC Fin
signal LC_Fin : STD_LOGIC;

--Sortie  MUX
signal Sortie_MUX_banc_register : STD_LOGIC_VECTOR (7 downto 0);

--Sortie  MUX_UAL
signal Sortie_MUX_UAL_banc_register : STD_LOGIC_VECTOR (7 downto 0);

--Sortie ALU
signal Sortie_S_ALU : STD_LOGIC_VECTOR (7 downto 0);

--LC ALU
signal LC_ALU : STD_LOGIC_VECTOR (2 downto 0);

-- Sorties mem de données
signal Sortie_OUT_Mem_des_donnees : STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_MUX_Mem_des_donnees : STD_LOGIC_VECTOR (7 downto 0);
signal Sortie_MUX_Mem_des_donnees_entree : STD_LOGIC_VECTOR (7 downto 0);

--LC Mem des données
signal LC_Mem_des_donnees : STD_LOGIC;

----------------------------------Fin signal Interne---------------------------------------------------------------

begin

----------------------------------Debut Port Map---------------------------------------------------------------

Memoire_instruction_a: Memoire_instruction
port map(           
Clock => Clock,
Adresse => Adresse,
Sortie => Sortie_mem_instruction
);


-- lien entre mém instruction et LI_DI
LI_DI_a: LI_DI
port map(           
Clock => Clock,
OP_entre => Sortie_mem_instruction(31 downto 24),
A_entree => Sortie_mem_instruction(23 downto 16),
B_entree => Sortie_mem_instruction(15 downto 8),
C_entree => Sortie_mem_instruction(7 downto 0),
Sortie_op => Sortie_op_LI_DI,
Sortie_A => Sortie_A_LI_DI,
Sortie_B => Sortie_B_LI_DI,
Sortie_C => Sortie_C_LI_DI
);


--Multiplixeur  du banc de registre

Sortie_MUX_banc_register <= Sortie_B_LI_DI when to_integer(unsigned(Sortie_op_LI_DI)) = 6 or to_integer(unsigned(Sortie_op_LI_DI)) = 7 else
     QA_Mem_Re;

-- lien entre  LI_DI et  DI_EX     
DI_EX_a: LI_DI
port map(           
Clock => Clock,
OP_entre => Sortie_op_LI_DI,
A_entree => Sortie_A_LI_DI,
B_entree => Sortie_MUX_banc_register,
C_entree => QB_Mem_Re,
Sortie_op => Sortie_op_DI_EX,
Sortie_A => Sortie_A_DI_EX,
Sortie_B => Sortie_B_DI_EX,
Sortie_C => Sortie_C_DI_EX
);

--Mise à jour LC_ALU
LC_ALU <= "000" when to_integer(unsigned(Sortie_op_Mem_Re)) = 1 else
    "010" when to_integer(unsigned(Sortie_op_Mem_Re)) = 2 else
    "001" when to_integer(unsigned(Sortie_op_Mem_Re)) = 3 else
    "111";



ALU_a: ALU
port map(           
A => Sortie_B_DI_EX,
B => Sortie_C_DI_EX,
Ctrl_Alu => LC_ALU,
S => Sortie_S_ALU
);


--Multiplixeur de l'UAL
Sortie_MUX_UAL_banc_register <= Sortie_B_DI_EX when to_integer(unsigned(Sortie_op_LI_DI)) = 6 or to_integer(unsigned(Sortie_op_LI_DI)) = 5 or to_integer(unsigned(Sortie_op_LI_DI)) = 7 or to_integer(unsigned(Sortie_op_LI_DI)) = 8 else
     Sortie_S_ALU;

--lien entre DI_EX et EX/MEM
EX_Mem_a: EX_Mem
port map(           
Clock => Clock,
OP_entre => Sortie_op_DI_EX,
A_entree => Sortie_A_DI_EX,
B_entree => Sortie_MUX_UAL_banc_register,
Sortie_op => Sortie_op_EX_Mem,
Sortie_A => Sortie_A_EX_Mem,
Sortie_B => Sortie_B_EX_Mem
);


Mem_Re_a: EX_Mem
port map(           
Clock => Clock,
OP_entre => Sortie_op_EX_Mem,
A_entree => Sortie_A_EX_Mem,
B_entree => Sortie_MUX_Mem_des_donnees,
Sortie_op => Sortie_op_Mem_Re,
Sortie_A => Sortie_A_Mem_Re,
Sortie_B => Sortie_B_Mem_Re
);


-- Mise à jour du LC Fin
LC_Fin <= '1' when to_integer(unsigned(Sortie_op_Mem_Re)) = 6 else
      '1' when to_integer(unsigned(Sortie_op_Mem_Re)) = 5 else
      '1' when to_integer(unsigned(Sortie_op_Mem_Re)) = 1 else
      '1' when to_integer(unsigned(Sortie_op_Mem_Re)) = 7 else
      '0';

Bench_Register_a: Bench_Register
port map(           
Clock => Clock,
Ad_W => Sortie_A_Mem_Re(7 downto 4),
Data => Sortie_B_Mem_Re,
W => LC_Fin,
Reset => '0',
Ad_A => Sortie_B_LI_DI (7 downto 4),
Ad_B => Sortie_C_LI_DI (7 downto 4),
QA=>QA_Mem_Re,
QB=>QB_Mem_Re
);

-- LC Mem des données
LC_Mem_des_donnees <= '0' when to_integer(unsigned(Sortie_op_EX_Mem)) = 8 else
      '1';
      
-- Mux de la mémoire de données pour l'entrée 
Sortie_MUX_Mem_des_donnees_entree <= Sortie_A_EX_Mem when to_integer(unsigned(Sortie_op_EX_Mem)) = 8 else
     Sortie_B_EX_Mem;
     
-- Mux de la mémoire de données pour la sortie 
Sortie_MUX_Mem_des_donnees <= Sortie_OUT_Mem_des_donnees when to_integer(unsigned(Sortie_op_EX_Mem)) = 7 else
    Sortie_B_EX_Mem;
 
     
Memoire_donnee_a: Memoire_donnee
port map ( 
Reset => '0',
RW => LC_Mem_des_donnees,
Adresse => Sortie_MUX_Mem_des_donnees_entree,
Entre => Sortie_B_EX_Mem,
Clock => Clock,
Sortie => Sortie_OUT_Mem_des_donnees
);



----------------------------------Fin Port Map---------------------------------------------------------------


end Behavioral;
