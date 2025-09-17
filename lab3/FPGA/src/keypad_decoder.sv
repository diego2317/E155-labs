// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/25
// This module decodes a 4 by 4 keypad

module keypad_decoder(
	input  logic [3:0] rows,
	input  logic [3:0] cols,
	output logic [3:0] input_key
);

	always_comb begin
		case ({cols, rows})
            8'b1110_1110: input_key = 4'h0;
            8'b1101_1110: input_key = 4'h1;
            8'b1011_1110: input_key = 4'h2;
            8'b0111_1110: input_key = 4'h3;
            8'b1110_1101: input_key = 4'h4;
            8'b1101_1101: input_key = 4'h5;
            8'b1011_1101: input_key = 4'h6;
            8'b0111_1101: input_key = 4'h7;
            8'b1110_1011: input_key = 4'h8;
            8'b1101_1011: input_key = 4'h9;
            8'b1011_1011: input_key = 4'hA;
            8'b0111_1011: input_key = 4'hB;
            8'b1110_0111: input_key = 4'hC;
            8'b1101_0111: input_key = 4'hD;
            8'b1011_0111: input_key = 4'hE;
            8'b0111_0111: input_key = 4'hF;
            default: input_key = 4'bx;
		endcase
	end
	

endmodule