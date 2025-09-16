// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/15/2025

module keypad_reader_tb();
    logic clk, reset;
    logic [3:0] cols;
    logic [3:0] rows, rows_exp;
    logic [3:0] new_value, new_value_exp;
    logic [3:0] old_value, old_value_exp;
    logic [31:0] vectornum, errors;
    logic [15:0] testvectors[10000:0];

    // Instantiate DUT
    keypad_reader dut(
        .clk(clk),
        .reset(reset),
        .cols(cols),
        .rows(rows),
        .new_value(new_value),
        .old_value(old_value)
    );

    // Setup clock
    always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
    
    initial
        begin
            $readmemb("keypad_reader_tv.txt", testvectors);
            vectornum = 0; errors = 0;
            reset = 0; #22; reset = 1;
        end

    always @(posedge clk)
        begin
            #1; {cols, rows_exp, new_value_exp, old_value_exp} = testvectors[vectornum];
        end
    
    always @(negedge clk)
        if (reset) begin // skip during reset
            if (rows != rows_exp || new_value != new_value_exp || old_value != old_value_exp) begin // check result
                $display("Error: inputs = %b", cols);
                $display("Rows:  %b (%b expected)", rows, rows_exp);
                $display("New Value:  %b (%b expected)", new_value, new_value_exp);
                $display("Old Value:  %b (%b expected)", old_value, old_value_exp);
                $display("Test number: %d", vectornum);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 16'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
        end


endmodule