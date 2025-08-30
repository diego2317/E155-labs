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
			   
			   led_controller LED (clk, reset, s, led);
			   display_controller DISPLAY (s, seg);
endmodule