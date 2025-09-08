// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test led control module for E155 lab 2
module led_controller_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
	logic clk, reset;
	logic [7:0] s;
	logic [4:0] led, led_expected;
	logic [13:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;
	
	// Instantiate DUT
	display_controller dut(.s(s), .led(led)); 

	// generate clock
	always
	begin
		clk=1; #5; clk=0; #5;
	end
	
	initial 
		begin
			$readmemb("led_controller_tv.txt", testvectors);
			vectornum = 0; errors = 0;
			reset = 1; #22; reset = 0;
		end
		
	always @(posedge clk)
		begin
			#1; {s, led_expected} = testvectors[vectornum];
		end
	
	always @(negedge clk)
		if (~reset) begin // skip during reset
			if (led != led_expected) begin // check result
				$display("Error: input = %b", {s});
				$display(" outputs = %b (%b expected)", led, led_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end

endmodule
