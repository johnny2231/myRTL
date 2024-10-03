module the_cnt (indicator, thereset, c);

input indicator, thereset;
//input [15:0] a;
output reg [15:0] c;

always @(negedge indicator)
begin
	if (thereset)
	begin
		c <= 0;
	end
	
	else
	begin
		c <= c + 1;
	end
end
endmodule
//

	