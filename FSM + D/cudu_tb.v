module tb();
  reg clk,rst,start;
  reg [3:0] xin,yin;
  wire done,idle,ready;
  wire [7:0] x,X;
  
  cudu dut(clk,rst,start,xin,yin,done,idle,ready,x,X);
  
  initial begin
    $dumpvars(1);
    #0  clk=0; rst=1; start=0; xin=0; yin=0;
    #20        rst=0;          xin=2; yin=15; // x = 0
    #20               start=1; 
    #60               start=0; // check idle set or not.
    #60                        xin=15; yin=2; //x = a
    #20               start=1;
    #80               start=0; xin=3; yin=15; //x = 2
    #20               start=1;
    #80 $finish;
    
  end
  
  
  always begin
    #10 clk = ~clk;
  end
  
endmodule
