// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/25
// This module divides a clock

module clock_divider #(
    parameter HALF_PERIOD = 'd100000 // default divide is 100,000
) (
    input  logic clk, // original clock
    input  logic reset,
    output logic divided_clock
);

	logic [31:0] counter;

    always_ff @(posedge clk) begin
        if (reset == 1) begin
            counter <= 0;
            divided_clock <= 0;
        end else if (counter == HALF_PERIOD) begin // switch clock
            divided_clock <= ~divided_clock;
            counter <= 0;
        end else counter <= counter + 1;
    end


endmodule