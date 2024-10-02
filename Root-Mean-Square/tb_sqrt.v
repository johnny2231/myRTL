module tb();
  
  parameter width = 16;
  
  reg [width-1:0] datain;
  wire [(width+1)/2-1:0] root;
  
  sqrt sq(datain,root);
  
  initial begin
    $dumpvars(1);
    #0	datain=9;
    #20	datain=4;
    #20 datain=16;
    #20 datain=17;
    #20 datain=81;
    #20 datain=225;
    #20 datain=24;
    #20 $finish;
  end
  
endmodule
