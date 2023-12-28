module ALU_Processor (
	input [7:0] A,B,
	input [2:0] AluController,
	output reg [7:0] aluOut);

	
	
	
	always@(*)
		begin
			case(AluController)
				3'b000: aluOut= aluOut;
				3'b001: aluOut= A+B;
				3'b010: aluOut= A-B;
				3'b011: aluOut= A*B;
				3'b100: aluOut= A/B;
				3'b101: aluOut= A&B;
				3'b110: aluOut= A|B;
				3'b111: aluOut= A^B;
				default: aluOut= 0;
			endcase
	
		end

endmodule
