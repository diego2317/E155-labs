// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/3/25
// Module to test top level module for E155 Lab 2 at Harvey Mudd
module lab2_dw_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ms / 1 ns
	logic clk, reset;
	logic [3:0] s_1, s_2;
    logic       toggle_left;
    logic       toggle_right;
	logic [6:0] seg;
    logic [8:0] res_expected;
	logic [13:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;
	

    parameter CLOCK_PERIOD = 1; // 1 ms clock
	// Instantiate DUT
	lab2_dw dut(clk, reset, s_1, s_2, toggle_left, toggle_right, seg); 

	// generate clock
	always
	begin
		clk=0;
	end
	
	initial 
		begin
			$readmemb("lab2_dw_tv.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
		
	always @(posedge clk)
		begin
			#1; {s, res_expected} = testvectors[vectornum];
		end
	
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (seg != res_expected[6:0]) begin // check result
				$display("Error: input = %b", {s});
				$display(" Segment outputs = %b (%b expected)", seg, res_expected[6:0]);
				errors = errors + 1;
			end
            if (toggle_left != res_expected[9]) begin
                $display("Error: input = %b", {s});
                $display("Misaligned clock");
            end
            if (toggle_right != res_expected[7]) begin
                $display("Error: input = %b", {s});
                $display("Misaligned clock");
            end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end

endmodule
