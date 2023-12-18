library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

entity ALU is
    Port (
    a, b     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 2 inputs 8-bit
    op  : in  STD_LOGIC_VECTOR(1 downto 0);  -- 1 input 4-bit for selecting function
    result   : out  STD_LOGIC_VECTOR(7 downto 0)
    );
end ALU; 
architecture Behavioral of ALU is



begin
process(a,b,op)
   variable tmp : STD_LOGIC_VECTOR (7 downto 0);
begin 
  
  case(op) is
	  when "01" => -- Addition
	  tmp := a + b ;
	  when "10" => -- Subtraction
	  tmp := a - b ;
	  when others =>   
	  tmp := a;
  end case;
  result <= tmp; -- ALU out
 end process;
end ARchitecture Behavioral;