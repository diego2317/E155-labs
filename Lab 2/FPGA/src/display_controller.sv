// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls a 7 segment display based on input switches
module display_controller(
	input  logic 	   clk,
	input  logic 	   reset,
	input  logic [7:0] s,
	output logic       toggle,
	output logic [3:0] s_out
	);
	
	//logic [6:0] seg_left, seg_right; // internal signals for left and right displays
	logic curr, next; // Used for tracking current and next states
	logic [31:0] counter;
	
	// Register for state
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			curr <= 0;
			counter <= 0;
		end else begin
			curr <= next;
			counter <= counter + 178957;
		end
	end
	
	// Next state logic
	always_comb begin
		case (curr)
			1'b0: next = (counter[31] == 1'b1) ? 1'b1 : 1'b0;
			1'b1: next = (counter[31] == 1'b1) ? 1'b0 : 1'b1;
			default: next = 1'b0;
		endcase
	end
	
	// Output logic
	// State 0 -> first digit
	// State 1 -> second digit
	assign toggle = curr;
	assign s_out = (curr ? s[3:0] : s[7:4]);

	
endmodule
