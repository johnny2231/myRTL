module tb;
  reg mode, clk, reset;
  wire [3:0] Q;
  wire TC;
  
  dualmodectr dut ( mode, clk, reset, Q, TC );
  
  initial begin clk = 1'b0; forever #10 clk = ~clk; end 

  initial begin     
    $dumpvars(1);
    #0    reset = 0;
    #20   reset = 1;
    #540  reset = 0;
    #20   reset = 1;
    #40   $finish;
  end 

  initial begin
    #0    mode = 0;
    #360  mode = 1;
  end 
  
endmodule
