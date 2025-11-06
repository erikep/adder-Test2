module cla #(parameter BITWIDTH = 8) ( //change parameter when testing for different bit-width adders
    input [BITWIDTH - 1:0] bits_a,
    input [BITWIDTH - 1:0] bits_b,
    input carry_in,
    output [BITWIDTH - 1:0] sum,
    output carry_out
);
    
    wire [BITWIDTH:0] carry; //carry bits
    wire [BITWIDTH - 1:0] p = bits_a ^ bits_b; //propagate bits
    wire [BITWIDTH - 1:0] g = bits_a & bits_b; //generate bits
    wire [BITWIDTH - 1:0] G_calculations; //intermediate block generate calculations
    wire block_propagate; //n-bit block propagate
    wire block_generate; //n-bit block generate
    assign carry[0] = carry_in; //initial carry in

    genvar i;
    generate
        for (i = 0; i < BITWIDTH; i = i + 1) begin //loop ensures the propagate and generate signals are created for each bit
            assign sum[i] = p[i] ^ carry[i]; //sum bit
            assign carry[i + 1] = g[i] | (p[i] & carry[i]); //carry bit - needed for sum calculation

            if (i == 1) assign G_calculations[i] = g[i] | (p[i] & g[i - 1]); //initial block generate calculation
            else if(i > 1) assign G_calculations[i] = g[i] | (p[i] & G_calculations[i - 1]); //intermediate block generate calculations

            if(i == BITWIDTH - 1) begin //calculate n-bit block propagate and generate signal
                assign block_propagate  = &p; //AND all propagate bits together
                assign block_generate = G_calculations[BITWIDTH - 1]; //final block generate calculation is the n-bit block generate signal
            end
        end
    endgenerate

    assign carry_out = block_generate | (block_propagate & carry[0]); //final carry out - based on block propagate and generate signals

endmodule