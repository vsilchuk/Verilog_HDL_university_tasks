module val_find(i_clk, i_ind_rst, o_max_value, o_index);

input i_clk;
input i_ind_rst;

integer i;

reg [3:0] array[0:7];			// 8 cells x 4 bits memory
output reg [2:0] o_index;				// 2^3 = 8 cells
output reg [3:0] o_max_value;

initial
	$readmemh("data8x4.bin", array);

always @(posedge i_clk, posedge i_ind_rst) begin
	if(i_ind_rst) begin
		o_max_value = array[0];
	end else begin
		for(i = 0; i <= 7; i = i + 1) begin
			if(array[i] > o_max_value) begin
				o_max_value = array[i];
				o_index = i;
			end
		end
	end
end
endmodule
