module fsm (x,clk,rst,z,y);
  
  parameter [1:0] s0=0,s1=1,s2=2,s3=3;
  
  input x,clk,rst;
  reg [1:0] Y;
  output reg z;
  output reg [1:0]y;
  
  
  always @(posedge clk, negedge rst)
    begin
      if (!rst)
        begin
          y <= s0;
        end
      
      else
        begin
          y<=Y;
        end
      
    end
  
  
  always @(y,x)
    begin
      case (y)
        s0: begin Y = (x) ? s1 : s0; z=0; end
        s1: begin Y = (x) ? s2 : s0; z=0; end
        s2: begin Y = (x) ? s2 : s3; z=0; end
        s3: begin Y = (x) ? s1 : s0; z=1; end
      endcase
    end
endmodule

  
