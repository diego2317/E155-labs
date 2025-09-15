// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/15/25
// This module gets the input from the keypad

// define variable type for state
//typedef enum logic [3:0] {B0, B1, B2, B3, P0, P1, P2, P3, W0, W1, W2, W3} statetype;
import state::*;

module keypad_input(
	input logic clk,
	input logic reset,
	input logic [3:0] cols,
	output logic [3:0] rows,
	output logic press,
	output logic change
);

	statetype state, nextstate;
	logic [5:0] counter;

	// state register
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			state <= B0;
			counter <= 0;
		end
		else begin
			// Reset the counter when scanning columns, otherwise increment
			counter <= (state == R0 || state == R1 || state == R2 || state == R3) ? 0 : counter + 1;
			state <= nextstate;
		end
	end
	
	// Call module to determine next state logic combinationally
	next_state_logic scan(state, cols, counter, nextstate);
	
	// output logic
	assign rows[0] = (state == B1 || state == R1 || state == B2 || state == R2 || state == B3 || state == R3);
	assign rows[1] = (state == B2 || state == R2 || state == B3 || state == R3 || state == B0 || state == R0);
	assign rows[2] = (state == B3 || state == R3 || state == B0 || state == R0 || state == B1 || state == R1);
	assign rows[3] = (state == B0 || state == R0 || state == B1 || state == R1 || state == B2 || state == R2);
	assign press = ((state == R0 || state == R1 || state == R2 || state == R3) && !(cols[0] && cols[1] && cols[2] && cols[3]));
	assign change = (state == P0 || state == P1 || state == P2 || state == P3);	
endmodule