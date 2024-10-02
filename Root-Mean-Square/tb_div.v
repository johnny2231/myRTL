module tb();
  
  parameter numer_w = 8;
  parameter denom_w = 4;

  reg [numer_w-1:0] numer;
  reg [denom_w-1:0] denom;
  wire [numer_w-1:0] quot;
  wire [denom_w-1:0] rem;
  
  div dd(numer, denom, quot, rem);
  
  initial begin
    $dumpvars(1);
    #0	numer=100;	denom=5; //0110 0100, 0101
    // numH = 0000 0110
    // numL = 0100
    // quotH = 0001
    // remH = 0001
    
    // remHnumL = 0001 0100
    
    // quotL = 0100
    // remL = 0000
    
    // so quot = 0001 0100 = 20
    // rem = 0000
    
    #20	numer=200;	denom=4; //1100 1000, 0100
    #20 $finish;
  end
endmodule
