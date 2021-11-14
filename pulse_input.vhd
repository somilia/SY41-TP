library ieee;
use ieee.std_logic_1164.all;


entity pulse_input is
port (
	pb, clk : in std_logic;
	pb_pulse : out std_logic
	);
end pulse_input;


architecture a of pulse_input is

signal x : std_logic_vector (1 downto 0); --signal sur 2 bits

begin

process(clk)
begin
	if (rising_edge(clk)) then
		if (x = "00") then --cas 1: PB=1, le bouton poussoir n'a pas été enfoncé
			if (pb = '0') then --PB=0, le bouton poussoir vient d'être enfoncé
				x <= "01";
			end if;
		elsif (x = "01") then --cas 2: PB=0, le bouton poussoir a été enfoncé, la sortie PbPulse est à 1
			if (pb = '0') then --PB=0, le bouton poussoir est toujours enfoncé
				x <= "10"; --attente que le bouton poussoir ne soit plus enfoncé
			else
				x <= "00"; --le bouton poussoir n'est plus enfoncé
			end if;
		elsif (x = "10") then --cas 3: PB=0, le bouton poussoir est toujours enfoncé mais le signal PbPulse a été envoyé
			if (pb = '1') then
				x <= "00"; --remise de l'état à 0
			end if;
		end if;
	end if;
end process;

pb_pulse <= x(0); 

end a;
			
		