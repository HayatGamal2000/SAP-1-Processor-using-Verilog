module insReg( clk, LI_n, EI_n,clr,w,a ,b);
	input clk;
	input LI_n;
	input EI_n;
	input clr;
	input [7:0] w;
	output reg [3:0] a;
	output reg [3:0] b;

	

	always@(posedge clk or negedge clr)
		begin
			if (!clr)
				begin
					a<=4'b0;
					b<=4'b0;
				end
			else if(!LI_n)
				begin
					a <= w[3:0];
					b <= w[7:4];
				end
		end

endmodule