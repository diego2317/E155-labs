// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 8/30/25
// This serves as the top-level module for E155 lab 1 at Harvey Mudd College. This module calls a bmodule that toggles onboard LEDs on the
// E155 development board and a module that controls a 7-segment display

module lab1_dw(input  logic clk,
			   input  logic reset,
			   input  logic [3:0] s,
			   output logic [2:0] led,
			   output logic [6:0] seg);
			   
			   logic int_osc;
			   // Initialize high-speed oscillator to 24 MHz
				HSOSC #(.CLKHF_DIV(2'b01)) 
					hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

			   
			   led_controller LED (int_osc, reset, s, led);
			   display_controller DISPLAY (s, seg);
endmodule