// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/25
// This module decodes a 4 by 4 keypad

module keypad_decoder(
    input  logic       clk,
    input  logic       reset,
    input  logic [3:0] cols,
    input  logic [3:0] current_value,
    output logic [3:0] rows,
    output logic [3:0] input_key,
    output logic       valid_input
);

logic [3:0] row_counter; // Determines which row we're currently driving high
logic valid_input_key;

keypad_input get_input (
    .clk(clk),
    .reset(reset),
    .rows(rows),
    .cols(cols),
    .valid_input(valid_input_key),
    .input_key(input_key)
);


// Define FSM States
typedef enum logic [1:0] {
    AWAIT_PRESS,
    INPUT,
    HOLD,
    DEBOUNCE
} fsm_states;

fsm_states current_state, next_state;

// Determine the row output
always_comb begin
    if (current_state == AWAIT_PRESS) begin
        unique case (row_counter)
            'b0001: rows = 4'b0001;
            'b0010: rows = 4'b0010;
            'b0100: rows = 4'b0100;
            'b1000: rows = 4'b1000;
        endcase
    end else rows = 4'b0000;
end

// State Register
always_ff @(posedge clk) begin
    if (reset == 0) begin
        current_state <= AWAIT_PRESS;
    end else begin
        current_state <= next_state;
    end
end

assign valid_input = current_state == INPUT && valid_input_key;

// Next state logic
always_comb begin
    case (current_state)
        AWAIT_PRESS:     next_state = cols === 4'b0000 ? AWAIT_PRESS : INPUT;
        INPUT:           next_state = cols === 4'b0000 ? DEBOUNCE    : HOLD;
        HOLD:            next_state = cols === 4'b0000 ? DEBOUNCE    : HOLD;
        DEBOUNCE:        next_state = cols === 4'b0000 ? AWAIT_PRESS : HOLD;
        default:  next_state = AWAIT_PRESS;
    endcase
end

// Next row logic
always_ff @(posedge clk) begin
    if (reset == 0) begin
        row_counter = 4'b0000;
    end else if (next_state == AWAIT_PRESS) begin
        row_counter <= row_counter == 4'b1000 ? 4'b0001 : row_counter << 1;
    end
end


endmodule