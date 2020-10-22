library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generate_data is
	port (
		BCK : in std_logic;
		DIN : out std_logic_vector(15 downto 0)
	);
end generate_data;

architecture behavioral of generate_data is
	constant bit_max : integer := 16;
	shared variable count : integer range 1 to bit_max := 1;
   shared variable data_16bit : integer := 0;
	shared variable  data_16bit_vector : std_logic_vector(15 downto 0) := "0000000000000000";
	shared variable i : integer := 1;
	begin
		DIN <= "0100000000000000";
		
		process(BCK)
			begin
				if (BCK'event and BCK = '0') then  -- falling edge
					count := count + 1;
					
					if (count > bit_max-1) then
						data_16bit := data_16bit + i;
						if (data_16bit > 32767) then
							data_16bit := 30000;
							i := -1;
						elsif (data_16bit < -32768) then
							data_16bit := 0;
							i := 1;
						end if;
						
						
						data_16bit_vector := std_logic_vector(to_signed(data_16bit, 16));
						
						count := 1;
						
					end if;
				end if;
		end process;
		
end behavioral;
