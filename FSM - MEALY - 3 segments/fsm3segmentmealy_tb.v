// Code your testbench here
// or browse Examples
module tb();
  reg clk, rst, A;
  wire Z;
  wire [1:0] y;
  
  fsm3segmentmealy dut(clk,rst,A,Z,y);
  
  always begin
    #10 clk = ~clk;
  end
  
  initial begin
    $dumpvars(1);
    #0 clk = 0; rst = 0; A = 0;
    #15 rst = 1;
    @(posedge clk) A=1;
    @(posedge clk) A=0;
    @(posedge clk) A=1;
    @(posedge clk) A=0;
    @(posedge clk) A=1;
    @(posedge clk) A=1;
    @(posedge clk) A=1;
    @(posedge clk)
    #10 $finish;
  end
  
endmodule
