/*
** Binary couner from 0 to 15 - counting module = 16, with reverse counting direction.
*/

module bin_counter(i_clk, i_rst, i_mode, o_cnt);

input i_clk;				// clock signal
input i_rst;				// reset
input i_mode;				// 0 - normal mode, 1 - reverse
output reg [3:0] o_cnt;		// 0...15

always @(posedge i_clk, posedge i_rst) begin
	if(i_rst) begin
		o_cnt <= {4{1'b0}};
	end else begin
		if(~i_mode) begin			// normal
			o_cnt <= o_cnt + 1'b1;
		end else if(i_mode) begin
			o_cnt <= o_cnt - 1'b1;
		end else begin
			o_cnt <= o_cnt;			// save the state
		end
	end
end
endmodule
	