//FSMD

module fsmd (start,clk,rst,xin,yin,done,idle,ready,x,X);
  input start,clk,rst;
  input [3:0] xin,yin;
  output reg done,idle,ready;
  output reg [7:0]x,X;
  
  reg [1:0] state;
  reg [7:0] y,z;
  
  parameter [1:0] s1=0,s2=1,s3=2,s4=3;
  

  always @ (posedge clk, posedge rst)
    begin
      if(rst)
        begin
          state <= s1;
        end
      
      else
        begin
          case (state)
            s1: begin if (start) begin done<=0; idle<=0; ready<=0; state <= s2; x <= xin; y <= yin; z <= xin*xin; end
                      else begin idle <= 1; state <= s1; end
                end
            s2: begin y <= y/3; state <= s3; end
            s3: begin y <= y/z; state <= s4; end
            s4: begin x <= (x<<1)/3 - y; done <= 1; ready <= 1; state <=s1; end
            default: state <= s1;
          endcase
        end
    end
  
  always @(posedge ready)
    begin
      if (ready)
        begin
          X <= x;
        end
      else
        begin
          X <= 0;
        end
      
    end
  
endmodule
