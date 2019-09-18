----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:49 12/18/2014 
-- Design Name: 
-- Module Name:    top_proyect - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_proyect is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           HS : out  STD_LOGIC;
           VS : out  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end top_proyect;

architecture Behavioral of top_proyect is
COMPONENT VGA_DRIVER is
    Port ( 
			  eje_x: out std_logic_vector(9 downto 0);
			  eje_y: out std_logic_vector(9 downto 0);
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           VS : out  STD_LOGIC;
           HS : out  STD_LOGIC;
			  R_in : in  STD_LOGIC;
           G_in : in  STD_LOGIC;
           B_in : in  STD_LOGIC;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end component;

component dibuja is
    Port ( clk: in std_logic;
			  reset: in std_logic;
			  eje_x : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
           eje_y : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end component;

signal eje_x, eje_y : STD_LOGIC_VECTOR(9 DOWNTO 0);
signal R_in, G_in, B_in : STD_LOGIC;
begin
	dibujar:dibuja
		port map(
			clk=>clk,
			reset=>reset,
			eje_x=>eje_x,
			eje_y=>eje_y,
			R=>R_in,
			G=>G_in,
			B=>B_in);
	VGA : VGA_DRIVER
		port map(
			eje_x=>eje_x,
			eje_y=>eje_y,
			clk =>clk,
         reset =>reset,
         VS => VS,
         HS =>HS,
			R_in =>R_in,
         G_in =>G_in,
         B_in =>B_in,
         R =>R,
         G =>G,
         B =>B);
			

end Behavioral;

