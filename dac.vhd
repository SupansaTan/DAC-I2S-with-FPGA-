library ieee;
use ieee.std_logic_1164.all;

entity DAC is
	port (
		BCK : in std_logic; -- clock input
		DIN : out std_logic; -- input data of sound (serial)
		LCK : out std_logic := '0'; -- Audio data world clock input
		FMT : out std_logic := '0' -- Sound Form : I2S (low)
	);
end DAC;

architecture behavioral of DAC is
	constant bit_max : integer := 16;
	signal count : integer range 0 to bit_max := 0;
	signal lr : std_logic := '0';
	begin
		LCK <= lr;
		process(BCK)
			begin
				if (BCK'event and BCK = '0') then  -- falling edge
					if (count > bit_max-1) then
						
						lr <= not(lr); -- left or right channel
						count <= 0;
						
					end if;
				end if;
		end process;
end behavioral;