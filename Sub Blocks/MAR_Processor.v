module MAR_Processor (
	input wire clk,clr,Lm_n,
	input wire [3:0] inAddr,
	output reg [3:0] outAddr);

	always@(posedge clk or negedge clr)
	begin
		if(!clr)
			begin
				outAddr <= 4'b0000;
			end
		else if(!Lm_n)
			begin
				outAddr <= inAddr;
			end
	end


endmodule