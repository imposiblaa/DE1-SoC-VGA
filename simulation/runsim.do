# Set target module

if {$argc > 0} {
    set module $1
} else {
    set module DE1_SoC
}

set TOP_LEVEL_NAME ${module}_testbench
set USER_DEFINED_ELAB_OPTIONS "-voptargs=+acc"

set QSYS_SIMDIR ../ip/soc_system/simulation/
source $QSYS_SIMDIR/mentor/msim_setup.tcl

dev_com;
com;

# Compile Verilog
#     We can include all SystemVerilog files in the current folder using the
#     following line:
vlog "../hdl/*.sv"
vlog "../ip/FBLINE_FIFO.v"
vlog "./stubs/*.v"

elab


# Source the wave do file
#     This should be the file that sets up the signal window for the module you
#     are testing.
do ${module}_wave.do

# Make sure relevant windows are visible
view wave
view structure
view signals

# Run the simulation!
run -all

# vim: ft=tcl
