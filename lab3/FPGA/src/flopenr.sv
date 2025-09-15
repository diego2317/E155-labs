module flopenr(
    input  logic clk,
    input  logic reset,
    input  logic en,
    input  logic [3:0] d,
    output logic [3:0] q);

    // asynchronous reset
    always_ff @(posedge clk, posedge reset) begin
        if (reset == 1) q <= 4'b0;
        else if (en == 1) q <= d;
    end

endmodule