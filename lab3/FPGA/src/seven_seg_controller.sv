// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls a dual 7 segment display based on input switches
module seven_seg_controller(
	input  logic 	   clk,
	input  logic 	   reset,
	input  logic [3:0] s1, s2,
	output logic       t1, t2,
	output logic [6:0] seg
	);
	
	logic toggle; // select signal
	logic [15:0] counter;
	logic [3:0] sw;
	
	// Clock divider
	always_ff @(posedge clk) begin
		if (reset == 0) counter <= 0;
		else counter <= counter + 1;
	end
	
	assign toggle = counter[15];
	
	assign t1 = toggle;
	assign t2 = ~toggle;
	assign sw = toggle ? s2 : s1; // mux
	display_logic DISPLAY(.s(sw), .seg(seg));

	
endmodule
