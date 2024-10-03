module tb;
  
  
  reg x,clk,rst;
  wire z;
  wire [1:0] y;
  
  fsm #(0,1,2,3) dut (x,clk,rst,z,y);
  
  initial begin
    $monitor ($time, " x=%d, clk=%d, rst=%d, y=%d, z=%d", x,clk,rst,y,z);
  end
  
  
  initial begin
    clk=0;
    forever #10 clk = ~clk;
  end
  
  
  initial begin
    $dumpvars(1);
    #0 rst=0;
    #20 rst=1; x=0;
    
    #20 x=1;
    #20 x=1;
    #20 x=0;  //z=1
    #20 x=0;
    #20 x=0;
    #20 x=1;
    #20 x=1;
    #20 x=1;
    #20 x=0;  //z=1
    #20 x=1;
    #20 x=0;
    #20 x=1;
    #20 x=1;
    #20 x=0;  //z=1
    
    #20 $finish;
    
  end
  
endmodule
