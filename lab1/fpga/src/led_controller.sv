// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 8/29/2025
// This module determines the state of three LEDs, with two LEDs controlled by switches and one blinking at 2.4Hz
module led_controller(
	input  logic clk,
	input  logic [3:0] s,
	output logic [2:0] led
);

	// Initialize variables
	logic int_osc;
	logic [24:0] counter;
	
	// First, define led[0] and led[1] just in case
	assign led[0] = 0;
	assign led[1] = 0;
	
	// Logic to determine led[0] and led[1] based on s
	assign led[0] = s[0] ^ s[1];
	assign led[1] = s[2] & s[3];
	
	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	always_ff @(posedge int_osc) begin
		if (reset == 0) counter <= 0;
		else 			counter <= counter + 1;
	end
	
	// Assign LED 2
	assign led[2] = counter[24];

endmodule