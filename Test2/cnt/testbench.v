`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 10;

reg         clk;
reg 		reset; 
reg 		mode;
wire [7:0]  cnt;

bin_counter bc_inst(.i_clk(clk), 
                    .i_rst(reset), 
                    .i_mode(mode), 
                    .o_cnt(cnt)
                    );

initial begin
#0	
	clk = 0;
	forever	#(PERIOD/2)	clk = ~clk;
end

initial begin
#0
	reset = 1'b1;
	mode = 1'b0;
	
#10
	reset = 1'b0;
	
#250
	mode = 1'b1;

#300
	reset = 1'b1;

#10 
	reset = 1'b0;

#100
    $finish;  
end
  
endmodule
