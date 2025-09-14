// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/13/2025
// This module synchronizes asynchronous inputs to deal with switch debouncing
// Note: design taken from DDCA RISC-V Edition, HDL Exmaple 4.20
module synchronizer (
    input logic clk,
    input  logic [3:0] cols,
    output logic [3:0] synchronized_cols
);

logic [3:0] n;

always_ff @(posedge clk)
    begin
        n <= cols;
        synchronized_cols <= n;
    end

endmodule