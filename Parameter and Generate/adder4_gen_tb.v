module tb;
  parameter n=4;
  reg [n-1:0]a,b;
  reg cin;
  wire [n:0]s;
  integer i;

  
  adder4_gen #(n) dut(cin, a,b, s);
  
  initial begin
    i=0;
    a=0;
    b=0;
    cin=0;

    
    $dumpvars(1);
    #20 a=0; b=15;
    #20 a=15; b=0;
    #20 a=15; b=15;
    
    #40 cin =1; a=0; b=15;
    #20 a=15; b=0;
    #20 a=15; b=15;
    
    #60 $finish;
  end
  
  always begin
    for (i=0; i<16; i=i+1)
      begin
        #20 
        a = $urandom_range(0,15);
        b = $urandom_range(0,15);
      end
    

    
  end
  
endmodule

    
    
    
    
