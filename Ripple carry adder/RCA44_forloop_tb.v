module tb;
  reg [3:0]a,b;
  reg cin;
  wire [3:0]s;
  wire cout;
  integer i,j,k;
  
  RCA44 dut(cin, a,b, s,cout);
  
  initial begin
    i=0;
    j=0;
    k=0;
    a=0;
    b=0;
    cin=0;
    $monitor("t=%d, a=%d, b=%d, cin=%d, s=%d, cout=%d", $time, a,b,cin,s,cout);
    $dumpvars(1);
    for (k=0;k<2;k=k+1)
      begin
        cin=k;
        #10;
        
        for (i=0;i<16;i=i+1)
          begin
            a=i;
            #10;
            
            for (j=0;j<16;j=j+1)
              begin
                b=j;
                #10;
              end
          end
      end
//     for (i=0;i<16;i=i+1)
//       begin
//         a=i;
//         b=i;
//         cin=0;
//         #10;
//       end
    $finish;
    
//     $dumpvars(1);
//     a=9;
//     b=2;
//     cin=0;
//     for (i=0;i<2;i=i+1)
//       begin
//         j=i:
//       end
    
//     #50
    
//     a=10;
//     b=5;
//     cin=0;
//     #50
    
//     a=7;
//     b=9;
//     cin=0;
//     #50
    
//     a=1;
//     b=1;
//     cin=0;
//     #50 
    
//     a=0;
//     b=0;
//     cin=1;
//     #50
    
//     a=0;
//     b=1;
//     cin=1;
//     #50
    
//     a=9;
//     b=9;
//     cin=1;
//     #50
    
//     a=15;
//     b=15;
//     cin=1;
//     #50$finish;
    
  end
  
endmodule

    
    
    
    
