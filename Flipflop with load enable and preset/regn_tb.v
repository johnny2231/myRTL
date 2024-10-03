// Code your testbench here
// or browse Examples
module tb();
  parameter n=8;
  reg clk,rst,pst,en;
  reg [n-1:0] d;
  wire [n-1:0] q;
  
  regn #(n) dut(clk,rst,pst,en,d,q);
  
  
  initial begin
    $dumpvars(1);
    #0 clk=0; rst=0; pst=0;en=0;
    #20 rst=1;pst=1;
    #20 pst=0;en=1;d=3;
    #20 en=0;d=10;
    #20 en=1;
    #20 $finish;
  end
  
  
  
  always begin
    #10 clk = ~clk;
  end
  
  
endmodule
