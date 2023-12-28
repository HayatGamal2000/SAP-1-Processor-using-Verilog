module PCunit(
	  input  CLK, CLR_n, Cp, Ep,zero_flag,j,
	  input [3:0] Jumb_In,
	  output tri [3:0] PC_out
	 );
	 
	
	reg [3:0] PC_Counter;
	
	not (not_EP, Ep);
	tribuf_4bit buf2(.in(PC_Counter), .out(PC_out), .low_enable(not_EP));
	 
	always @(posedge CLK or negedge CLR_n) 
		begin
			 if (!CLR_n) 
				begin
					PC_Counter <= 4'b0;
				end
			 else if(j&&zero_flag)
				begin
					PC_Counter <= Jumb_In;
				end
			 else if(Cp)
				begin
					PC_Counter <= PC_Counter+1;
				end
	    end
endmodule