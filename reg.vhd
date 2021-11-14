library ieee;
use ieee.std_logic_1164.all;

entity reg is
port (
	SW : in std_logic_vector (7 downto 0);
	clk : in std_logic;
	X : out std_logic_vector (7 downto 0)
	);
end reg;


architecture a of reg is

	begin

	process (clk)
	begin
		if (rising_edge (clk)) then
			X <= SW; --on mémorise la valeur des switchs
		end if;
	end process;
end a;