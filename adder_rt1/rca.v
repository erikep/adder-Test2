// The following code is test the Verilog environment setup.
// module main;
//   initial begin
//     $display("Hello, Verilog!");
//     $finish;
//   end
// endmodule

module rca #(parameter BITWIDTH = 8) ( //testing should involve 8, 16, 32, and 64 bit widths (change parameter to change bit width)
    input [BITWIDTH - 1:0] bits_a,
    input [BITWIDTH - 1:0] bits_b,
    input carry_in,
    output [BITWIDTH - 1:0] sum,
    output carry_out
);

    wire [BITWIDTH:0] carry;
    assign carry[0] = carry_in;

    genvar i;
    generate
        for (i = 0; i < BITWIDTH; i = i + 1) begin //loop ensures that the right carry is used for each bit adder
            assign sum[i] = bits_a[i] ^ bits_b[i] ^ carry[i]; //either only 1 input or all of them to set the sum
            assign carry[i + 1] = (bits_b[i] & carry[i]) | (bits_a[i] & carry[i]) | (bits_a[i] & bits_b[i]); //carry generated if any two of the three inputs are 1
        end
    endgenerate

    assign carry_out = carry[BITWIDTH];

endmodule