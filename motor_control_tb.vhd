LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY motor_control_tb IS
END motor_control_tb;
 
ARCHITECTURE behavior OF motor_control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT motor_control
    PORT(
         duty : IN  std_logic_vector(6 downto 0);
         reset : IN  std_logic;
         sensor : IN  std_logic;
         clk : IN  std_logic;
         motor : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal duty : std_logic_vector(6 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal sensor : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal motor : std_logic;

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: motor_control PORT MAP (
          duty => duty,
          reset => reset,
          sensor => sensor,
          clk => clk,
          motor => motor
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      reset <= '1';
		wait for 100 ns;
		reset <= '0';
		wait for 100 ns;

      -- insert stimulus here 
		duty <= "0000000";			-- position : 0
      wait for 20 ms;
      duty <= "0101000";			-- position : 40
      wait for 20 ms;
      duty <= "1010000";			-- position : 80
      wait for 20 ms;
      duty <= "1111000";			-- position : 120
		wait for 20 ms;
		
		sensor <= '1';					-- trigger sensor
		wait for 20 ms;
		
		sensor <= '0';
		wait for 20 ms;
		-- set back to default value;
		wait for 20 ms;
		duty <= "0000000";
      wait;
   end process;

END;
