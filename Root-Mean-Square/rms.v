module rms(a,b,c,d,e,RMS);
  parameter width = 8;
  
  input [(width+1)/2-1:0] a,b,c,d,e;
  output [(width+1)/2-1:0] RMS;
  
  
  wire [width-1:0] squaredsum, mean;
  
  assign squaredsum = (a*a) + (b*b) + (c*c) + (d*d) + (e*e);
  
  
  
  div #(8,3) Divide (
    .numer(squaredsum),
    .denom(5), 
    .quot(mean),
    .rem()
  );
  
  sqrt #(8) Sqrt (
    .datain(mean),
    .root(RMS)
  );
endmodule
