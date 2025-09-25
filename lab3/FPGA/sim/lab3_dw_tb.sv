// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/25
// This module is a top-level testbench for my implementation of E155 Lab 3
module lab3_dw_tb();
`timescale 1 ns / 1 ps
    logic clk = 0;
    logic reset;
    logic enable_left, enable_right;
    logic enable_left_exp, enable_right_exp;
    logic [3:0] cols, rows, rows_expected;
    logic [6:0] seg, seg_expected;

    logic [31:0] vectornum, errors;
    logic [16:0] testvectors[10000:0];

    // Instantiate dut
    lab3_dw dut(
        .reset(reset),
        .cols(cols),
        .enable_left(enable_left),
        .enable_right(enable_right),
        .rows(rows),
        .seg(seg)
    );


    // Setup clock
    localparam real CLK_PERIOD_NS = 1000.0 / 48.0;  // 48 MHz Clock
    always #(CLK_PERIOD_NS/2.0) clk = ~clk;
    
    initial
        begin
            $readmemb("lab3_dw_tv.txt", testvectors);
            vectornum = 0; errors = 0;
            reset  = 0;
            #22;
            reset = 1;
        end
    
    always @(posedge clk)
        begin // ignore during reset
            #1; {cols, rows_expected, enable_left_exp, enable_right_exp, seg_expected} = testvectors[vectornum];
        end
    
    always @(negedge clk) begin
        #1;
        if (reset) begin // ignore during reset
            if (rows != rows_expected || enable_left != enable_left_exp || enable_right != enable_right_exp || seg != seg_expected) begin // check result
                $display("Error: input = %b", cols);
                $display("Rows: %b (%b expected)", rows, rows_expected);
                $display("Enable left: %b (%b expected)", enable_left, enable_left_exp);
                $display("Enable right: %b (%b expected)", enable_right, enable_right_exp);
                $display("Seg: %b (%b expected)", seg, seg_expected);
                $display("Test number: %d", vectornum);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 17'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
        end
    end


endmodule