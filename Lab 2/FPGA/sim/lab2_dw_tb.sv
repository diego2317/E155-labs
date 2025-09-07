// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/3/25
// Module to test top level module for E155 Lab 2 at Harvey Mudd
module lab2_dw_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1ps / 1ps
	logic clk, reset;
	logic [7:0] s;
    logic [1:0] t;
	logic [4:0] led;
    logic [6:0] seg;
	logic [13:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;
	

	// Instantiate DUT
	lab2_dw dut(reset, s, t, led, seg); 

	// generate clock with a period of 5 timesteps
	always begin
    	clk = 1; #5;
    	clk = 0; #5;
  	end
	
	// apply test vectors
	initial begin
		s[3:0]=4'b0000; s[7:4]=4'b0000; #20;
    	s[3:0]=4'b0001; s[7:4]=4'b0000; #20;
    	s[3:0]=4'b0000; s[7:4]=4'b0001; #20;
    	s[3:0]=4'b0001; s[7:4]=4'b0001; #20;
    	s[3:0]=4'b1111; s[7:4]=4'b0000; #20;
    	s[3:0]=4'b0000; s[7:4]=4'b1111; #20;
    	s[3:0]=4'b1111; s[7:4]=4'b1111; #20;
		s[3:0]=4'b0100; s[7:4]=4'b0010; #20;
	end
endmodule
