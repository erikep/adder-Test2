#!/bin/bash

# Shell scripts compile all the terminal commands for a specific process into a single custom command for simustaneous execution.
# For example, this is a Verilog simulation script based on Icarus Verilog that compiles code files and runs the testbench simulation.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Clean previous builds
echo "Cleaning previous simulation files..."
rm -f *.vvp *.vcd

# Compile Verilog files
echo "Compiling Verilog files..."
iverilog -o test_adders.vvp adder_rt1/rca.v adder_rt1/prefix.v adder_rt1/cla.v tb/tb_adders.v

# Check if compilation succeeded
if [ $? -ne 0 ]; then
    echo -e "${RED}Compilation failed!${NC}"
    exit 1
fi

echo -e "${GREEN}Compilation successful!${NC}"

# Run simulation
echo "Running simulation..."
vvp test_adders.vvp

# Check if simulation succeeded
if [ $? -ne 0 ]; then
    echo -e "${RED}Simulation failed!${NC}"
    exit 1
fi

echo -e "${GREEN}Simulation complete!${NC}"

# Automatically open waveform viewer, if generated
if [ -f "tb_waveforms.vcd" ]; then
    echo "Opening waveform viewer..."
    gtkwave tb_waveforms.vcd
fi

echo -e "${GREEN}Script finished successfully!${NC}"