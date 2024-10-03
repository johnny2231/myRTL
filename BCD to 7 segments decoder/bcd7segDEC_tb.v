module tb;
  
  reg [3:0] bcd;
  wire [1:7] led;
  
  bcd7segDEC dut(bcd,led);
  
  
  initial begin
    bcd=0;
    $dumpvars(1);
    bcd = 0; #50
    bcd = 1; #50
    bcd = 2; #50
    bcd = 3; #50
    bcd = 4; #50
    bcd = 5; #50
    bcd = 6; #50
    bcd = 7; #50
    bcd = 8; #50
    bcd = 9; #50
    bcd = 10; #50 $finish;
  end
  
endmodule
