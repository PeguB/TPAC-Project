library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity booth_tb is
end booth_tb;

architecture tb_arch of booth_tb is

    signal A_tb, B_tb : std_logic_vector(7 downto 0) := (others => '0');  -- Testbench inputs
    signal result_tb : std_logic_vector(15 downto 0) := (others => '0');  -- Testbench output result

    -- Instantiate the Booth Multiplier
    component booth_multiplier is
        Port (
            A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            result : out std_logic_vector(15 downto 0)
        );
    end component;

begin

    -- Instantiate the Booth Multiplier
    UUT: booth_multiplier port map (
        A => A_tb,
        B => B_tb,
        result => result_tb
    );


    -- Test stimulus process
    stimulus_process: process
    begin

        -- Test multiplication of 16 and 3
        A_tb <= "00100011";
        B_tb <= "00000011";  
 
        wait for 500 ns;
        wait;
    end process stimulus_process;

end tb_arch;