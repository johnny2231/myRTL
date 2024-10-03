//test 1 part 2 Q1 - Ong Chun Foong

module sorter (A,B,max,min);
  input [3:0] A,B;
  output reg [3:0] max,min;
  
  always @(A,B)
    begin
      if (A>B)
        begin
          max = A;
          min = B;
        end
      else if (A<B)
        begin
          max = B;
          min = A;
        end
      else
        begin    // if both equal
          max = 0;
          min = 0;
        end 
      
    end
endmodule
