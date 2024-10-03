module tb;
  reg a,b,cin;
  wire s,cout;
  
  FA dut(cin,a,b,s,cout);
  
  initial begin
    $dumpvars(1);
    a=0;
    b=0;
    cin=0;
    #50
    
    a=0;
    b=1;
    cin=0;
    #50
    
    a=1;
    b=0;
    cin=0;
    #50
    
    a=1;
    b=1;
    cin=0;
    #50 
    
    a=0;
    b=0;
    cin=1;
    #50
    
    a=0;
    b=1;
    cin=1;
    #50
    
    a=1;
    b=0;
    cin=1;
    #50
    
    a=1;
    b=1;
    cin=1;
    #50$finish;
    
  end
  
endmodule

    
    
    
    
