#!/bin/bash
# measure.sh - Synthesis script for adder comparison at multiple bit widths

# Configuration
MODULES=("rca" "cla" "prefix")  # Change these to your actual module names
BIT_WIDTHS=(8 16 32 64)
DESIGN_DIR="adder_rt1"
OUTPUT_DIR="results"
RESULTS_FILE="${OUTPUT_DIR}/summary_results.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create output directory
mkdir -p $OUTPUT_DIR

# Clear previous summary
echo "=== Adder Synthesis Results ===" > $RESULTS_FILE
echo "Generated: $(date)" >> $RESULTS_FILE
echo "" >> $RESULTS_FILE

echo -e "${BLUE}Starting synthesis for all adder modules...${NC}\n"

# Loop through each module
for MODULE in "${MODULES[@]}"; do
    echo -e "${YELLOW}Processing module: $MODULE${NC}"
    # Loop through each bit width
    for BIT_WIDTH in "${BIT_WIDTHS[@]}"; do
        echo -e "  Synthesizing ${BIT_WIDTH}-bit version..."
        
        OUTPUT_NAME="${MODULE}_${BIT_WIDTH}bit"
        LOG_FILE="${OUTPUT_DIR}/${OUTPUT_NAME}_synthesis.log"
        STATS_FILE="${OUTPUT_DIR}/${OUTPUT_NAME}_stats.txt"
        
        # Run Yosys synthesis
        yosys -q -p "
            read_verilog ${DESIGN_DIR}/*.v;
            hierarchy -check -top $MODULE;
            chparam -set BITWIDTH $BIT_WIDTH $MODULE;
            proc; opt; fsm; opt; memory; opt;
            techmap; opt;
            abc -g AND,OR,XOR,NAND,NOR,XNOR -fast;
            opt_clean;
            tee -o ${STATS_FILE} stat;
            tee -a ${STATS_FILE} stat -tech cmos;
            write_verilog ${OUTPUT_DIR}/${OUTPUT_NAME}_synth.v;
        " > $LOG_FILE 2>&1
        
        if [ $? -eq 0 ]; then
            echo -e "    ${GREEN}✓${NC} ${BIT_WIDTH}-bit synthesis complete"
            # Extract metrics from stats file
            CELLS=$(grep -m1 "cells" ${STATS_FILE} | awk '{print $1}')
            # Extract gate counts
            AND_GATES=$(grep -m1 '\$_AND_' "$STATS_FILE" | awk '{print $1}')
            OR_GATES=$(grep -m1 '\$_OR_' "$STATS_FILE" | awk '{print $1}')
            XOR_GATES=$(grep -m1 '\$_XOR_' "$STATS_FILE" | awk '{print $1}')
            NOT_GATES=$(grep -m1 '\$_NOT_' "$STATS_FILE" | awk '{print $1}')
            NOR_GATES=$(grep -m1 '\$_NOR_' "$STATS_FILE" | awk '{print $1}')
            XNOR_GATES=$(grep -m1 '\$_XNOR_' "$STATS_FILE" | awk '{print $1}')
            TRANSISTORS=$(grep "Estimated number of transistors:" ${STATS_FILE} | awk '{print $NF}')
            # Default to zero if field is blank
            AND_GATES=${AND_GATES:-0}
            OR_GATES=${OR_GATES:-0}
            XOR_GATES=${XOR_GATES:-0}
            NOT_GATES=${NOT_GATES:-0}
            NOR_GATES=${NOR_GATES:-0}
            XNOR_GATES=${XNOR_GATES:-0}
            # Calculate total gates
            TOTAL_GATES=$((AND_GATES + OR_GATES + XOR_GATES + NOT_GATES + NOR_GATES + XNOR_GATES))
            # Extract chip area (if available)
            CHIP_AREA=$(grep "Chip area" ${STATS_FILE} | awk '{print $NF}' | sed 's/[^0-9.]//g')
            # Estimate delay based on gate depth (rough approximation)
            # In absence of liberty file, we estimate based on structure
            GATE_DEPTH=$(grep -i "delay" ${STATS_FILE} | head -1 | awk '{print $NF}' | sed 's/[^0-9.]//g')
            # If no delay found, estimate based on bit width (rough heuristic)
            if [ -z "$GATE_DEPTH" ] || [ "$GATE_DEPTH" = "0" ]; then
                # Rough estimates: RCA is linear, CLA/Prefix are logarithmic
                case $MODULE in
                    *rca*)
                        GATE_DEPTH=$(echo "scale=2; $BIT_WIDTH * 0.5" | bc)
                        ;;
                    *cla*)
                        GATE_DEPTH=$(echo "scale=2; l($BIT_WIDTH)/l(2) * 1.5" | bc -l)
                        ;;
                    *prefix*)
                        GATE_DEPTH=$(echo "scale=2; l($BIT_WIDTH)/l(2) * 1.2" | bc -l)
                        ;;
                    *)
                        GATE_DEPTH=$(echo "scale=2; $BIT_WIDTH * 0.3" | bc)
                        ;;
                esac
            fi
            # Estimate critical path delay (assuming ~100ps per gate level)
            CRIT_PATH=$(echo "scale=2; $GATE_DEPTH * 0.1" | bc)
            # Calculate max frequency (in MHz)
            if [ ! -z "$CRIT_PATH" ] && [ "$CRIT_PATH" != "0" ]; then
                MAX_FREQ=$(echo "scale=2; 1000 / $CRIT_PATH" | bc)
            else
                MAX_FREQ="N/A"
            fi
            # Write to summary file
            echo "----------------------------------------" >> $RESULTS_FILE
            echo "Module: $MODULE (${BIT_WIDTH}-bit)" >> $RESULTS_FILE
            echo "  Total Cells: $CELLS" >> $RESULTS_FILE
            echo "  Total Gates: $TOTAL_GATES" >> $RESULTS_FILE
            echo "    AND gates: $AND_GATES" >> $RESULTS_FILE
            echo "    OR gates: $OR_GATES" >> $RESULTS_FILE
            echo "    XOR gates: $XOR_GATES" >> $RESULTS_FILE
            echo "    NOT gates: $NOT_GATES" >> $RESULTS_FILE
            echo "    NOR gates: $NOR_GATES" >> $RESULTS_FILE
            echo "    XNOR gates: $XNOR_GATES" >> $RESULTS_FILE
            if [ ! -z "$CHIP_AREA" ]; then
                echo "  Chip Area: $CHIP_AREA" >> $RESULTS_FILE
            fi
            echo "  Estimated Transistors: $TRANSISTORS" >> $RESULTS_FILE
            echo "  Estimated Gate Depth: $GATE_DEPTH levels" >> $RESULTS_FILE
            echo "  Estimated Critical Path: ${CRIT_PATH} ns" >> $RESULTS_FILE
            echo "  Estimated Max Frequency: ${MAX_FREQ} MHz" >> $RESULTS_FILE
            echo "" >> $RESULTS_FILE
        else
            echo -e "    ${RED}✗${NC} ${BIT_WIDTH}-bit synthesis failed (check $LOG_FILE)"
        fi
    done
    echo ""
done

echo -e "${GREEN}Synthesis complete!${NC}"
echo -e "Results saved to: ${BLUE}${RESULTS_FILE}${NC}\n"
