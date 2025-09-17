// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/2025
// This module synchronizes asynchronous inputs to deal with switch debouncing
// Note: design taken from DDCA RISC-V Edition, HDL Exmaple 4.20
module synchronizer (
    input  logic clk,
	input  logic reset,
    input  logic [3:0] cols,
    output logic [3:0] s_cols
);

logic [3:0] n;

always_ff @(posedge clk) begin
		if (reset == 0) n <= 4'b0;
		else begin
			n <= cols;
			s_cols <= n;
        end
    end

endmodule