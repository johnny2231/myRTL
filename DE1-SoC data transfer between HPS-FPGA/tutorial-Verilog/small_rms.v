module small_rms (clk,data,additioncheck, inputforsqrtcheck,rms, dataincheck);


parameter sample = 3;
parameter width_data=28;
parameter width_product = 56;
parameter width_add = 64;


input clk;
input [width_data-1:0] data;
output [width_add-1:0] additioncheck;
output [width_product-1:0] inputforsqrtcheck;
output [width_data-1:0] rms, dataincheck;


integer count;
wire [width_data - 1:0] b;
reg [width_add-1:0] c;
wire [width_product-1:0] product, e;
reg [width_product-1:0] d;

assign dataincheck = b;
assign additioncheck = c;
assign inputforsqrtcheck = d;
assign b = data;

always @(posedge clk)
begin
	
	c <= c + product;

	count <= count + 1;

	
	if (count == sample)
	begin
		count <= 0;
		c <= 0;
		d <= e;
	end
end
//



mult #(28, 28) Mult (

.A(b),
.B(b),
.TC(1'b1),
.PRODUCT(product)

);

//

div #(64, 15, 0, 0) Div (

.a(c),
.b(sample),
.quotient(e),
.remainder(),
.divide_by_0()

);
//

sqrt #(56, 0) Sqrt (

.a(d),
.root(rms)

);

//

endmodule

