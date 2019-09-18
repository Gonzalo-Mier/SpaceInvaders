----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:25 12/17/2014 
-- Design Name: 
-- Module Name:    ENEMIGOS - Behavioral 
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

entity ENEMIGOS is
    Port ( eje_x : in  STD_LOGIC_vector(9 downto 0);
           eje_y : in  STD_LOGIC_vector(9 downto 0);
			  eje_x_colision : in  STD_LOGIC_vector(9 downto 0);
           eje_y_colision : in  STD_LOGIC_vector(9 downto 0);
			  reset: in std_logic;
			  clk: in std_logic;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end ENEMIGOS;


architecture Behavioral of ENEMIGOS is
COMPONENT mapa_marcianos
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;
component MARCIANO_1 is
    Port ( pos_x: in std_logic_vector(9 downto 0);
			  pos_y: in std_logic_vector(9 downto 0);	
			  eje_x : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
           eje_y : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
			  vivo: in std_logic; 
			  clk: in STD_LOGIC;
			  reset: in std_logic;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end component;
signal R_mar1,G_mar1,B_mar1: std_logic;
signal pos_x, pos_y :std_logic_vector(9 downto 0);
signal vivo :std_logic;
signal addra :std_logic_vector(6 downto 0);
signal wea, dina, douta:std_logic_vector(0 downto 0):="0";
begin
	R<=R_mar1;
	G<=G_mar1;
	B<=B_mar1;
	vivo<=douta(0);
	pos_y<=eje_y(9 downto 4) & "1110";
	pos_x<=eje_x(9 downto 5) & "11110";
	colision:process(eje_x_colision, eje_y_colision, eje_x, eje_y, clk)
		begin
		if clk='1' then
		   wea<="1"; 
			addra<=eje_y_colision(6 downto 4) & eje_x_colision(8 downto 5);
			dina<="0";
		else
			wea<="0";
			addra<=eje_y(6 downto 4) & eje_x(8 downto 5);
		end if;
	end process;		
	
	mapa:mapa_marcianos
		PORT MAP (
			clka=>clk,
			wea=>wea,
			addra=>addra,
			dina=>dina,
			douta=>douta);
	marciano_1_1:Marciano_1		
		PORT MAP (
			pos_x=>pos_x,
			pos_y=>pos_y,
			reset=>reset,
			eje_x=>eje_x,
			eje_y=>eje_y,
			vivo=>vivo,
			clk=>clk,
			R=>R_mar1,
			G=>G_mar1,
			B=>B_mar1);
	




end Behavioral;

