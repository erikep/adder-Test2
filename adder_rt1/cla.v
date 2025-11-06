module cla #(parameter BITWIDTH = 8) ( //change parameter when testing for different bit-width adders
    input [BITWIDTH - 1:0] bits_a,
    input [BITWIDTH - 1:0] bits_b,
    input carry_in,
    output [BITWIDTH - 1:0] sum,
    output block_propagate,
    output block_generate,
    output carry_out
);
    
    wire [BITWIDTH:0] carry; //carry bits
    wire [BITWIDTH - 1:0] p; //propagate bits
    wire [BITWIDTH - 1:0] g; //generate bits
    wire [BITWIDTH - 1:0] G_calculations; //intermediate block generate calculations
    assign carry[0] = carry_in; //initial carry in

    genvar i;
    generate
        for (i = 0; i < BITWIDTH; i = i + 1) begin //loop ensures the propagate and generate signals are created for each bit
            assign p[i] = bits_a[i] | bits_b[i]; //propagate
            assign g[i] = bits_a[i] & bits_b[i]; //generate

            assign sum[i] = p[i] ^ carry[i]; //sum bit
            assign carry[i + 1] = g[i] | (p[i] & carry[i]); //carry bit - needed for sum calculation

            if (i == 1) begin
                assign G_calculations[i] = g[i] | (p[i] & g[i - 1]); //initial block generate calculation
            end
            else if(i > 1) begin
                assign G_calculations[i] = g[i] | (p[i] & G_calculations[i - 1]); //intermediate block generate calculations
            end

            if(i == BITWIDTH - 1) begin //calculate n-bit block propagate and generate signal
                // Block Propagate
                assign block_propagate  = &p; //AND all propagate bits together
                // Block Generate
                assign block_generate = G_calculations[BITWIDTH - 1]; //final block generate calculation is the n-bit block generate signal
            end
        end
    endgenerate

    assign carry_out = block_generate | (block_propagate & carry[0]); //final carry out - based on block propagate and generate signals

endmodule