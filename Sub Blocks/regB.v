module regB (clr, clk, D, Q,LB_n);
input clr;
input clk,LB_n;
input [7:0] D;
output reg [7:0] Q;

always @(posedge clk or negedge clr)
begin
	if (!clr)
		Q <= 0;
	else if(!LB_n)
		Q <= D;
end
endmodule