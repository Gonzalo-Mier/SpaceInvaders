--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:56:45 12/26/2014
-- Design Name:   
-- Module Name:   D:/PROYECTO/prueba.vhd
-- Project Name:  PROYECTO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ENEMIGOS
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY prueba IS
END prueba;
 
ARCHITECTURE behavior OF prueba IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ENEMIGOS
    PORT(
         eje_x : IN  std_logic_vector(9 downto 0);
         eje_y : IN  std_logic_vector(9 downto 0);
         eje_x_colision : IN  std_logic_vector(9 downto 0);
         eje_y_colision : IN  std_logic_vector(9 downto 0);
         reset : IN  std_logic;
         clk : IN  std_logic;
         R : OUT  std_logic;
         G : OUT  std_logic;
         B : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal eje_x : std_logic_vector(9 downto 0) := (others => '0');
   signal eje_y : std_logic_vector(9 downto 0) := (others => '0');
   signal eje_x_colision : std_logic_vector(9 downto 0) := (others => '0');
   signal eje_y_colision : std_logic_vector(9 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal R : std_logic;
   signal G : std_logic;
   signal B : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ENEMIGOS PORT MAP (
          eje_x => eje_x,
          eje_y => eje_y,
          eje_x_colision => eje_x_colision,
          eje_y_colision => eje_y_colision,
          reset => reset,
          clk => clk,
          R => R,
          G => G,
          B => B
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
		eje_x<=eje_x+1;
		eje_y<=eje_y+3;
		wait for 3 ps;
   end process;

END;
