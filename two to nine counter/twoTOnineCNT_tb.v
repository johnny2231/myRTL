module tb;
  reg clk, rst;
  wire [3:0] q;
  
  twoTOnineCNT dut(clk,rst,q);
  
  initial begin
    rst=0;
    clk=0;
    
    $dumpvars(1);
    #175 rst = 1;
    #20 rst = 0;
    #200 $finish;
  end
  
  always #10 clk = ~clk;
  
endmodule
