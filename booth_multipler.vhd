library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity booth_multiplier is
    Port (
        A : in std_logic_vector(7 downto 0);           -- Input A
        B : in std_logic_vector(7 downto 0);           -- Input B
        result : out std_logic_vector(15 downto 0)     -- Output result
    );
end booth_multiplier;

architecture Behavioral of booth_multiplier is

    -- Internal signals declaration
    signal product : std_logic_vector(15 downto 0);
    signal count : integer := 8;             -- Number of iterations
    signal shift_output : std_logic_vector(15 downto 0);
	signal clk,rst : std_logic;
	signal alu_cout : std_logic;
    signal alu_result, alu_a : std_logic_vector(7 downto 0);
    signal shift_reg_cout : std_logic;
	signal code_sig, alu_control_signal :std_logic_vector(1 downto 0);
	signal q, alu_over, sr_over : std_logic;
	signal shift_input : std_logic_vector(15 downto 0);
	signal state : std_logic_vector(2 downto 0) := "000";
	

    -- Components instantiation
    component ALU is
        Port (
            a, b : in std_logic_vector(7 downto 0);    -- Inputs to the ALU
            op : in std_logic_vector(1 downto 0);  -- Control signals for ALU operations
            result : out std_logic_vector(7 downto 0);
			alu_over : out std_logic
        );
    end component;

    component Shift_Register is
        Port (
			clk: in std_logic;
			rst: in std_logic;
            shift_in : in std_logic_vector(15 downto 0);         -- Input to shift into the register
            shift_out : out std_logic_vector(15 downto 0);        -- Output shifted out from the register	  
			cout : out std_logic;
			sr_over: out std_logic
        );
    end component; 
	
	component clk_gen IS
		PORT(clk: OUT std_logic:='1'; rst : OUT std_logic);
	END component;
begin

    -- Instantiate ALU
    ALU_Instance: ALU port map (
		a => alu_a,
		b => B,
		op => alu_control_signal,
		result => alu_result,
		alu_over => alu_over
    );

    -- Instantiate Shift Register
    Shift_Register_Instance: Shift_Register port map (
		clk => clk,
		rst => rst,
		shift_in => shift_input,
		shift_out => shift_output,
		cout => shift_reg_cout,
		sr_over => sr_over
    ); 
	
	clk_gen_Instance: clk_gen port map(
		clk =>clk,
		rst =>rst
	);

    -- Booth Multiplier process
    booth_process: process(clk, rst)
    begin 
		if rst = '0' then
			-- Reset signals and registers
			product <= (others => '0');
			count <= 0;  -- Reset count
			q <= '0';
		elsif clk='1' AND clk'EVENT and clk'LAST_VALUE='0' then
			case state is
				when "000" =>
					-- initialize
			        product <= "00000000" & A; 
					q <= '0';
					count <= 8;
					if count = 8 then
	                    state <= "001"; -- Move to the next state only when count reaches 8
	                end if;
			     when "001" =>
				 	-- start alu
				 	alu_a <= product(15 downto 8);
					alu_control_signal <= product(0) & q;
					if alu_over = '0' then
	                    state <= "010"; -- Move to the next state only when count reaches 8
	                end if; 
				 when "010" => 
				 	-- shift alu result
				 	shift_input <= alu_result &	product(7 downto 0);
					product <= shift_output;
					q <= shift_reg_cout;
					if sr_over = '1' then
	                    state <= "011";
	                end if; 
				 when "011" =>
				 	-- decrement count
				 	count <= count - 1;
					if count > 0 then 
						state <= "001";
					else
						state <= "100";
					end if;
				 when "100"	=>
				 	-- asign result
				 	result <= product;
			     when others =>							
			 end case;
		 end if;
  end process booth_process;
end Behavioral;