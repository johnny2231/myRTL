// Code your testbench here
// or browse Examples

module tb();
  reg rst, clk;
  reg [1:0]sel;
  reg [2:0]in1,in2;
  wire [0:6]out;
  wire [3:0]a;
  
  M1 dut(rst,clk,sel,in1,in2,out,a);
  
  initial begin
    $dumpvars(1);
    #0 rst=1;clk=0;sel=3;in1=0;in2=0;
    #20 sel=0;
    #20 rst=0;in2=2;
    #20 sel=1;in1=5;
    #20 sel=2;in1=7;
    #20 sel=3;in1=0;in2=0;
    #20 sel=2;in2=7;in1=6;
    #40 $finish;
  end
    
  
  
  always begin
    #10 clk = ~clk;
  end
  
endmodule
