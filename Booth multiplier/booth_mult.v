// Code your design here
module booth_mult(min,qin,clk,rst,start,done,a,S);
  parameter N=4;
  parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5;
  input [N-1:0] min,qin;
  input clk,rst,start;
  output reg done;
  output reg [2*N-1:0] a;  //output value
  reg qres;
  reg [N-1:0] q,m,temp;  // temp is the accumulator
  reg [2:0] state;
  reg [N-1:0] n;
  output [2:0] S;
  
  assign S = state;
  always @(posedge clk, posedge rst)
    begin
      if (rst)
        begin
          state <= s0;
        end
      
      else
        begin
          case (state)
            s0:
              begin
                if (start)
                  begin
                    n <= N;
                    m <= min;
                    q <= qin;
                    qres <= 0;
                    a <= 0;
                    temp <= 0;
                    state <= s1;
                    done <= 0;
                  end
                else
                  begin
                    state <= s0;
                  end
              end
            
            
            s1:
              begin
                if ({q[0],qres} == 2'b10)
                  begin
                    state <= s2;
                  end
                else if ({q[0],qres} == 2'b01)
                  begin
                    state <= s3;
                  end
                else if (({q[0],qres} == 2'b11) || ({q[0],qres} == 2'b00))
                  begin
                    state <= s4;
                  end
              end
            
            s2:
              begin
                temp <= temp - m;
                state <= s4;
              end
            
            s3:
              begin
                temp <= temp + m;
                state <= s4;
              end
            
            s4:
              begin
                temp <= (temp[N-1]==1) ? {1'b1,temp[N-1:1]} : {1'b0,temp[N-1:1]};
                q <= {temp[0],q[N-1:1]};
                qres <= q[0];
                n <= n - 1;
                state <= s5;
              end
            
            s5:
              begin
                if (n==0)
                  begin
                    state <= s0;
                    done <= 1;
                    a <= {temp,q};
                  end
                
                else
                  begin
                    state <= s1;
                  end
              end
            
          endcase
        end
    end
  
endmodule


            
       
            
