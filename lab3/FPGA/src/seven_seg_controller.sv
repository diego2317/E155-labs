// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls a 7 segment display based on input switches
module seven_seg_controller(
	input  logic 	   clk,
	input  logic 	   reset,
	input  logic [3:0] s1, s2,
	output logic       enable_left, enable_right,
	output logic [6:0] seg
	);
	
	logic toggle; // select signal
	logic [1:0] counter;
	logic [3:0] sw;
	
	// Clock divider
	always_ff @(posedge clk) begin
	 	if (reset == 0) counter <= 0;
	 	else counter <= counter + 1;
	end
	
	//assign toggle = counter[1];
	assign toggle = counter[0]; // for testing
	assign enable_left = toggle;
	assign enable_right = ~toggle;
	assign sw = toggle ? s2 : s1; // mux
	seven_seg_decoder DISPLAY(.s(sw), .seg(seg));

	
endmodule
