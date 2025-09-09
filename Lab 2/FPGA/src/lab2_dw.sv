// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module implements the logic for lab 2 of E155 at Harvey Mudd College
module lab2_dw(
	
	input  logic reset,
	input  logic [3:0] s1, s2,
	output logic       t1, t2,
	output logic [4:0] led,
	output logic [6:0] seg);
				
	logic int_osc;
	HSOSC #(.CLKHF_DIV(2'b01)) 
					hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	display_controller DISPLAY_CONTROL(
		.clk(int_osc),
		.reset(reset),
		.s1(s1),
		.s2(s2),
		.t1(t1),
		.t2(t2),
		.led(led),
		.seg(seg)
	);			
	
	
endmodule
