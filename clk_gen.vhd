library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY clk_gen IS
	PORT(clk: OUT std_logic:='1'; rst : OUT std_logic);
END clk_gen;

ARCHITECTURE behave OF clk_gen IS
BEGIN
	rst<='0', '1' AFTER 5ns;
	
	PROCESS
	BEGIN
		clk<='1', '0' AFTER 10ns;
		WAIT FOR 20ns;
	END PROCESS;
END ARCHITECTURE;