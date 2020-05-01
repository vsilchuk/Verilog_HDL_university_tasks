`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 10;

reg         clk;
reg 		ind_rst; 
wire [2:0] 	index;
wire [3:0]  max;

val_find bc_inst(.i_clk(clk), 
					.i_ind_rst(ind_rst),
                    .o_max_value(max), 
                    .o_index(index)
                    );

initial begin
#0	
	clk = 0;
	forever	#(PERIOD/2)	clk = ~clk;
end

initial begin
#0
	ind_rst = 1'b1;

#5 
	ind_rst = 1'b0;

#100
    $finish;  
end
  
endmodule
