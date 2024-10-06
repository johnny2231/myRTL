// Code your design here
// FSM 3 segment coding

module FSM3segment(clk,rst,A,Z,y);
  
  parameter [1:0] s0=0, s1=1, s2=2, s3=3;
  
  input clk, rst, A;
  output Z;
  output reg [1:0] y;
  
  reg [1:0] Y;

  
  // next state logic
  always @(A,y)
    begin
      case (y)
        s0: if(A) Y = s1; else Y = s0;
        s1: if(A) Y = s3; else Y = s2;
        s2: if(A) Y = s3; else Y = s2;
        s3: if(A) Y = s0; else Y = s3;
      endcase
    end
  
  
  // state register
  always @(posedge clk, posedge rst)
    begin
      if (rst) begin
        y <= s0;
      end
      else begin
        y <= Y;
      end
    end
  
  
  
  // output register
  assign Z = (y == s0) || (y == s3);
  
endmodule
