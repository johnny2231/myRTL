// Code your testbench here
// or browse Examples
module tb();
  reg [7:0]in;
  wire [7:0] out;
  
  reversebits dut(in,out);
  
  always begin
    $dumpvars(1);
    #0 in = 0;
    #20 in = 8'b11100101;
    #20 in = 8'b10001001;
    #20 $finish;
  end
endmodule
