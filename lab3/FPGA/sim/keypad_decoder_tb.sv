// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/15/2025

module keypad_decoder_tb();
    logic clk, reset;
    logic [3:0] rows, cols;
    logic [3:0] key, key_expected;

    logic [31:0] vectornum, errors;
    logic [12:0] testvectors[10000:0];

    // Instantiate DUT
    keypad_decoder dut(rows, cols, key);

    // Setup clock
    always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
    
    initial
        begin
            $readmemb("keypad_decoder_tv.txt", testvectors);
            vectornum = 0; errors = 0;
            reset = 0; #22; reset = 1;
        end

    always @(posedge clk)
        begin
            #1; {cols, rows, key_expected} = testvectors[vectornum];
        end
    
    always @(negedge clk)
        if (reset) begin // skip during reset
            if (key != key_expected) begin // check result
                $display("Error: inputs = %b", {rows, cols});
                $display(" Output = %b (%b expected)", key, key_expected);
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 13'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
        end


endmodule