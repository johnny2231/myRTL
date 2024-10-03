// Code your design here
// Code your design here
module PGEN_V1 #(parameter Pwidth=6)(input clk, rst, start, stop, output reg [1:0] PS, output reg pulse);

  reg [3:0] CNT; // CNTnext; 
  //reg[1:0] NS; 

  parameter [1:0] IDLE=2'b01, DELAY=2'b10; // define STATE_REG: 

  //1 segment
  always @ (negedge rst, posedge clk) 
    begin
    if ( !rst)
      	  PS <= IDLE; 
       
	else      
    	case ( PS )
                  IDLE : begin 
                              pulse<= 0;
                              CNT<=0;
                              if (start) 
                                PS<= DELAY;
                              else
                                PS<=IDLE;
                  		end
                    
            
                  DELAY : begin 
                              pulse<= 1;
                              if (stop)
                               	 	PS<= IDLE;
                              else if (CNT==Pwidth-1)                               
                               begin
                                  	PS<=IDLE;
                                   	CNT<=CNT;
                               end
                    
                              else
                                begin
                                  PS<=DELAY;
                                  CNT<=CNT + 1;
                                end
                            end
                              
		endcase
    end
endmodule
