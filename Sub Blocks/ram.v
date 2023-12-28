module ram (
    input CE_n,
    input [3:0]address,
    output reg [7:0]data_out
);

	reg [7:0] ram_block [15:0];
	
	initial begin
		//$readmemh("Program_Machine_Code.txt",ram_block,0,15);
		ram_block[0]=  8'h4A;
		ram_block[1]=  8'h6B;
		ram_block[2]=  8'h7C;
		ram_block[3]=  8'h6D;
		ram_block[4]=  8'h8E;
		ram_block[5]=  8'hE0;
		ram_block[6]=  8'hF0;
		ram_block[7]=  8'hFF;
		ram_block[8]=  8'hFF;
		ram_block[9]=  8'hFF;
		ram_block[10]= 8'h01;
		ram_block[11]= 8'h02;
		ram_block[12]= 8'h03;
		ram_block[13]= 8'h02;
		ram_block[14]= 8'h05;
		ram_block[15]= 8'hFF;
	
	end

	always@(*)
		begin
			if(CE_n)
				begin
					data_out = 8'bzzzzzzzz;
				end
			else
				begin
					data_out = ram_block[address];
				end
		end

endmodule