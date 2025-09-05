// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls 5 LEDs to represent the sum of two 4 bit binary numbers
module led_controller(
	input  logic [7:0] s,
	output logic [4:0] led);
	
	assign led = s[3:0] + s[7:4]; // Simple!

endmodule