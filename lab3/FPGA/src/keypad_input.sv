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
	output logic press
);

	statetype state, nextstate;
	logic [5:0] counter;
	logic [3:0] cols_ff;
	// state register
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			state <= nextstate;
			counter <= 0;
		end
		//else if (state == RESET) begin
		//	counter <= counter + 1;
		//	state <= nextstate;
		//end
		else if (state == R0 || state == R1 || state == R2 || state == R3) begin
			counter <= 0;
			state <= nextstate;
		end else if (state == W0 || state == W1 || state == W2 || state == W3) begin
			counter <= 0;
			state <= nextstate;
		end else if (state == P0 || state == P1 || state == P2 || state == P3) begin
			cols_ff <= cols;
			state <= nextstate;
		end else begin
			counter <= counter + 1;
			state <= nextstate;
		end
	end
	
	// Call module to determine next state logic combinationally
	next_state_logic scan(state, cols, cols_ff, counter, nextstate);
	
	// output logic
	assign rows[0] = (state == B0 || state == R0 || state == D0 || state == P0 || state == W0) ? 1'b1 : 1'bz;
	assign rows[1] = (state == B1 || state == R1 || state == D1 || state == P1 || state == W1) ? 1'b1 : 1'bz;
	assign rows[2] = (state == B2 || state == R2 || state == D2 || state == P2 || state == W2) ? 1'b1 : 1'bz;
	assign rows[3] = (state == B3 || state == R3 || state == D3 || state == P3 || state == W3) ? 1'b1 : 1'bz;
	assign press = ((state == P0 || state == P1 || state == P2 || state == P3) && (cols[0] || cols[1] || cols[2] || cols[3]));
endmodule