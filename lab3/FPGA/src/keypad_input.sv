// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/25
// This module gets the value of the key pressed and turns it into a 4 bit binary
module keypad_input(
    input  logic clk,
    input  logic reset,
    input  logic [3:0] rows, cols,
    output logic valid_input,
    output logic [3:0] input_key
);

    always_ff @(posedge clk) begin
        if (reset == 1) begin
            input_key = 4'hx;
            valid_input = 0;
        end else begin
            case ({
                cols, rows
            })
            8'b1110_1110: begin
                input_key = 4'h0;
                valid_input = 1;
            end
            8'b1101_1110: begin
                input_key = 4'h1;
                valid_input = 1;
            end
            8'b1011_1110: begin
                input_key = 4'h2;
                valid_input = 1;
            end
            8'b0111_1110: begin
                input_key = 4'h3;
                valid_input = 1;
            end
            8'b1110_1101: begin
                input_key = 4'h4;
                valid_input = 1;
            end
            8'b1101_1101: begin
                input_key = 4'h5;
                valid_input = 1;
            end
            8'b1011_1101: begin
                input_key = 4'h6;
                valid_input = 1;
            end
            8'b0111_1101: begin
                input_key = 4'h7;
                valid_input = 1;
            end
            8'b1110_1011: begin
                input_key = 4'h8;
                valid_input = 1;
            end
            8'b1101_1011: begin
                input_key = 4'h9;
                valid_input = 1;
            end
            8'b1011_1011: begin
                input_key = 4'hA;
                valid_input = 1;
            end
            8'b0111_1011: begin
                input_key = 4'hB;
                valid_input = 1;
            end
            8'b1110_0111: begin
                input_key = 4'hC;
                valid_input = 1;
            end
            8'b1101_0111: begin
                input_key = 4'hD;
                valid_input = 1;
            end
            8'b1011_0111: begin
                input_key = 4'hE;
                valid_input = 1;
            end
            8'b0111_0111: begin
                input_key = 4'hF;
                valid_input = 1;
            end
            default: begin
                input_key = 4'hx;
                valid_input = 0;
            end
            endcase
        end
    end


endmodule