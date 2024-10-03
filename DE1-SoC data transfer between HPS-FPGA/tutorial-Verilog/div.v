module div(a, b, quotient, remainder, divide_by_0);

parameter a_width  = 8;
parameter b_width  = 8;
parameter tc_mode  = 0;
parameter rem_mode = 1;

input  [a_width-1 : 0] a;
input  [b_width-1 : 0] b;
output [a_width-1 : 0] quotient;
output [b_width-1 : 0] remainder;
output 		 divide_by_0;

wire [a_width-1 : 0] a;
wire [b_width-1 : 0] b;
reg  [a_width-1 : 0] quotient;
reg  [b_width-1 : 0] remainder;
reg		       divide_by_0;
reg 		       b_x;

always @(a or b)
begin

	if (tc_mode == 0)
	begin
		quotient = DWF_div_uns (a, b);
		
		if (rem_mode == 1)
		begin
			remainder = DWF_rem_uns (a, b);
		end
		
		else
		begin
			remainder = DWF_mod_uns (a, b);
		end
	end
	
	if (b_x === 1'bx)
	begin
		divide_by_0 = 1'bx;
	end
	
	else if (b == {b_width{1'b0}})
	begin
		divide_by_0 = 1'b1;
	end
	
	else
	begin
		divide_by_0 = 1'b0;
	end
end
//


function [a_width-1 : 0] DWF_div_uns;
input [a_width-1 : 0] A;
input [b_width-1 : 0] B;

reg [a_width-1 : 0] QUOTIENT_v;
reg                 A_x, B_x;

begin
	A_x = ^A;
	B_x = ^B;
	
	if ((A_x === 1'bx) || (B_x === 1'bx))
	begin
		QUOTIENT_v = {a_width{1'bx}};
	end
	
	else
	begin
		if (B == 0)
		begin
			QUOTIENT_v = {a_width{1'b1}};
		end
		
		else
		begin
			QUOTIENT_v = A / B;
		end
		
		DWF_div_uns = QUOTIENT_v;
		
	end
end

endfunction
//


function [b_width-1 : 0] DWF_rem_uns;
input [a_width-1 : 0] A;
input [b_width-1 : 0] B;

reg [b_width-1 : 0] REMAINDER_v;
reg A_x, B_x;

begin
	A_x = ^A;
	B_x = ^B;
	
	if ((A_x === 1'bx) || (B_x === 1'bx))
	begin
		REMAINDER_v = {b_width{1'bx}};
	end
	
	else
	begin
		if (B == 0)
		begin
			REMAINDER_v = A;
		end
		
		else
		begin
			REMAINDER_v = A % B;
		end
		
		DWF_rem_uns = REMAINDER_v;
	end
end
endfunction
//

function [b_width-1 : 0] DWF_mod_uns;
input [a_width-1 : 0] A;
input [b_width-1 : 0] B;

reg [b_width-1 : 0] MODULUS_v;
reg A_x, B_x;

begin
	A_x = ^A;
	B_x = ^B;
	if ((A_x === 1'bx) || (B_x === 1'bx))
	begin
		MODULUS_v = {a_width{1'bx}};
	end
	
	else
	begin
		if (B == 0)
		begin
			MODULUS_v = A;
		end
		
		else
		begin
			MODULUS_v = A % B;
		end
		
		DWF_mod_uns = MODULUS_v;
	end
end
endfunction
//

endmodule
