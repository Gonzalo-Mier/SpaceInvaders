----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:15:28 12/17/2014 
-- Design Name: 
-- Module Name:    MARCIANO_1 - Behavioral 
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MARCIANO_1 is
    Port ( pos_x: in std_logic_vector(9 downto 0); --ERROR-----------------
			  pos_y: in std_logic_vector(9 downto 0);	--NO LOS USO------------
			  eje_x : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
           eje_y : in  STD_LOGIC_VECTOR(9 DOWNTO 0);
			  vivo: in STD_LOGIC;
			  reset: in std_logic;
			  clk:in std_logic;
           R : out  STD_LOGIC;
           G : out  STD_LOGIC;
           B : out  STD_LOGIC);
end MARCIANO_1;

architecture Behavioral of MARCIANO_1 is

COMPONENT MARCIANO1
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;

signal dir_mar: std_logic_vector(6 downto 0);
signal color_marciano: std_logic_vector(0 downto 0);
signal pos_rel_x, pos_rel_y :std_logic_vector(9 downto 0):=(others=>'0');
signal cont_x,cont_y :std_logic_vector(9 downto 0):=(others=>'0');
signal cont, p_cont :std_logic_vector(9 downto 0):=(others=>'0');
signal dir_mar_x :std_logic_vector(3 downto 0):=(others=>'0');
signal dir_mar_y :std_logic_vector(2 downto 0):=(others=>'0');
signal p_cont_x1, cont_x1 :std_logic_vector(3 downto 0):=(others=>'0');
signal p_cont_y1, cont_y1 :std_logic_vector(2 downto 0):=(others=>'0');
signal mov: std_logic_vector(1 downto 0);
begin
	
	pos_rel_x<=(others=>'0') when reset='1' else 
				  cont_x + 1 when mov="00" else
				  cont_x - 1 when mov="10" else
				  cont_x;
	pos_rel_y<=(others=>'0') when reset='1' else
				  cont_y + 5 when mov="01" or mov="11" else
				  cont_y;	
	
	
	dir:process(eje_x,eje_y)
		begin
			if (eje_x=0 and eje_y=0) then 
				cont <= p_cont+1; 
				if (p_cont(2 downto 0)="000") then 
					cont_x<=pos_rel_x;
					cont_y<=pos_rel_y;
				end if;
				else cont<=p_cont;
			end if;
			if (mov="00" and  (pos_rel_x+12)=609) then 
				mov<="01"; cont<=(others=>'0');
			elsif (mov="10" and  pos_rel_x=0)	then 
				mov<="11"; cont<=(others=>'0');
			elsif (mov="01" and  cont=20)	then 
				mov<="10"; cont<=(others=>'0');
			elsif (mov="11" and  cont=20)	then 
				mov<="00"; cont<=(others=>'0');
			else mov<="00"; cont<=(others=>'0');
			end if;
			
		   if ((eje_x - pos_rel_x - pos_x)<16) and ((eje_y - pos_rel_y - pos_y)<8) then
				dir_mar_y<=eje_y(3 downto 1);--pos_rel_y(3 downto 1) + p_cont_y1;
				dir_mar_x<=eje_x(4 downto 1);--pos_rel_x(4 downto 1) + p_cont_x1;
				dir_mar<=dir_mar_y(2 downto 0) & dir_mar_x(3 downto 0);
				--cont_x1<=p_cont_x1 + 1;
				--cont_y1<=p_cont_y1 + 1;
			else
				dir_mar_y<=(others=>'1');
				dir_mar_x<=(others=>'1');
				dir_mar<=(others=>'1');
				--cont_x1<=p_cont_x1;
				--cont_y1<=p_cont_y1;
			end if;
	end process;
	
	--	p_cont_x1<=cont_x1;
	--	p_cont_y1<=cont_y1; 		
		p_cont<=cont; 
	
	
	marciano: MARCIANO1
  PORT MAP (
    clka => clk,
    addra => dir_mar,
    douta => color_marciano
  );
	vida:process(vivo,color_marciano)
		begin
			if vivo='1' then
				R<=color_marciano(0);
				G<=color_marciano(0);
				B<=color_marciano(0);
			else
				R<='0';
				G<='0';
				B<='0';
			end if;
		end process;



end Behavioral;

