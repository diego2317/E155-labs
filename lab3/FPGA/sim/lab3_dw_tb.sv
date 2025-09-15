// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/25
// This module is a top-level testbench for my implementation of E155 Lab 3
module lab3_dw_tb();

    logic clk, reset;
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
    always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
    
    initial
        begin
            $readmemb("lab3_dw_tv.txt", testvectors);
            vectornum = 0; errors = 0;
            reset = 0; #22; reset = 1;
        end
    
    always @(posedge clk)
        begin
            #1; {cols, rows_expected, enable_left_exp, enable_right_exp, seg_expected} = testvectors[vectornum];
        end
    
    always @(negedge clk)
        if (reset) begin // skip during reset
            if (rows != rows_expected || enable_left != enable_left_exp || enable_right != enable_right_exp || seg != seg_expected) begin // check result
                $display("Error: input = %b", cols);
                $display(" outputs = %b (%b expected)", {rows, enable_left, enable_right, seg}, {rows_expected, enable_left_exp, enable_right_exp, seg_expected});
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 17'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
        end


endmodule