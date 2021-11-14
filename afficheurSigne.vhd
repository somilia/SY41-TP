library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity afficheurSigne is
port (
	SW	: in std_logic_vector (9 downto 0);	--10 switches en entrée
	KEY1 : in std_logic; -- bouton poussoir en entrée
	clk : in std_logic;
	Signe	: out std_logic;	--cas nombre négatif: 0, sinon: 1
	HEX0, HEX1	: out std_logic_vector(6 downto 0));	--afficheurs en sortie
end afficheurSigne;	


architecture a of afficheurSigne is

	signal S	: std_logic_vector (7 downto 0);	--Grandeur de la valeur
	signal X : std_logic_vector (7 downto 0);	--Valeur retenue par la mémoire
	signal pulse : std_logic;

	component afficheur is
	port (
		E	: in std_logic_vector (3 downto 0);
		HEX: out std_logic_vector(6 downto 0));
	end component;
	
	component sum is
	port (
		SW : in std_logic_vector (7 downto 0);
		clk, enter, add : in std_logic;
		X : out std_logic_vector (7 downto 0)
		);
	end component;
	
	component pulse_input is
	port (
		pb, clk : in std_logic;
		pb_pulse : out std_logic
		);
	end component;

	begin
	
	U4 : pulse_input port map (KEY1, clk, pulse);
	U3 : sum port map (SW(7 downto 0), pulse, SW(9), SW(8), X(7 downto 0));  

	process(X)
	begin
		if X(7) = '1' then	--cas pour un nombre qui est négatif
			S <= std_logic_vector(to_unsigned(to_integer(unsigned( not X )) + 1, 8));
			Signe <= '0';
			S(7) <= '0';
		else						--cas pour un nombre qui est positif
			S <= X;
			Signe <= '1';
		end if;

	end process;

	U1 : afficheur port map (S(3 downto 0), HEX0);
	U2 : afficheur port map (S(7 downto 4), HEX1);

end a;
