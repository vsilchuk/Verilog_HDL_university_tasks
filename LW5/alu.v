// ALU module - A+B, A*B, A-1, B.

module alu(i_A, i_B, i_mode, o_out);

input [7:0] i_A, i_B;					
input [1:0] i_mode;						// 00 - A+B, 01 - A*B, 10 - A-1, 11 - B
output reg [15:0] o_out;		

always @(*) begin
	case(i_mode) 
		2'b00: o_out = i_A + i_B;
		2'b01: o_out = i_A * i_B;
		2'b10: o_out = i_A - 1'b1;
		2'b11: o_out = i_B;
		
		default:
			begin
				o_out = {16{1'b0}};
			end
	endcase
end
endmodule
	