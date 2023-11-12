COMPONENT=Index_Reg_XY
FLAGS="--std=08"

all: clean simulate 

simulate:
	@ ghdl -a $(FLAGS) $(COMPONENT)_tb.vhd $(COMPONENT).vhd
	@ ghdl -e $(FLAGS) $(COMPONENT)
	@ ghdl -r $(FLAGS) $(COMPONENT) --wave=sim.ghw --stop-time=50us

results:
	@ gtkwave sim.ghw

clean:
	@ rm -rf *.ghw *.cf

