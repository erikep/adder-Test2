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

    // Test RCA, Prefix, and CLA adders with 16-bit inputs
    reg [15:0] a_16;
    reg [15:0] b_16;
    reg carry_in_16;
    //RCA wires
    wire [15:0] sum_rca_16;
    wire carry_out_rca_16;
    //Prefix wires
    wire [15:0] sum_prefix_16;
    wire carry_out_prefix_16;
    //CLA wires
    wire [15:0] sum_cla_16;
    wire carry_out_cla_16;
    rca #(.BITWIDTH(16)) rca_16 (
        .bits_a(a_16),
        .bits_b(b_16),
        .carry_in(carry_in_16),
        .sum(sum_rca_16),
        .carry_out(carry_out_rca_16)
    );
    prefix #(.BITWIDTH(16)) prefix_16 (
        .bits_a(a_16),
        .bits_b(b_16),
        .carry_in(carry_in_16),
        .sum(sum_prefix_16),
        .carry_out(carry_out_prefix_16)
    );
    cla #(.BITWIDTH(16)) cla_16 (
        .bits_a(a_16),
        .bits_b(b_16),
        .carry_in(carry_in_16),
        .sum(sum_cla_16),
        .carry_out(carry_out_cla_16)
    );
    initial begin
        // Test case 1
        a_16 = 16'b0000000000000000; // 0
        b_16 = 16'b0000000000000000; // 0
        carry_in_16 = 1'b1;
        #10;
        $display("16-bit Test Case 1:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_rca_16, carry_out_rca_16);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_prefix_16, carry_out_prefix_16);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_cla_16, carry_out_cla_16);
        if (sum_rca_16 != 16'b0000000000000001 || carry_out_rca_16 != 1'b0) $display("RCA 16-bit Test Case 1 Failed");
        if (sum_prefix_16 != 16'b0000000000000001 || carry_out_prefix_16 != 1'b0) $display("Prefix 16-bit Test Case 1 Failed");
        if (sum_cla_16 != 16'b0000000000000001 || carry_out_cla_16 != 1'b0) $display("CLA 16-bit Test Case 1 Failed");
        // Test case 2
        a_16 = 16'b1111111111111111; // 65535
        b_16 = 16'b0000000000000001; // 1
        carry_in_16 = 1'b0;
        #10;
        $display("16-bit Test Case 2:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_rca_16, carry_out_rca_16);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_prefix_16, carry_out_prefix_16);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_cla_16, carry_out_cla_16);
        if (sum_rca_16 != 16'b0000000000000000 || carry_out_rca_16 != 1'b1) $display("RCA 16-bit Test Case 2 Failed");
        if (sum_prefix_16 != 16'b0000000000000000 || carry_out_prefix_16 != 1'b1) $display("Prefix 16-bit Test Case 2 Failed"); 
        if (sum_cla_16 != 16'b0000000000000000 || carry_out_cla_16 != 1'b1) $display("CLA 16-bit Test Case 2 Failed");
        // Test case 3
        a_16 = 16'b1010101010101010; // 43690
        b_16 = 16'b0101010101010101; // 21845
        carry_in_16 = 1'b0;
        #10;
        $display("16-bit Test Case 3:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_rca_16, carry_out_rca_16);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_prefix_16, carry_out_prefix_16);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_cla_16, carry_out_cla_16);
        if (sum_rca_16 != 16'b1111111111111111 || carry_out_rca_16 != 1'b0) $display("RCA 16-bit Test Case 3 Failed");
        if (sum_prefix_16 != 16'b1111111111111111 || carry_out_prefix_16 != 1'b0) $display("Prefix 16-bit Test Case 3 Failed"); 
        if (sum_cla_16 != 16'b1111111111111111 || carry_out_cla_16 != 1'b0) $display("CLA 16-bit Test Case 3 Failed");
        // Test case 4
        a_16 = 16'b1010101010101010; // 43690
        b_16 = 16'b0101010101010101; // 21845
        carry_in_16 = 1'b1;
        #10;
        $display("16-bit Test Case 4:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_rca_16, carry_out_rca_16);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_prefix_16, carry_out_prefix_16);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_16, b_16, carry_in_16, sum_cla_16, carry_out_cla_16);
        if (sum_rca_16 != 16'b0000000000000000 || carry_out_rca_16 != 1'b1) $display("RCA 16-bit Test Case 4 Failed");
        if (sum_prefix_16 != 16'b0000000000000000 || carry_out_prefix_16 != 1'b1) $display("Prefix 16-bit Test Case 4 Failed");
        if (sum_cla_16 != 16'b0000000000000000 || carry_out_cla_16 != 1'b1) $display("CLA 16-bit Test Case 4 Failed");
    end

    // Test RCA, Prefix, and CLA adders with 32-bit inputs
    reg [31:0] a_32;
    reg [31:0] b_32;
    reg carry_in_32;
    //RCA wires
    wire [31:0] sum_rca_32;
    wire carry_out_rca_32;
    //Prefix wires
    wire [31:0] sum_prefix_32;
    wire carry_out_prefix_32;
    //CLA wires
    wire [31:0] sum_cla_32;
    wire carry_out_cla_32;
    rca #(.BITWIDTH(32)) rca_32 (
        .bits_a(a_32),
        .bits_b(b_32),
        .carry_in(carry_in_32),
        .sum(sum_rca_32),
        .carry_out(carry_out_rca_32)
    );
    prefix #(.BITWIDTH(32)) prefix_32 (
        .bits_a(a_32),
        .bits_b(b_32),
        .carry_in(carry_in_32),
        .sum(sum_prefix_32),
        .carry_out(carry_out_prefix_32)
    );
    cla #(.BITWIDTH(32)) cla_32 (
        .bits_a(a_32),
        .bits_b(b_32),
        .carry_in(carry_in_32),
        .sum(sum_cla_32),
        .carry_out(carry_out_cla_32)
    );
    initial begin
        // Test case 1
        a_32 = 32'b00000000000000000000000000000000; // 0
        b_32 = 32'b00000000000000000000000000000000; // 0
        carry_in_32 = 1'b1;
        #10;
        $display("32-bit Test Case 1:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_rca_32, carry_out_rca_32);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_prefix_32, carry_out_prefix_32);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_cla_32, carry_out_cla_32);
        if (sum_rca_32 != 32'b00000000000000000000000000000001 || carry_out_rca_32 != 1'b0) $display("RCA 32-bit Test Case 1 Failed");
        if (sum_prefix_32 != 32'b00000000000000000000000000000001 || carry_out_prefix_32 != 1'b0) $display("Prefix 32-bit Test Case 1 Failed");
        if (sum_cla_32 != 32'b00000000000000000000000000000001 || carry_out_cla_32 != 1'b0) $display("CLA 32-bit Test Case 1 Failed");
        // Test case 2
        a_32 = 32'b11111111111111111111111111111111; // 4294967295
        b_32 = 32'b00000000000000000000000000000001; // 1
        carry_in_32 = 1'b0;
        #10;
        $display("32-bit Test Case 2:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_rca_32, carry_out_rca_32);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_prefix_32, carry_out_prefix_32);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_cla_32, carry_out_cla_32);
        if (sum_rca_32 != 32'b00000000000000000000000000000000 || carry_out_rca_32 != 1'b1) $display("RCA 32-bit Test Case 2 Failed");
        if (sum_prefix_32 != 32'b00000000000000000000000000000000 || carry_out_prefix_32 != 1'b1) $display("Prefix 32-bit Test Case 2 Failed");
        if (sum_cla_32 != 32'b00000000000000000000000000000000 || carry_out_cla_32 != 1'b1) $display("CLA 32-bit Test Case 2 Failed");
        // Test case 3
        a_32 = 32'b10101010101010101010101010101010; // 2863311530
        b_32 = 32'b01010101010101010101010101010101; // 1431655765
        carry_in_32 = 1'b0;
        #10;
        $display("32-bit Test Case 3:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_rca_32, carry_out_rca_32);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_prefix_32, carry_out_prefix_32);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_cla_32, carry_out_cla_32);
        if (sum_rca_32 != 32'b11111111111111111111111111111111 || carry_out_rca_32 != 1'b0) $display("RCA 32-bit Test Case 3 Failed");
        if (sum_prefix_32 != 32'b11111111111111111111111111111111 || carry_out_prefix_32 != 1'b0) $display("Prefix 32-bit Test Case 3 Failed"); 
        if (sum_cla_32 != 32'b11111111111111111111111111111111 || carry_out_cla_32 != 1'b0) $display("CLA 32-bit Test Case 3 Failed");
        // Test case 4
        a_32 = 32'b10101010101010101010101010101010; // 2863311530
        b_32 = 32'b01010101010101010101010101010101; // 1431655765
        carry_in_32 = 1'b1;
        #10;
        $display("32-bit Test Case 4:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_rca_32, carry_out_rca_32);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_prefix_32, carry_out_prefix_32);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_32, b_32, carry_in_32, sum_cla_32, carry_out_cla_32);
        if (sum_rca_32 != 32'b00000000000000000000000000000000 || carry_out_rca_32 != 1'b1) $display("RCA 32-bit Test Case 4 Failed");
        if (sum_prefix_32 != 32'b00000000000000000000000000000000 || carry_out_prefix_32 != 1'b1) $display("Prefix 32-bit Test Case 4 Failed");
        if (sum_cla_32 != 32'b00000000000000000000000000000000 || carry_out_cla_32 != 1'b1) $display("CLA 32-bit Test Case 4 Failed");
    end

    // Test RCA, Prefix, and CLA adders with 64-bit inputs
    reg [63:0] a_64;
    reg [63:0] b_64;
    reg carry_in_64;
    //RCA wires
    wire [63:0] sum_rca_64;
    wire carry_out_rca_64;
    //Prefix wires
    wire [63:0] sum_prefix_64;
    wire carry_out_prefix_64;
    //CLA wires
    wire [63:0] sum_cla_64;
    wire carry_out_cla_64;
    rca #(.BITWIDTH(64)) rca_64 (
        .bits_a(a_64),
        .bits_b(b_64),
        .carry_in(carry_in_64),
        .sum(sum_rca_64),
        .carry_out(carry_out_rca_64)
    );
    prefix #(.BITWIDTH(64)) prefix_64 (
        .bits_a(a_64),
        .bits_b(b_64),
        .carry_in(carry_in_64),
        .sum(sum_prefix_64),
        .carry_out(carry_out_prefix_64)
    );
    cla #(.BITWIDTH(64)) cla_64 (
        .bits_a(a_64),
        .bits_b(b_64),
        .carry_in(carry_in_64),
        .sum(sum_cla_64),
        .carry_out(carry_out_cla_64)
    );
    initial begin
        // Test case 1
        a_64 = 64'b0000000000000000000000000000000000000000000000000000000000000000; // 0
        b_64 = 64'b0000000000000000000000000000000000000000000000000000000000000000; // 0
        carry_in_64 = 1'b1;
        #10;
        $display("64-bit Test Case 1:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_rca_64, carry_out_rca_64);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_prefix_64, carry_out_prefix_64);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_cla_64, carry_out_cla_64);
        if (sum_rca_64 != 64'b0000000000000000000000000000000000000000000000000000000000000001 || carry_out_rca_64 != 1'b0) $display("RCA 64-bit Test Case 1 Failed");
        if (sum_prefix_64 != 64'b0000000000000000000000000000000000000000000000000000000000000001 || carry_out_prefix_64 != 1'b0) $display("Prefix 64-bit Test Case 1 Failed");
        if (sum_cla_64 != 64'b0000000000000000000000000000000000000000000000000000000000000001 || carry_out_cla_64 != 1'b0) $display("CLA 64-bit Test Case 1 Failed");
        // Test case 2
        a_64 = 64'b1111111111111111111111111111111111111111111111111111111111111111; // 18446744073709551615
        b_64 = 64'b0000000000000000000000000000000000000000000000000000000000000001; // 1
        carry_in_64 = 1'b0;
        #10;
        $display("64-bit Test Case 2:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_rca_64, carry_out_rca_64);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_prefix_64, carry_out_prefix_64);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_cla_64, carry_out_cla_64);
        if (sum_rca_64 != 64'b0000000000000000000000000000000000000000000000000000000000000000 || carry_out_rca_64 != 1'b1) $display("RCA 64-bit Test Case 2 Failed");
        if (sum_prefix_64 != 64'b0000000000000000000000000000000000000000000000000000000000000000 || carry_out_prefix_64 != 1'b1) $display("Prefix 64-bit Test Case 2 Failed");
        if (sum_cla_64 != 64'b0000000000000000000000000000000000000000000000000000000000000000 || carry_out_cla_64 != 1'b1) $display("CLA 64-bit Test Case 2 Failed");
        // Test case 3
        a_64 = 64'b1010101010101010101010101010101010101010101010101010101010101010; // 12297829382473034410
        b_64 = 64'b0101010101010101010101010101010101010101010101010101010101010101; // 6148914691236517205
        carry_in_64 = 1'b0;
        #10;
        $display("64-bit Test Case 3:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_rca_64, carry_out_rca_64);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_prefix_64, carry_out_prefix_64);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_cla_64, carry_out_cla_64);
        if (sum_rca_64 != 64'b1111111111111111111111111111111111111111111111111111111111111111 || carry_out_rca_64 != 1'b0) $display("RCA 64-bit Test Case 3 Failed");
        if (sum_prefix_64 != 64'b1111111111111111111111111111111111111111111111111111111111111111 || carry_out_prefix_64 != 1'b0) $display("Prefix 64-bit Test Case 3 Failed"); 
        if (sum_cla_64 != 64'b1111111111111111111111111111111111111111111111111111111111111111 || carry_out_cla_64 != 1'b0) $display("CLA 64-bit Test Case 3 Failed");
        // Test case 4
        a_64 = 64'b1010101010101010101010101010101010101010101010101010101010101010; // 12297829382473034410
        b_64 = 64'b0101010101010101010101010101010101010101010101010101010101010101; // 6148914691236517205
        carry_in_64 = 1'b1;
        #10;
        $display("64-bit Test Case 4:");
        $display("RCA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_rca_64, carry_out_rca_64);
        $display("Prefix: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_prefix_64, carry_out_prefix_64);
        $display("CLA: %b + %b + %b = %b, Carry Out: %b", a_64, b_64, carry_in_64, sum_cla_64, carry_out_cla_64);
        if (sum_rca_64 != 64'b0000000000000000000000000000000000000000000000000000000000000000 || carry_out_rca_64 != 1'b1) $display("RCA 64-bit Test Case 4 Failed");
        if (sum_prefix_64 != 64'b0000000000000000000000000000000000000000000000000000000000000000 || carry_out_prefix_64 != 1'b1) $display("Prefix 64-bit Test Case 4 Failed");
        if (sum_cla_64 != 64'b0000000000000000000000000000000000000000000000000000000000000000 || carry_out_cla_64 != 1'b1) $display("CLA 64-bit Test Case 4 Failed");
    end

    // Generate a VCD file for waveform viewing
    initial begin
        $dumpfile("tb_waveforms.vcd");
        $dumpvars(0, tb_adders);
    end
endmodule