// sqrt
module sqrt(datain,root);
  parameter width = 8;
//   parameter tc_mode = 0;
  
  input [width-1:0] datain;
  output [(width+1)/2-1:0] root;
  
  assign root = sqrt_uns (datain);
  
  function [(width+1)/2-1:0] sqrt_uns;
    
    input [width-1:0] DATAIN;
    reg [(width+1)/2-1:0] ROOT;
    reg DATAIN_x;
    integer i;

    begin
      DATAIN_x = ^DATAIN;

      ROOT = {(width+1)/2{1'b0}};
      for (i=(width+1)/2-1; i>=0; i=i-1)
        begin
          ROOT[i] = 1'b1;
          if (ROOT*ROOT > {1'b0,DATAIN})
            begin
              ROOT[i] = 1'b0;
            end
        end
    end
    sqrt_uns = ROOT;
  endfunction
endmodule
