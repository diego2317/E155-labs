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


// Setup internal signals
logic [3:0] synchronized_cols;



logic int_osc;
// Initialize high-speed oscillator to 24 MHz
				HSOSC #(.CLKHF_DIV(2'b01)) 
					hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));


//* Slowing down the clk
logic _240_Hz_clk;  // 240Hz clock for seven segment display
clock_divider #('d50000) _240_Hz_divider (
    .clk(int_osc),
    .reset(reset),
    .divided_clock(_240_Hz_clk)
);

logic _60_Hz_clk;  // 60Hz clock for keypad
clock_divider #('d200000) _60_Hz_divider (
    .clk(int_osc),
    .reset(reset),
    .divided_clock(_60_Hz_clk)
);


// Synchronize for debouncing
synchronizer sync(
    .clk(_60_Hz_clk),
    .cols(cols),
    .synchronized_cols(synchronized_cols)
);

assign enable_left = _240_Hz_clk;
assign enable_right = ~_240_Hz_clk;

// Create internal signals for input, current value, old value
logic [3:0] input_key, current_value, old_value;
logic       valid_input;

// Gets keypad input
keypad_decoder keypad(
	.clk(_60_Hz_clk),
	.reset(reset),
	.cols(cols),
	.current_value(current_value),
	.rows(rows),
	.input_key(input_key),
	.valid_input(valid_input)
);

// Setup flops to hold values
flopenr current_value_flop (
	.clk(_60_Hz_clk),
	.reset(reset),
	.en(valid_input),
	.d(input_key),
	.q(current_value)
);

flopenr old_value_flop (
	.clk(_60_Hz_clk),
	.reset(reset),
	.en(valid_input),
	.d(current_value),
	.q(old_value)
);




logic [3:0] display_input; // Internal signal that goes to 7 seg display decoder
assign display_input = _240_Hz_clk ? current_value : old_value; // Mux to select what's being displayed
// Control 7 segment display
seven_seg_decoder _7_seg_display(
	.s(display_input),
	.seg(seg)
);


endmodule