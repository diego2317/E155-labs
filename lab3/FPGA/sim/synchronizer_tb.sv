module synchronizer_tb();
`timescale 1 ns / 1 ns

    logic       clk;
    logic       reset;
    logic [3:0] cols;
    logic [3:0] synchronized_cols, synchronized_cols_expected;
    logic [7:0] test_vectors[10000:0];
    logic [31:0] vectornum, errors;

    // Initialize dut
    synchronizer dut(
        .clk(clk),
        .reset(reset),
        .cols(cols),
        .synchronized_cols(synchronized_cols)
    );

    always 
		begin
			clk = 1; #5; clk = 0; #5;
		end

    initial begin
        $display("Reading test vectors");
        $readmemb("synchronizer_tv.txt", test_vectors);
        vectornum = 0;
        errors      = 0;

        reset  = 0;
        repeat (2) @(posedge clk);
        reset  = 1;
        @(posedge clk);
    end

    // Get next vector
    always @(posedge clk) begin
        #1;
        {cols, synchronized_cols_expected} = test_vectors[vectornum];
    end

    // Check outputs one half-cycle later, then advance
    always @(negedge clk) begin
        #1;
        if (synchronized_cols != synchronized_cols_expected) begin // check result
            $display("Error (test %0d): synchronized_cols = %b", vectornum, synchronized_cols);
            $display("Expected:  synchronized_cols = %b", synchronized_cols_expected);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;

        if (test_vectors[vectornum] === 8'bx) begin
            $display("%0d tests completed with %0d errors", vectornum, errors);
            $finish;
        end
    end


endmodule