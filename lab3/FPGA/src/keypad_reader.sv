// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9.15.2025
// This module deals with reading the keypad
module keypad_reader(
	input  logic        clk,
	input  logic       reset,
	input  logic [3:0] cols,
	output logic [3:0] rows,
	output logic [3:0] new_value, old_value
	);
	
	logic [3:0] temp;
	logic [3:0] digit_storage;	logic key_pressed, new_key;
	logic [3:0] rows_out;
	
	
	// Scan rows
	keypad_input k(
		.clk(clk),
		.reset(reset),
		.cols(cols),
		.rows(rows_out),
		.press(key_pressed),
		.change(new_key)
	);
	
	// Convert from key to hex
	keypad_decoder keypad(
		.rows(rows_out),
		.cols(cols),
		.input_key(temp)
	);
	
	// Current values FSM
	always_ff @(posedge clk) begin
		if (reset == 0) begin
			new_value <= 3'b0;
			old_value <= 3'b0;
		end else if (new_key) begin
			old_value <= new_value;
			new_value <= digit_storage;
		end else if (key_pressed) begin
			digit_storage <= temp;
		end
	end
	
	assign rows = rows_out;
	
endmodule
