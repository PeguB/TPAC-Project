library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Shift_Register is
    Port (
		clk: in std_logic;
		rst: in std_logic;
        shift_in : in std_logic_vector(15 downto 0);      -- Input to shift into the register
        shift_out : out std_logic_vector(15 downto 0);     -- Output shifted out from the register		 
		cout : out std_logic
    );
end Shift_Register;

architecture Behavioral of Shift_Register is
begin

    process(clk,rst)
	variable shift_reg : std_logic_vector(15 downto 0) := "0000000000000000";
    begin
		if rst = '0' THEN
			shift_reg := "0000000000000000";	 
		elsif clk='1' AND clk'EVENT and clk'LAST_VALUE='0' THEN
        	shift_reg := shift_in(15) & shift_in(15 downto 1) ;
			cout <= shift_in(0); 
		end if;	
	shift_out <= shift_reg;
    end process;
end ARchitecture Behavioral;