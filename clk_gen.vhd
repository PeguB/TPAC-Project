ENTITY clk_gen IS
	GENERIC(t_high: TIME:=30 ns; t_period: TIME:=50 ns; t_reset: TIME:=10 ns);
	PORT(clock: OUT BIT:='1'; reset : OUT BIT);
END clk_gen;

ARCHITECTURE behave OF clk_gen IS
BEGIN
	reset<='0', '1' AFTER t_reset;
	
	PROCESS
	BEGIN
		IF NOW > 10 us THEN
			WAIT;
		END IF;

		clock<='1', '0' AFTER t_high;
		WAIT FOR t_period;
	END PROCESS;
END ARCHITECTURE;
