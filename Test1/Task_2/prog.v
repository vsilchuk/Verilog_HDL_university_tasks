module prog(clk, reset, data_a, data_b, out);
	input clk;
	input reset;
	input [7:0] data_a;
	input [7:0] data_b;
	output [7:0] out;
	
	assign out = data_a & data_b;
endmodule

