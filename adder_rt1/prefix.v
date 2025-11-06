module prefix #(parameter BITWIDTH = 8;) ( //change BITWIDTH as needed for adder size
    input [BITWIDTH - 1:0] bits_a,
    input [BITWIDTH - 1:0] bits_b,
    input carry_in,
    output [BITWIDTH - 1:0] sum,
    output carry_out
);

    wire [BITWIDTH - 1:0] g, p; //track generate and propagate signals
    wire [BITWIDTH:0] c; //track carry-in signals

    //calculate generate and propagate signals
    assign g = a & b;
    assign p = a | b;

    assign c[0] = carry_in; //initialize carry-in

    wire g_intermediate; //intermediate wire for generate calculation

    genvar i, j;
        for (i = 1; i <= BITWIDTH; i = i + 1) begin //from bit 1 to BITWIDTH
            assign g_intermediate = g[i - 1];
            for (j = i - 1; j > 0; j = j - 1) begin //from bit i-1 down to bit 1
                assign g_intermediate = g_intermediate | (p[i - 1] & g[j - 1]);
            end
            assign c[i] = g_intermediate;
        end

    // Calculate final sum bits
    assign sum = bits_a ^ bits_b ^ c[BITWIDTH - 1:0];
    assign cout = c[BITWIDTH];

endmodule
