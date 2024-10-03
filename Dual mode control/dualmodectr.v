//test 1 part 2 Q2 - Ong Chun Foong

module dualmodectr (mode, clk, reset, Q, TC);
  input mode, clk, reset;
  output reg TC;
  output reg [3:0] Q;
  
  
  always @(posedge clk, negedge reset)
    begin
      
      TC <= 0;
      
      if(!reset)  // asynchronous means when reset = 0, straight away clear TC and Q regardless of clock edge.
        begin
          TC <= 0;
          Q <= 0;
        end
      
      else if (mode == 0)
        begin
          
          if (Q < 14)
            begin
              Q <= Q + 1;
            end
          else if (Q == 14)  // "during" the last value, i understand it as reaching exactly 0xf, it will set TC at the same clock, and reset both TC and Q at the next clock
            begin
              TC <= 1;
              Q <=Q+1;
            end
          else if (Q >= 15)
            begin
              Q <= 0;
            end
        end
      
      else if (mode == 1)
        begin
          
          if (Q < 8)
            begin
              Q <= Q + 1;
            end
          else if (Q == 8)  // "during" the last value, i understand it as reaching exactly 0x9, it will set TC at the same clock, and reset both TC and Q at the next clock
            begin
              TC <= 1;
              Q <= Q+1;
            end
          else if (Q >= 9)
            begin
              Q <= 0;
            end
        end
    end
endmodule

      
