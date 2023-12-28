module ringCounter (
	input clk,clr,
	output reg [5:0] T);
	
	always@(negedge clk or negedge clr)
		begin
			if(!clr)
				begin
					T <= 6'b000001;
				end
			else
				begin
					if(T == 6'b100000)
						T = 6'b000001;
					else
						T = T << 1;
				end
		end
	

endmodule