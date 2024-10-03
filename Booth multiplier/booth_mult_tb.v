// Code your testbench here
// or browse Examples
module tb();
  parameter N=4;
  reg [N-1:0] min,qin;
  reg clk,rst,start;
  wire done;
  wire [2*N-1:0] a;
  wire [2:0] S;
  
  booth_mult dut(min,qin,clk,rst,start,done,a,S);
  
  initial begin
    $dumpvars(1);
    #0 min=0; qin=0; clk=0; rst=1; start=0;
    #20 qin=6; min=-4; rst=0; // result = -24 or 0xe8
    #20 start=1;
    #20 start=0;
    #300 start=1; qin=-6; min=2; //result = -12 or 0xf4
    #20 start=0;
    #300 start=1; qin=-7; min=-2; //result = 14 or 0xe
    #20 start=0;
    #300 $finish;
  end
  
  
  always begin
    #10 clk = ~clk;
  end
  
endmodule

