
FLAGS="--std=08"

all: clean simulate 

simulate:
	@ ghdl -a $(FLAGS) IDB.vhd ../registers/Accumulator.vhd ../registers/Index_Reg_XY.vhd ../registers/Stack_Pointer_Reg.vhd ../registers/Input_Latch_Data.vhd
	@ ghdl -e $(FLAGS) IDB
	@ ghdl -r $(FLAGS) IDB --wave=sim.ghw --stop-time=16us

results:
	@ gtkwave sim.ghw

clean:
	@ rm -rf *.ghw *.cf