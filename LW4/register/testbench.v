`timescale 1ns / 1ps

module testbench;

parameter PERIOD = 10;

reg         clk;
reg 		reset; 
reg 		load;
reg 		dir;
reg [15:0]	load_data;
wire [15:0]	out;

shift_reg sr_inst(.i_clk(clk), 
                    .i_rst(reset), 
                    .i_load(load), 
					.i_dir(dir),
					.i_data(load_data),
                    .o_out(out)
                    );

initial begin
#0	
	clk = 0;
	forever	#(PERIOD/2)	clk = ~clk;
end

initial begin
#0
	reset = 1'b1;
	dir = 1'b0;
	load = 1'b0;
	load_data = 16'h8888;
	
#10
	reset = 1'b0;
	
#10 
	load = 1'b1;
	
#10 
	load = 1'b0;
	
#100
	load = 1'b1;
	dir = 1'b1;

#10
	load = 1'b0;
	
#100
	reset = 1'b1;

#10 
	reset = 1'b0;

#50
    $finish;  
end
  
endmodule
