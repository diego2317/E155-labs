// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test 7 segment display controller
module display_controller_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
	logic clk, reset;
	logic [3:0] s1, s2;
    	logic t1, t2;
	logic [4:0] led;
    	logic [6:0] seg;
	logic [13:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;

	
	// Instantiate DUT
	display_controller dut(clk, reset, s1, s2, t1, t2, led, seg); 

	// generate clock
	always
	begin
		clk=1; #5; clk=0; #5;
	end
	
	// apply test vectors
	initial begin
		s1 = 4'b0000;
		s2 = 4'b1111;
		#20;
		s1 = 4'b1000;
		s2 = 4'b0001;
		#20;
		s1 = 4'b1010;
		s2 = 4'b1001;
		#20;
	end


endmodule
