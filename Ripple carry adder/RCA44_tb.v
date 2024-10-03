module tb;
  reg [3:0]a,b;
  reg cin;
  wire [3:0]s;
  wire cout;
  
  RCA44 dut(cin, a,b, s, cout);
  
  initial begin
    $dumpvars(1);
    a=9;
    b=2;
    cin=0;
    #50
    
    a=10;
    b=5;
    cin=0;
    #50
    
    a=7;
    b=9;
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
    
    a=9;
    b=9;
    cin=1;
    #50
    
    a=15;
    b=15;
    cin=1;
    #50$finish;
    
  end
  
endmodule

    
    
    
    
