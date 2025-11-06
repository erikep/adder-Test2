module prefix #(parameter BITWIDTH = 8) ( //change BITWIDTH as needed for adder size
    input [BITWIDTH - 1:0] bits_a,
    input [BITWIDTH - 1:0] bits_b,
    input carry_in,
    output [BITWIDTH - 1:0] sum,
    output carry_out
);

    wire [BITWIDTH - 1:0] g, p; //track generate and propagate signals
    wire [BITWIDTH:0] c; //track carry-in signals

    //calculate generate and propagate signals
    assign g = bits_a & bits_b;
    assign p = bits_a ^ bits_b;

    assign c[0] = carry_in; //initialize carry-in

    genvar i, j;
    generate
        for (i = 0; i < BITWIDTH; i = i + 1) begin
            assign c[i + 1] = g[i] | (p[i] & c[i]); //calculate carry-out for bit i
        end
    endgenerate

    // Calculate final sum bits
    assign sum = bits_a ^ bits_b ^ c[BITWIDTH - 1:0];
    assign carry_out = c[BITWIDTH];

endmodule
