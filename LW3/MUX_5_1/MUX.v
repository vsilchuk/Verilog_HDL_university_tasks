// MUX 5 to 1, 5 x inf.signal, 4 bit

module MUX(i_A, i_B, i_C, i_D, i_E, i_SEL, o_OUT);

input [3:0] i_A, i_B, i_C, i_D, i_E;
input [2:0] i_SEL;
output reg [3:0] o_OUT;

always @(*) begin
	// Start initialization:
	o_OUT = {4{1'b0}};
	
	case(i_SEL)
		3'd0:	o_OUT = i_A;
		3'd1:	o_OUT = i_B;
		3'd2:	o_OUT = i_C;
		3'd3:	o_OUT = i_D;
		3'd4:	o_OUT = i_E;
		
		default:
			begin
					o_OUT = {4{1'b0}};
			end
	endcase
end
endmodule
		
 

