// Author: Diego Weiss
// Email: dweiss@g.hmc.edu
// Date: 9/1/25
// Module to test 7 segment display controller
module display_controller_tb();
// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns
  logic        clk;
  logic        reset;          
  logic [3:0]  s1, s2;
  logic         t1, t2;
  logic [6:0]   seg;
  logic        t1_expected;
  logic        t2_expected;
  logic [6:0]  seg_expected;
  logic [16:0] test_vectors[10000:0];
  int   test_counter;
  int   errors;

  // instantiate dut
  display_controller dut (
    .clk  (clk),
    .reset(reset),
    .s1   (s1),
    .s2   (s2),
    .t1   (t1),
    .t2   (t2),
    .seg  (seg)
  );


  // 
  initial clk = 0;
  always #5 clk = ~clk;  

  logic t1_prev;
  

  

  initial begin
    $display("Reading test vectors");
    $readmemb("display_controller_tv.txt", test_vectors);
    test_counter = 0;
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
      {s1, s2, t1_expected, t2_expected, seg_expected} = test_vectors[test_counter];
    end
  end

  // Check outputs one half-cycle later, then advance
  always @(negedge clk) begin
    #1;
    if (t1_prev !== t1) begin
      if ({t1, t2, seg} !== {t1_expected, t2_expected, seg_expected}) begin
        $display("Error (test %0d): s1=%b s2=%b", test_counter, s1, s2);
        $display("  got     t1=%b t2=%b seg=%07b",
                 t1, t2, seg);
        $display("  expect  t1=%b t2=%b seg=%07b",
                 t1_expected, t2_expected, seg_expected);
        errors++;
      end
      t1_prev = t1;
      test_counter++;

      if (test_vectors[test_counter] === 17'bx) begin
        $display("%0d tests completed with %0d errors", test_counter, errors);
        $finish;
      end
    end
  end

endmodule
