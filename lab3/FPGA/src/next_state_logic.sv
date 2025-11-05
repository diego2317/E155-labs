// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/15/2025
// This module determines next state logic for my keypad scanner

// Import state
import state::*;

module next_state_logic(
	input statetype state,
	input logic [3:0] cols,
	input logic [5:0] counter,
	output statetype nextstate
);
	logic press;
	logic valid_press;
	logic valid_input;
	logic orig;
	assign orig = cols;
	assign valid_input = ($countones(cols)==1);
	// if any of the columns are read to be low, then that indicates a press.
	assign press = (cols[0] || cols[1] || cols[2] || cols[3]);
	assign valid_press = valid_input && press;
	
	always_comb
		case(state)
			//RESET: begin
			//	nextstate = (counter == 1) ? B0: RESET;
			//end
			// row turns on, we wait two clock cycles for the column signal to change after the row changes
			B0: begin
					nextstate = (counter >= 1) ? R0 : B0;
				end
			B1: begin
					nextstate = (counter == 1) ? R1 : B1;
				end
			B2: begin
					nextstate = (counter == 1) ? R2 : B2;  
				end
			B3: begin
					nextstate = (counter == 1) ? R3 : B3;
				end
			// in the scanning row state
			R0: begin
					nextstate = (valid_press) ? D0 : B1;  
				end
			R1: begin
					nextstate = (valid_press) ? D1 : B2;  
				end
			R2: begin
					nextstate = (valid_press) ? D2 : B3;  
				end
			R3: begin
					nextstate = (valid_press) ? D3 : B0;  
				end
			// debouncing state, we wait a certain amount of clock cycles for the signal to settle
			D0: begin
					if (counter == 15) begin 
						nextstate = (valid_press) ? P0 : R0;
					end
					else begin
						nextstate = (valid_press) ? D0 : R0;
					end
				end
			D1: begin
					if (counter == 15) begin 
						nextstate = (valid_press) ? P1 : R1;
					end
					else begin
						nextstate = (valid_press) ? D1 : R1;
					end 
				end
			D2: begin
					if (counter == 15) begin 
						nextstate = (valid_press) ? P2 : R2;
					end
					else begin
						nextstate = (valid_press) ? D2 : R2;
					end
				end
			D3: begin
					if (counter == 15) begin 
						nextstate = (valid_press) ? P3 : R3;
					end
					else begin
						nextstate = (valid_press) ? D3 : R3;
					end
				end
			// Send the message that a key's been pressed
			P0: begin
					nextstate = (valid_press) ? W0 : R0;  
				end
			P1: begin
					nextstate = (valid_press) ? W1 : R1;  
				end
			P2: begin
					nextstate = (valid_press) ? W2 : R2;  
				end
			P3: begin
					nextstate = (valid_press) ? W3 : R3;  
				end
			// in the waiting state (waiting for pressed button to be released)
			W0: begin
					nextstate = (valid_press) ? W0 : R0;  
				end
			W1: begin
					nextstate = (valid_press) ? W1 : R1;  
				end
			W2: begin
					nextstate = (valid_press) ? W2 : R2;  
				end
			W3: begin
					nextstate = (valid_press) ? W3 : R3;  
				end
			default: nextstate = R0;
		endcase

endmodule