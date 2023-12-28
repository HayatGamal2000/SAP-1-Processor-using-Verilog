module Top_Module (
	input clk,clr,
	output [7:0] topOUT);
	
	wire CLK_I,CLKn_I;
	wire CP,EP,Lm_n,CE_n,LI_n,EI_n,LA_n,EA,LB_n,LO_n,HLT_E;
	wire [2:0] Alu_Controller;
	wire [3:0] MAR_out,INSR_A,INSR_B;
	wire [7:0] RB_out,ACC_OUT;
	wire [5:0] T;
	wire HLTn_E,j,Z_flag;
	wire [7:0] bus;
	wire [7:0] alu_Out;

	
	
	controller_sequencer CS(.clk(clk),.clr_n(clr),.ins_in(INSR_B),.CP(CP),.EP(EP),.Lm_n(Lm_n),.CE_n(CE_n),
	.LI_n(LI_n),.EI_n(EI_n),.LA_n(LA_n),.EA(EA),.LB_n(LB_n),.LO_n(LO_n),.HLT_E(HLT_E),.j(j),.Alu_Controller(Alu_Controller),.T(T));

	// Clock buffer
	
	not g0(HLTn_E,HLT_E); 
    bufif1 g1(CLK_I,clk,HLTn_E);
	assign CLKn_I = ~CLK_I;

	PCunit PC(.CLK(CLK_I), .CLR_n(clr), .Cp(CP), .Ep(EP),.PC_out(bus[3:0]),.zero_flag(Z_flag),.j(j),.Jumb_In(bus[3:0]));
	
	//tribuf_4bit buf2(.in(PC_out), .out(Bus[3:0]), .low_enable(EP));
	
	MAR_Processor MAR(.clk(CLK_I),.clr(clr),.Lm_n(Lm_n),.inAddr(bus[3:0]),.outAddr(MAR_out));
	
	ram RAM(.CE_n(CE_n),.address(MAR_out),.data_out(bus));
	
	insReg INSREG(.clk(CLK_I),.LI_n(LI_n),.EI_n(EI_n),.clr(clr),.w(bus),.a(INSR_A),.b(INSR_B));
	
		tribuf_4bit bufb (.in(INSR_A), .out(bus[3:0]), .low_enable(EI_n));
	
	//tribuf_4bit buf0(.in(INSR_B), .out(Bus[3:0]), .low_enable(EI_n));
    	
	
	Accumulator A(.CLK(CLK_I),.LA_n(LA_n),.EA(EA),.A_BUS_IN(bus),.A_BUS_OUT(ACC_OUT),.Zero(Z_flag));
	not (not_EA,EA);
	tribuf_8bit AccBuf(.in(ACC_OUT), .out(bus), .low_enable(not_EA));

	
	wire aluOut_en;
	assign aluOut_en = (Alu_Controller != 000 )? 0 : 1;
	ALU_Processor Alu(.A(ACC_OUT),.B(RB_out),.AluController(Alu_Controller),.aluOut(alu_Out));
	tribuf_8bit AluBuf(.in(alu_Out), .out(bus), .low_enable(aluOut_en));
	
	
	regB RB(.clr(clr), .clk(CLK_I), .D(bus), .Q(RB_out),.LB_n(LB_n));
	
	out OUT(.L_o(LO_n),.clk(CLK_I),.t(bus),.g(topOUT));
	

endmodule