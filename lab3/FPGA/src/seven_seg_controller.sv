// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls a 7 segment display based on input switches
module seven_seg_controller(
	input  logic 	   clk,
	input  logic 	   reset,
	input  logic [3:0] s1, s2,
	output logic       t1, t2,
	output logic [6:0] seg
	);
	
	logic toggle; // select signal
	logic [3:0] sw;
	
	
	assign t1 = clk;
	assign t2 = ~clk;
	assign sw = clk ? s2 : s1; // mux
	seven_seg_decoder DISPLAY(.s(sw), .seg(seg));

	
endmodule
