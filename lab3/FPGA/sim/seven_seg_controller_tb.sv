// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test 7 segment display controller
module seven_seg_controller_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
    logic        clk;
    logic        reset;          
    logic [3:0]  s1, s2;
    logic        enable_left, enable_right;
    logic [6:0]  seg;
    logic        enable_left_exp;
    logic        enable_right_exp;
    logic [6:0]  seg_expected;
    logic [16:0] test_vectors[10000:0];
    logic [31:0] vectornum, errors;

    // instantiate dut
    seven_seg_controller dut (
    .clk(clk),
    .reset(reset),
    .s1(s1),
    .s2(s2),
    .enable_left(enable_left),
    .enable_right(enable_right),
    .seg(seg)
    );

    // Setup clock
    initial clk = 0;
    always #5 clk = ~clk;  

    logic enable_left_prev;


    


    initial begin
        $display("Reading test vectors");
        $readmemb("seven_seg_controller_tv.txt", test_vectors);
        vectornum = 0;
        errors = 0;

        reset  = 1;
        s1     = '0;
        s2     = '0;
        repeat (3) @(posedge clk);
        enable_left_prev= enable_left;
        reset  = 0;
        @(posedge clk);
    end

    // Get next vector
    always @(posedge clk) begin
        #1;
        if (enable_left_prev !== enable_left) begin
            {s1, s2, enable_left_exp, enable_right_exp, seg_expected} = test_vectors[vectornum];
        end
    end


    // Check outputs one half-cycle later, then advance
    always @(negedge clk) begin
    #1;
        if (enable_left_prev !== enable_left) begin
            if (enable_left != enable_left_exp || enable_right != enable_right_exp || seg != seg_expected) begin
                $display("Error (test %0d): s1=%b s2=%b", vectornum, s1, s2);
                $display("Got enable_left=%b enable_right=%b seg=%07b",
                            enable_left, enable_right, seg);
                $display("Expected enable_left=%b enable_right=%b seg=%07b",
                            enable_left_exp, enable_right_exp, seg_expected);
                errors = errors + 1;
            end
            enable_left_prev = enable_left;
            vectornum = vectornum + 1;

            if (test_vectors[vectornum] === 17'bx) begin
                $display("%0d tests completed with %0d errors", vectornum, errors);
                $finish;
            end
        end
    end

endmodule
