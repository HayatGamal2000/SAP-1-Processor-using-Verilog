module out(L_o,clk,t,g);
	input L_o; 
	input clk; 
	input [7:0] t;
	output reg [7:0] g; 
	always @(posedge clk)
		begin
			if (L_o==0)
				begin
					g<=t;
				end
		  else 
				begin
					g<=g; 
				end 
		end 
endmodule