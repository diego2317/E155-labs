// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module implements the logic for lab 2 of E155 at Harvey Mudd College
module lab2_dw(
				input  logic       clk,
				input  logic       reset,
				input  logic [7:0] s,
				output logic       toggle_left,
				output logic       toggle_right,
				output logic [6:0] seg_out);
				
	logic [6:0] seg_left;  // Internal signal for left side of dual 7-segment display
	logic [6:0] seg_right; // Internal signal for right side of dual 7-segment display
	logic       int_osc;

	
	
	
	// Initialize high-speed oscillator to 24 MHz
	HSOSC #(.CLKHF_DIV(2'b01)) 
					hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
					
	// Initialize display logic module
	display_controller display(s_1, seg_left);
					
	logic [31:0] counter;
  
	// Counter
	always_ff @(posedge clk) begin
		if(reset == 0)  counter <= 0;
		else            counter <= counter + 178957;
	end
	
	assign toggle = counter[31]; // now toggle should switch every 1 ms
	
	// If toggle is asserted, assign seg_left to seg.
	// Otherwise, assign seg_right to seg
	always_ff @(edge toggle) begin
		if(toggle == 1) begin
			assign seg_out = seg_left;
			assign toggle_left = ~toggle;
			assign toggle_right = toggle;
		end else begin
			assign seg_out = seg_right;
			assign toggle_right = toggle;
			assign toggle_right = ~toggle;
		end
	end
	
endmodule
