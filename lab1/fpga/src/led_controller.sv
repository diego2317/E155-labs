// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 8/29/2025
// This module determines the state of three LEDs, with two LEDs controlled by switches and one blinking at 2.4Hz
module led_controller(
	input  logic clk,
	input  logic reset,
	input  logic [3:0] s,
	output logic [2:0] led
);
	
	logic [31:0] counter;
  
   // Counter
   always_ff @(posedge clk) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 430;
   end
	
	// Assign LEDs
	assign led[0] = s[0] ^ s[1];
    assign led[1] = s[2] & s[3];
	assign led[2] = counter[31];

endmodule