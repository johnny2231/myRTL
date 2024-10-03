module tb();
  reg clk,rst,ctrlA,ctrlB,ldA,ldB,Psel,ldP;
  reg [3:0] dataA, dataB;
  wire b0,z;
  wire [7:0] P;
  
  du dut(clk,rst,ctrlA,ctrlB,ldA,ldB,Psel,ldP,dataA,dataB,b0,z,P);
  
  
  initial begin
    $dumpvars(1);
    #0 clk=0; rst=1; ctrlA=0; ctrlB=0; ldA=0; ldB=0; Psel=0; ldP=0; dataA=0; dataB=0;
    #20       rst=0; ctrlA=1; ctrlB=1; ldA=1; ldB=1; Psel=0; ldP=1; dataA=2; dataB=3;
    #20              ctrlA=1; ctrlB=1; ldA=1; ldB=1; Psel=1;        dataA=2; dataB=3;
    #20              ctrlA=0; ctrlB=1; ldA=1; ldB=1; Psel=1;        dataA=2; dataB=3;
    #20              ctrlA=1; ctrlB=1; ldA=1; ldB=1; Psel=1;        dataA=2; dataB=3;
    #20              ctrlA=1; ctrlB=0; ldA=1; ldB=1; Psel=1;        dataA=2; dataB=3;
    #20              ctrlA=1; ctrlB=0; ldA=1; ldB=1; Psel=1;        dataA=2; dataB=3;
    #20              ctrlA=1; ctrlB=1; ldA=1; ldB=1; Psel=1;        dataA=15; dataB=3;
    #80 $finish;
  end
  
  
  
  always begin
    #10 clk = ~clk;
  end
  
  
endmodule
