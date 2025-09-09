// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls a 7 segment display based on input switches
module display_controller(
	input  logic 	   clk,
	input  logic 	   reset,
	input  logic [3:0] s1, s2,
	output logic       t1, t2,
	output logic [4:0] led,
	output logic [6:0] seg
	);
	
	logic toggle = 0;
	logic [24:0] counter = 0;
	logic [3:0] sw = s1;
	
	// Register for state
	always_ff @(posedge clk) begin
		counter <= counter + 1;
		if (counter == 102416) begin
			counter <= 0;
			toggle <= ~toggle;
			if (toggle == 0) sw = s1;
			else sw = s2;
		end
	end
	
	assign t1 = toggle;
	assign t2 = ~toggle;
	display_logic DISPLAY(.reset(reset), .s(sw), .seg(seg));
	led_controller LED_CONTROL(.s1(s1), .s2(s2), .led(led));

	
endmodule
