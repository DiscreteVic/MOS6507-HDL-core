QUARTUS_DIR=/opt/intelFPGA_lite/21.1/quartus/bin

all: synthesize fit assemble

synthesize:
	@ quartus_map --read_settings_files=on --write_settings_files=off mos6507-core -c mos6507-core

fit:
	@ quartus_fit --read_settings_files=on --write_settings_files=off mos6507-core -c mos6507-core

assemble:
	@ quartus_asm --read_settings_files=on --write_settings_files=off mos6507-core -c mos6507-core

program:
	@ quartus_pgm -z --mode=JTAG --operation="p;output_files/mos6507-core.sof@1"

jtag:
	@ sudo $(QUARTUS_DIR)/jtagd
	@ sudo $(QUARTUS_DIR)/jtagconfig

killjtag:
	@ sudo killall jtagd

clean:
	@ rm -rf db/ output_files/ incremental_db/