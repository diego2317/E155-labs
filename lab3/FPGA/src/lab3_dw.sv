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

// Setup "slow" clock

//* Slowing down the clk
logic clkDiv240;  // 240Hz clock for seven segment display
clock_divider #('d10000) clkDivMod240 (
    .clk(clk),
    .reset(reset),
    .divided_clock(clkDiv240)
);

logic clkDiv48;  // 48Hz clock for keypad
clock_divider #('d500000) clkDivMod48 (
    .clk(clk),
    .reset(reset),
    .divided_clock(clkDiv48)
);

// Synchronize for debouncing
synchronizer sync(
    .clk(clock_speed_slow),
    .cols(cols),
    .synchronized_cols(synchronized_cols)
);

// Gets keypad input


// Control 7 segment display
seven_seg_controller SEVEN_SEG(
		.clk(int_osc),
		.reset(reset),
		.s1(s1),
		.s2(s2),
		.t1(enable_left),
		.t2(enable_right),
		.seg(seg)
);


endmodule