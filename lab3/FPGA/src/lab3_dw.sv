// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/2025
// This serves as the top-level module for lab 3 of E155 at Harvey Mudd College
module lab3_dw (
    input  logic       reset,
    input  logic [3:0] cols,
    output logic       enable_left, enable_right,
    output logic [3:0] rows,
    output logic [6:0] seg
);

	logic [3:0] current_value, previous_value;
	logic [3:0] s_cols;
	logic int_osc, slow_clock;

	// Initialize high-speed oscillator to 24 MHz
	HSOSC #(.CLKHF_DIV(2'b01)) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

	// Create 2400 Hz clock
	clock_divider #('d1000) count(
		.clk(int_osc),
		.reset(reset),
		.divided_clock(slow_clock)
	);

	
	// Synchronize columns
	synchronizer sync(
		.clk(slow_clock),
		.reset(reset),
		.cols(cols),
		.s_cols(s_cols)
	);
	
	
	// Initalize top level module for keypad scanning
	keypad_reader keypad(
		.clk(slow_clock),
		.reset(reset),
		.cols(s_cols),
		.rows(rows),
		.new_value(previous_value),
		.old_value(current_value)
	);
	
	// Initialize module to control the 7 segment display
	seven_seg_controller DISPLAY_CONTROL(
		.clk(slow_clock),
		.reset(reset),
		.s1(current_value),
		.s2(previous_value),
		.enable_left(enable_left),
		.enable_right(enable_right),
		.seg(seg)
	);	


endmodule