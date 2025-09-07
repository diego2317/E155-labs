// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module implements the logic for lab 2 of E155 at Harvey Mudd College
module lab2_dw(
	input  logic reset,
	input  logic [7:0] s,
	output logic [1:0] t,
	output logic [4:0] led,
	output logic [6:0] seg_out);
				
				
	logic toggle;
	logic [3:0] current_s; // Keeps track of the current switch
	
	logic int_osc;
	// Initialize high-speed oscillator to 24 MHz
	HSOSC #(.CLKHF_DIV(2'b01)) 
					hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
					
	// Output logic, initialize modules
	display_controller DISPLAY_CONTROL(
		.clk(int_osc), 
		.reset(reset),
		.s(s),
		.toggle(toggle),
		.s_out(current_s)
	);
	
	display_logic DISPLAY(.reset(reset), .s(current_s), .seg(seg_out));
	led_controller LED_CONTROL(.s(s), .led(led));
	
	// Assign final signals
	assign t[0] = toggle;
	assign t[1] = ~toggle;
	
	
endmodule
