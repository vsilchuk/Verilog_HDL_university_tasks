###########################
# Simple modelsim do file #
###########################

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog  shift_reg.v testbench.v

# Open testbench module for simulation

vsim -novopt work.testbench

# Add all testbench signals to waveform diagram

add wave /testbench/*

onbreak resume

# Run simulation
run -all

wave zoom full


