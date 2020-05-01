/*
**	16-bit shift register. Parallel loading is available. Two shift direction modes.
*/

module shift_reg(i_clk, i_rst, i_load, i_dir, i_data, o_out);

input i_clk;
input i_rst;
input i_load;
input i_dir;				// shift direction: 0 - LSB to MSB, 1  - MSB to LSB
input [15:0] i_data;
output reg [15:0] o_out;

always @(posedge i_clk, posedge i_rst) begin
	if(i_rst) begin
		o_out <= {16{1'b0}};
	end else if(i_load) begin
		o_out <= i_data;
	end else begin
		if(~i_dir) begin
			o_out <= {o_out[14:0], 1'b0};
		end else begin
			o_out <= {1'b0, o_out[15:1]};
		end
	end
end
endmodule
