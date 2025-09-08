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

	// generate clock with a period of 5 timesteps
	always begin
    	clk = 1; #5;
    	clk = 0; #5;
  	end
	
	// apply test vectors
	initial begin
		reset = 1; #27; reset = 0; #500;
		 s0=4'b0000; s1=4'b0000; #1000000;
    	s0=4'b0001; s1=4'b0000; #1000000;
    	s0=4'b0000; s1=4'b0001; #1000000;
    	s0=4'b0001; s1=4'b0001; #1000000;
    	s0=4'b1111; s1=4'b0000; #1000000;
    	s0=4'b0000; s1=4'b1111; #1000000;
    	s0=4'b1111; s1=4'b1111; #1000000;
		s0=4'b0100; s1=4'b0010; #1000000;
	end
endmodule
