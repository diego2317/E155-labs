// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.4.2025
// This module controls 5 LEDs to represent the sum of two 4 bit binary numbers
module led_controller(
	input  logic [3:0] s1, s2,
	output logic [4:0] led);
	
	assign led = s1 + s2; // Simple!

endmodule