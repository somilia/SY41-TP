library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity sum is
port (
	SW : in std_logic_vector (7 downto 0);
	clk, enter, add : in std_logic; --enter et add : entrées matérialisées par 2 switchs; clk : matérialisé par un bouton poussoir
	X : out std_logic_vector (7 downto 0)
	);
end sum;


architecture a of sum is


	signal ANT : std_logic_vector (7 downto 0);	--dernière valeur enregistrée

	begin

	process (clk)
	variable res : std_logic_vector (7 downto 0) := "00000000"; --création d'une variable resultat auquel on assigne le vecteur 8 bits "00000000" pour l'initialiser
	begin
		if (rising_edge (clk)) then
			X <= SW; --on mémorise la valeur des switchs
			if (enter = '1') then --la valeur présente sur les switches est mémorisée et affichée
				X <= SW; 
				--X <= "11111111";
				ANT <= SW;
			elsif (add = '1') then --la valeur mémorisée est la somme de la précédente et de la valeur présente sur les switches
				res := std_logic_vector(to_unsigned(to_integer(unsigned(SW)) + to_integer(unsigned(ANT)), 8)); --on assigne à la variable res la somme de la valeur des switchs et de la valeur affichée mémorisée précedemment
				X <= res; --on mémorise la nouvelle valeur à afficher
				ANT <= res; --on mémorise la nouvelle valeur à additionner prochainement
			end if;
		end if;
	end process;
end a;
