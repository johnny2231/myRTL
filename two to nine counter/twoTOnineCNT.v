module twoTOnineCNT(clk,rst,q);
  
  input clk, rst;
  output reg [3:0]q;
  
  initial begin
    q = 2;
    
  end
  
  
  always @(posedge clk, posedge rst)
  begin
    
    if (rst)
      q <= 2;
    
    else if (q == 9)
      q <= 2;
    
    else
      q <= q + 1;
    
  end
  
endmodule

