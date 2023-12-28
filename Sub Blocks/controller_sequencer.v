module controller_sequencer (
	input clk,clr_n,
	input [3:0] ins_in,
	output reg CP,EP,Lm_n,CE_n,LI_n,EI_n,LA_n,EA,LB_n,LO_n,HLT_E,j,
	output reg [2:0] Alu_Controller,
	output [5:0] T
	);

	wire [5:0]T_State;
	ringCounter R (.clk(clk),.clr(clr_n),.T(T));

	//assign T = T_State;
	always@(*)
		begin
			if(!clr_n)
				begin
					{CP,EP,Lm_n,CE_n,LI_n,EI_n,LA_n,EA,Alu_Controller,LB_n,LO_n,HLT_E,j} <= 15'b001111100001100;
				end
			else
				begin
					if(ins_in == 4'b1111)
						begin
							{CP,EP,Lm_n,CE_n,LI_n,EI_n,LA_n,EA,Alu_Controller,LB_n,LO_n,HLT_E,j} <= 15'b001111100001110;
						end
					else
						begin
							{CP,EP,Lm_n,CE_n,LI_n,EI_n,LA_n,EA,Alu_Controller,LB_n,LO_n,HLT_E,j} <= 15'b001111100001100;
							case(T)
								6'b000001: {EP,Lm_n} <= 2'b10;
								6'b000010: CP <= 1'b1;
								6'b000100: {CE_n,LI_n} <= 2'b00;
								6'b001000:  begin
												    case(ins_in)
														4'b0000: {Lm_n,EI_n} <= 2'b00;
														4'b0001: {Lm_n,EI_n} <= 2'b00;
														4'b0010: {Lm_n,EI_n} <= 2'b00;
														4'b0011: {Lm_n,EI_n} <= 2'b00;
														4'b0100: {Lm_n,EI_n} <= 2'b00;
														4'b0110: {Lm_n,EI_n} <= 2'b00;
														4'b0111: {Lm_n,EI_n} <= 2'b00;
														4'b1000: {Lm_n,EI_n} <= 2'b00;	
														4'b0101: {EI_n,j}    <= 2'b01;
														4'b1110: {EA,LO_n}   <= 2'b10;	
													endcase
											end
								6'b010000: begin
													casez(ins_in)
														4'b00??: {CE_n,LB_n} <= 2'b00; //ALU Operations
														4'b0110: {CE_n,LB_n} <= 2'b00;
														4'b0111: {CE_n,LB_n} <= 2'b00;
														4'b1000: {CE_n,LB_n} <= 2'b00;
														4'b0100: {CE_n,LA_n} <= 2'b00;
													endcase
												end
								6'b100000: begin
													case(ins_in)
														4'b0000: {Alu_Controller,LA_n} <= 4'b0010; 		//ADD
														4'b0001: {Alu_Controller,LA_n} <= 4'b0100;		//SUB
														4'b0010: {Alu_Controller,LA_n} <= 4'b0110;		//MUL
														4'b0011: {Alu_Controller,LA_n} <= 4'b1000;		//DIV
														4'b0100: {Alu_Controller,LA_n} <= 4'b0001;		//LOAD
														4'b0110: {Alu_Controller,LA_n} <= 4'b1010;		//AND
														4'b0111: {Alu_Controller,LA_n} <= 4'b1100;		//OR
														4'b1000: {Alu_Controller,LA_n} <= 4'b1110;		//XOR
													endcase
												end

							endcase
					end

				
				end
		end

endmodule