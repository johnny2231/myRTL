module tb;
  reg a,b;
  wire s,c;
  
  HA dut(a,b,s,c);
  
  initial begin
    $dumpvars(1);
    a=0;
    b=0;
    #50
    
    a=0;
    b=1;
    #50
    
    a=1;
    b=0;
    #50
    
    a=1;
    b=1;
    #50 $finish;
    
  end
  
endmodule

    
    
    
    
