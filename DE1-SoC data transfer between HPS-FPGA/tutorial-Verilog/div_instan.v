module div_instan(numer, denom, quot, rem);


parameter numer_w = 8;
parameter denom_w = 3;

input [numer_w-1:0] numer;
input [denom_w-1:0] denom;
output reg [numer_w-1:0] quot;
output reg [denom_w-1:0] rem;


reg [numer_w-1:0] numH;
reg [numer_w-denom_w-1:0] numL;
wire [numer_w-denom_w-1:0] quotH, quotL;
wire [denom_w-1:0] remH, remL;
reg [numer_w-1:0] remHnumL;


always @(numer or denom)
begin
	numH = {{numer_w-denom_w{1'b0}}, numer[numer_w-1:numer_w-denom_w]};
	numL = numer[numer_w-denom_w-1:0];
	remHnumL = {remH, numL};
	quot = {quotH[denom_w-1:0], quotL};
	rem = remL;
end
//

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

