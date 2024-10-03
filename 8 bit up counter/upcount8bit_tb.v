module tb;
  reg clk,rst,ld,inc;
  reg [7:0] data;
  wire [7:0] q;
  
  upcount8bit dut(clk,rst,ld,inc,data,q);
  
  initial begin
    clk=0;
    rst=0;
    data=0;
    inc=0;
    ld=0;
    forever #20 clk = ~clk;
  end
    
  initial begin
    $dumpvars(1);
    rst=1;
    data=5;
    ld=1; #20  // load 5 to counter
    
    ld=0;
    inc=1; #100 // begin count
    
    rst=0; #40 // reset
    
    rst=1;
    data= 250;
    ld=1; #100  // load 250, at here the inc=1 as well, the design should take ld=1 instead of inc=1
    
    ld=0; #40 // disable load, perform increment
    
    inc=0; #40 // q<=q
    
    inc=1; #300 $finish; // see how the counter react when count after 0xff
    
  end
  
endmodule

    
    
