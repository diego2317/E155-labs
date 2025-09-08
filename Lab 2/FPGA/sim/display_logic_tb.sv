// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test 7 segment display controller
module display_controller_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
	logic clk, reset;
	logic [3:0] s;
	logic [6:0] seg, seg_expected;
	logic [13:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;
	
	// Instantiate DUT
	display_controller dut(reset, s, seg); 

	// generate clock
	always
	begin
		clk=1; #5; clk=0; #5;
	end
	
	initial 
		begin
			$readmemb("display_logic_tv.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
		
	always @(posedge clk)
		begin
			#1; {s, seg_expected} = testvectors[vectornum];
		end
	
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (seg != seg_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", seg, seg_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end

endmodule
