module Accumulator(
	 input wire CLK, LA_n, EA,
	 input wire [7:0] A_BUS_IN,
	 output reg [7:0] A_BUS_OUT,
	 output reg Zero
	);
	

	
	always @(posedge CLK) 
		begin
			if(!LA_n)
				begin
					A_BUS_OUT <= A_BUS_IN;  
				end
			Zero = ~|(A_BUS_OUT);
		end
endmodule