module synchronizer_tb();
`timescale 1 ns / 1 ns

    logic       clk;
    logic [3:0] cols;
    logic [3:0] synchronized_cols, synchronized_cols_expected;
    logic [16:0] test_vectors[10000:0];
    logic [31:0] vectornum, errors;

    // Initialize dut
    synchronizer dut(
        .clk(clk),
        .cols(cols),
        .synchronized_cols(synchronized_cols)
    );

    initial begin
        $display("Reading test vectors");
        $readmemb("synchronizer_tv.txt", test_vectors);
        vectornum = 0;
        errors      = 0;

        reset  = 1;
        s1     = '0;
        s2     = '0;
        repeat (3) @(posedge clk);
        t1_prev  = t1;
        reset  = 0;
        @(posedge clk);
    end

    // Get next vector
    always @(posedge clk) begin
        #1;
        if (t1_prev !== t1) begin
            {s1, s2, t1_expected, t2_expected, seg_expected, led_expected} = test_vectors[vectornum];
        end
    end

    // Check outputs one half-cycle later, then advance
    always @(negedge clk) begin
        #1;
        if (t1_prev !== t1) begin
            if ({t1, t2, seg, led} !== {t1_expected, t2_expected, seg_expected, led_expected}) begin // check result
                $display("Error (test %0d): s1=%b s2=%b", vectornum, s1, s2);
                $display("  got     t1=%b t2=%b seg=%07b led=%05b",
                            t1, t2, seg, led);
                $display("  expect  t1=%b t2=%b seg=%07b led=%05b",
                            t1_expected, t2_expected, seg_expected, led);
                errors = errors + 1;
            end
            t1_prev = t1;
            vectornum = vectornum + 1;

            if (test_vectors[vectornum] === 22'bx) begin
                $display("%0d tests completed with %0d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule