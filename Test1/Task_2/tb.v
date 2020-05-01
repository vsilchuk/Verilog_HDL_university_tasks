`timescale 1ns / 1ns

module tb;

parameter PERIOD = 10;

reg         clk;
reg 		reset; 
reg  [7:0]	data_a;
reg  [7:0] 	data_b;
wire [7:0]  out;

prog prog_inst(.clk(clk), 
                    .reset(reset), 
                    .data_a(data_a), 
                    .data_b(data_b),
					.out(out)
                    );

initial begin
#0
clk = 0;
    forever 
		begin
			#6 clk = ~clk;
			#4 clk = ~clk;
		end
end

initial begin
#0
reset = 1'b1;
data_a = 8'd0;
data_b = 8'd177;

#10 
reset = 1'b0;

#10
data_a = 8'd40;

#5
data_b = 8'd161;

#15
data_a = 8'd80;

#10
data_b = 8'd145;

#10
data_a = 8'd120;

#15
data_b = 8'd129;

#5
data_a = 8'd160;

#30

    $finish;  
end
  
endmodule
