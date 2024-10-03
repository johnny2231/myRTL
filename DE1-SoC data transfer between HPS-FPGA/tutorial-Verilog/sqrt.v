module sqrt(a, root);

parameter width = 8;
parameter tc_mode = 0;

input [width-1:0] a;
output [(width+1)/2-1 : 0] root;


assign root = (tc_mode == 0)? DWF_sqrt_uns (a) : DWF_sqrt_tc (a);


function [(width+1)/2-1 : 0] DWF_sqrt_uns;

input [width-1 : 0] A;
reg [(width+1)/2-1 : 0] ROOT_v;
reg A_x;
integer i;

begin

	A_x = ^A;
	if (A_x == 1'bx)
	begin
	
		ROOT_v = {(width+1)/2{1'bx}};
		
	end
	
	else
	begin
	
		ROOT_v = {(width+1)/2{1'b0}};
		
		for (i=(width+1)/2-1; i>=0; i=i-1)
		begin
		
			ROOT_v[i] = 1'b1;
			if (ROOT_v * ROOT_v > {1'b0,A})
			begin
			
				ROOT_v[i] = 1'b0;
				
			end
			
		end
		
	end
	
	DWF_sqrt_uns = ROOT_v;
	
end

endfunction
//////////////////////////////////////////////////


function [(width+1)/2-1 : 0] DWF_sqrt_tc;

input [width-1 : 0] A;
reg [(width+1)/2-1 : 0] ROOT_v;
reg [width-1 : 0] A_x, A_v;
integer i;

begin

	A_x = ^A;
	if (A_x == 1'bx)
	begin
	
		ROOT_v = {(width+1)/2{1'bx}};
		
	end
	
	else
	begin
	
		if (A[width-1] == 1'b1)
		begin
		
			A_v = ~A + 1'b1;
			
		end
		
		else
		begin
			
			A_v = A;
			ROOT_v = DWF_sqrt_uns (A_v);
			
		end
		
	end
	
	DWF_sqrt_tc = ROOT_v;
end

endfunction

endmodule

