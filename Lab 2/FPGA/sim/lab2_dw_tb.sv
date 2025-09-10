// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test top level module for E155 Lab 2
module lab2_dw_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
  logic        clk = 0;
  logic        reset;          
  logic [3:0]  s1, s2;
  logic        t1, t2;
  logic [4:0]  led;
  logic [6:0]  seg;
  logic        t1_expected;
  logic        t2_expected;
  logic [4:0]  led_expected;
  logic [6:0]  seg_expected;
  logic [21:0] test_vectors[10000:0];
  logic [31:0] vectornum, errors;

  // instantiate dut
  lab2_dw dut (
    .reset(reset),
    .s1   (s1),
    .s2   (s2),
    .t1   (t1),
    .t2   (t2),
    .seg  (seg),
	.led  (led)
  );

  localparam real CLK_PERIOD_NS = 1000.0 / 24.0;  // 24 MHz Clock
  always #(CLK_PERIOD_NS/2.0) clk = ~clk;

  logic t1_prev;

  

  initial begin
    $display("Reading test vectors");
    $readmemb("lab2_dw_tv.txt", test_vectors);
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
