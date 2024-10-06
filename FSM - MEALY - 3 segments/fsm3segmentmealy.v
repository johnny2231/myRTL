// Code your design here
module fsm3segmentmealy(clk, rst, A,Z, y);
  
  parameter [1:0] s0=0,s1=1,s2=2,s3=3;
  
  input clk, rst, A;
  output Z;
  output reg [1:0] y;
  
  reg [1:0] Y;
  
  always @(posedge clk, negedge rst)
    begin
      if (!rst) begin
        y <= 0;
      end
      else begin
        y <= Y;
      end
    end
  
  always @(A,y)
    begin
      case (y)
        s0: if (A) Y = s3; else Y = s0;
        s1: if (A) Y = s0; else Y = s1;
        s2: if (A) Y = s1; else Y = s2;
        s3: if (A) Y = s1; else Y = s2;
      endcase
    end
  
  assign Z = ((y==s0) && A) || ((y==s1) && A);
  
endmodule
