library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
-----------------------------------------------
---------- ALU 8-bit VHDL ---------------------
-----------------------------------------------
entity ALU is
    Port (
    a, b     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 2 inputs 8-bit
    op  : in  STD_LOGIC_VECTOR(3 downto 0);  -- 1 input 4-bit for selecting function
    result   : out  STD_LOGIC_VECTOR(7 downto 0); -- 1 output 8-bit 
    cout : out std_logic        -- Carryout flag
    );
end ALU; 
architecture Behavioral of ALU is

signal ALU_Result : std_logic_vector (7 downto 0);
signal tmp: std_logic_vector (8 downto 0);

begin
   process(a,b,op)
 begin
  case(op) is
  when "01" => -- Addition
   ALU_Result <= a + b ; 
  when "10" => -- Subtraction
   ALU_Result <= a - b ;
  when others => ALU_Result <= a + b ; 
  end case;
 end process;
 result <= ALU_Result; -- ALU out
 tmp <= ('0' & a) + ('0' & b);
 cout <= tmp(8); -- Carryout flag
end Behavioral;