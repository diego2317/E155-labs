// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test top-level lab 1 module
module lab1_dw_tb();
	logic clk, reset;
	logic [3:0] s;
	logic [2:0] led, led_expected;
	logic [6:0] seg, seg_expected;
	logic [13:0] testvectors[10000:0];
	logic [31:0] vectornum, errors;
	
	// Instantiate DUT
	dut lab1_dw(.clk(clk), .reset(reset), .s(s),  


endmodule