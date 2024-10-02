// div
// div
// div
module div(numer, denom, quot, rem);
  parameter numer_w = 8;
  parameter denom_w = 4;

  input [numer_w-1:0] numer;
  input [denom_w-1:0] denom;
  output reg [numer_w-1:0] quot;
  output reg [denom_w-1:0] rem;
  
  wire [numer_w-1:0] numH;
  wire [numer_w-denom_w-1:0] numL;
  wire [numer_w-denom_w-1:0] quotH, quotL;
  wire [denom_w-1:0] remH, remL;
  wire [numer_w-1:0] remHnumL;
  
  assign numH = {{numer_w-denom_w{1'b0}}, numer[numer_w-1:numer_w-denom_w]}; // numH = 0000_numer[7:4]
  assign numL = numer[numer_w-denom_w-1:0]; //numL = numer[3:0]
  assign remHnumL = {remH, numL};
  assign quot = {quotH[denom_w-1:0], quotL};
  assign rem = remL;
  
//   always @(numer or denom)
//     begin
//       numH = {{numer_w-denom_w{1'b0}}, numer[numer_w-1:numer_w-denom_w]}; // numH = 0000_numer[7:4]
//       numL = numer[numer_w-denom_w-1:0]; //numL = numer[3:0]
//       remHnumL = {remH, numL};
//       quot = {quotH[denom_w-1:0], quotL};
//       rem = remL;
//     end
  
  thediv #(numer_w, denom_w) theDiv (
    .a(numH), 
    .b(denom), 
    .quo(quotH), 
    .rem(remH)
    );
  thediv #(numer_w, denom_w) theDivtwo (
    .a(remHnumL), 
    .b(denom), 
    .quo(quotL), 
    .rem(remL)
  );

endmodule


// thediv
// thediv
// thediv
module thediv(a, b, quo, rem);
  parameter a_width = 8;
  parameter b_width = 4;
  
  input  [a_width-1 : 0] a;
  input  [b_width-1 : 0] b;
  output [a_width - b_width -1: 0] quo;
  output [a_width - b_width -1: 0] rem;

  integer i;
  
  reg [a_width - b_width -1: 0] rem;
  reg [a_width - b_width -1: 0] quo;



  always @(a or b)
  begin
      quo = div_uns (a, b);
      rem = rem_uns (a, b);
  end
  
  function [a_width - b_width -1: 0] div_uns;
    

    input  [a_width-1 : 0] A;
    input  [b_width-1 : 0] B;

    reg [a_width - b_width -1: 0] QUOTIENT_v;
    reg [b_width-1 : 0] REMAINDER_v;
    reg                 A_x, B_x;

    reg [b_width : 0] n1;
    reg [a_width - b_width -1: 0] n2;

    begin
        A_x = ^A;
        B_x = ^B;

        if ((A_x === 1'bx) || (B_x === 1'bx))
        begin
            QUOTIENT_v = {a_width - b_width -1{1'bx}};
        end

        else
        begin
            if (B==0)
            begin
                QUOTIENT_v = 0;
            end

            else
            begin
                n1 = {1'b0, A[a_width-1 : a_width - b_width]};
                n2 = A[a_width - b_width-1 : 0];

                for(i=0; i<a_width-b_width; i=i+1)
                begin
                    n1 = {n1[b_width - 1:0], n2[a_width - b_width -1]};
                    n2 = n2 << 1;

                    if (n1 >= B)
                    begin
                        n1 = n1 - B;
                        n2[0] = 1'b1;
                    end
                end
            end
            QUOTIENT_v = n2;
            REMAINDER_v = n1[b_width - 1:0];
        end
        div_uns = QUOTIENT_v;
    end
  endfunction
  
    //	


  function [a_width - b_width -1: 0] rem_uns;
    
    input  [a_width-1 : 0] A;
    input  [b_width-1 : 0] B;

    reg [a_width - b_width -1: 0] QUOTIENT_v;
    reg [b_width-1 : 0] REMAINDER_v;
    reg                 A_x, B_x;

    reg [b_width : 0] n1;
    reg [a_width - b_width -1: 0] n2;

    begin
        A_x = ^A;
        B_x = ^B;

        if ((A_x === 1'bx) || (B_x === 1'bx))
        begin
            QUOTIENT_v = {a_width - b_width -1{1'bx}};
        end

        else
        begin
            if (B==0)
            begin
                QUOTIENT_v = 0;
            end

            else
            begin
                n1 = {1'b0, A[a_width-1 : a_width - b_width]};
                n2 = A[a_width - b_width-1 : 0];

                for(i=0; i<a_width-b_width; i=i+1)
                begin
                    n1 = {n1[b_width - 1:0], n2[a_width - b_width -1]};
                    n2 = n2 << 1;

                    if (n1 >= B)
                    begin
                        n1 = n1 - B;
                        n2[0] = 1'b1;
                    end
                end
            end
            QUOTIENT_v = n2;
            REMAINDER_v = n1[b_width - 1:0];
        end
        rem_uns = REMAINDER_v;
    end
  endfunction
  
    ///

endmodule
