// Author: Diego Weiss
// Email: dweiss@hmc.edu
// Date: 9/15/2025

module keypad_input_tb();
    logic clk, reset;
    logic press, press_exp;
    logic [3:0] cols;
    logic [3:0] rows, rows_exp;

    logic [31:0] vectornum, errors;
    logic [8:0] testvectors[10000:0];

    // Instantiate DUT
    keypad_input dut(
        .clk(clk),
        .reset(reset),
        .cols(cols),
        .rows(rows),
        .press(press)
    );

    // Setup clock
    always 
		begin
			clk = 1; #5; clk = 0; #5;
		end
    
    initial
        begin
            $readmemb("keypad_input_tv.txt", testvectors);
            vectornum = 0; errors = 0;
            reset = 0; #22; reset = 1;
        end

    always @(posedge clk)
        begin
            #1; {cols, rows_exp, press_exp} = testvectors[vectornum];
        end
    
    always @(negedge clk)
        if (reset) begin // skip during reset
            if (rows != rows_exp || press != press_exp) begin // check result
                $display("Error: inputs = %b", cols);
                $display("Rows:  %b (%b expected)", rows, rows_exp);
                $display("Press:  %b (%b expected)", press, press_exp);
                $display("Test number: %d", vectornum);
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 9'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
        end


endmodule