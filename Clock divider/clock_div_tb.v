module tb();
  reg clk, rst;
  wire clk1M, clk100k,clk100kreal;
  
  clock_div dut(clk, rst, clk1M, clk100k, clk100kreal);
  
  initial begin
    $dumpvars(1);
    #0 rst=0;	clk=0;
    #10 rst=1;
    #50000 $finish;
  end
//
  
  always begin
    #10 clk = ~clk;
  end
  
endmodule

// module tb50();
//   reg clk, rst;
//   wire q;
  
//   divby50 dv50(clk, rst, q);
 
//   initial begin
//     $dumpvars(1);
//     #0 rst=0;	clk=0;
//     #20 rst=1;
//     #2000 $finish;
//   end

//   always begin
//     #10 clk = ~clk;
//   end
  
// endmodule
