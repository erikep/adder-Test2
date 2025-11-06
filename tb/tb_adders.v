module tb_adders;
    // Test RCA, Prefix, and CLA adders with 8-bit inputs
    reg [7:0] a_8;
    reg [7:0] b_8;
    reg carry_in_8;
    //RCA wires
    wire [7:0] sum_rca_8;
    wire carry_out_rca_8;
    //Prefix wires
    wire [7:0] sum_prefix_8;
    wire carry_out_prefix_8;
    //CLA wires
    wire [7:0] sum_cla_8;
    wire carry_out_cla_8;
    rca #(.BITWIDTH(8)) rca_8 (
        .bits_a(a_8),
        .bits_b(b_8),
        .carry_in(carry_in_8),
        .sum(sum_rca_8),
        .carry_out(carry_out_rca_8)
    );
    prefix #(.BITWIDTH(8)) prefix_8 (
        .bits_a(a_8),
        .bits_b(b_8),
        .carry_in(carry_in_8),
        .sum(sum_prefix_8),
        .carry_out(carry_out_prefix_8)
    );
    cla #(.BITWIDTH(8)) cla_8 (
        .bits_a(a_8),
        .bits_b(b_8),
        .carry_in(carry_in_8),
        .sum(sum_cla_8),
        .carry_out(carry_out_cla_8)
    );
    initial begin
        // Test case 1
        a_8 = 8'b00000000; // 0
        b_8 = 8'b00000000; // 0
        carry_in_8 = 1'b1;
        #10;
        $display("8-bit Test Case 1:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_rca_8, carry_out_rca_8);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_prefix_8, carry_out_prefix_8);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_cla_8, carry_out_cla_8);
        if (sum_rca_8 != 8'b00000001 || carry_out_rca_8 != 1'b0) $display("RCA 8-bit Test Case 1 Failed");
        if (sum_prefix_8 != 8'b00000001 || carry_out_prefix_8 != 1'b0) $display("Prefix 8-bit Test Case 1 Failed");
        if (sum_cla_8 != 8'b00000001 || carry_out_cla_8 != 1'b0) $display("CLA 8-bit Test Case 1 Failed");

        // Test case 2
        a_8 = 8'b11111111; // 255
        b_8 = 8'b00000001; // 1
        carry_in_8 = 1'b0;
        #10;
        $display("8-bit Test Case 2:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_rca_8, carry_out_rca_8);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_prefix_8, carry_out_prefix_8);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_cla_8, carry_out_cla_8);
        if (sum_rca_8 != 8'b00000000 || carry_out_rca_8 != 1'b1) $display("RCA 8-bit Test Case 2 Failed");
        if (sum_prefix_8 != 8'b00000000 || carry_out_prefix_8 != 1'b1) $display("Prefix 8-bit Test Case 2 Failed"); 
        if (sum_cla_8 != 8'b00000000 || carry_out_cla_8 != 1'b1) $display("CLA 8-bit Test Case 2 Failed");

        // Test case 3
        a_8 = 8'b10101010; // 170
        b_8 = 8'b01010101; // 85
        carry_in_8 = 1'b0;
        #10;
        $display("8-bit Test Case 3:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_rca_8, carry_out_rca_8);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_prefix_8, carry_out_prefix_8);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_cla_8, carry_out_cla_8);
        if (sum_rca_8 != 8'b11111111 || carry_out_rca_8 != 1'b0) $display("RCA 8-bit Test Case 3 Failed");
        if (sum_prefix_8 != 8'b11111111 || carry_out_prefix_8 != 1'b0) $display("Prefix 8-bit Test Case 3 Failed"); 
        if (sum_cla_8 != 8'b11111111 || carry_out_cla_8 != 1'b0) $display("CLA 8-bit Test Case 3 Failed");

        // Test case 4
        a_8 = 8'b10101010; // 170
        b_8 = 8'b01010101; // 85
        carry_in_8 = 1'b1;
        #10;
        $display("8-bit Test Case 4:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_rca_8, carry_out_rca_8);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_prefix_8, carry_out_prefix_8);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_8, b_8, carry_in_8, sum_cla_8, carry_out_cla_8);
        if (sum_rca_8 != 8'b00000000 || carry_out_rca_8 != 1'b1) $display("RCA 8-bit Test Case 4 Failed");
        if (sum_prefix_8 != 8'b00000000 || carry_out_prefix_8 != 1'b1) $display("Prefix 8-bit Test Case 4 Failed");
        if (sum_cla_8 != 8'b00000000 || carry_out_cla_8 != 1'b1) $display("CLA 8-bit Test Case 4 Failed");
    end
endmodule