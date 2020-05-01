/*
** Binary couner from 0 to 255 - counting module = 256, with reverse counting direction.
*/

module bin_counter(i_clk, i_rst, i_mode, o_cnt);

input i_clk;						// clock signal
input i_rst;						// reset -> i_clear
input i_mode;						// 0 - normal mode, 1 - reverse -> i_up_dwn
output reg [7:0] o_cnt;				// 0...15

always @(posedge i_clk) begin		// synchr reset
	if(i_rst) begin
		o_cnt <= (~i_mode) ? {8{1'b0}} : {8{1'b1}};
	end else begin
		if(~i_mode) begin			// normal
			o_cnt <= o_cnt + 1'b1;
		end else begin
			o_cnt <= o_cnt - 1'b1;
		end
	end
end
endmodule
	