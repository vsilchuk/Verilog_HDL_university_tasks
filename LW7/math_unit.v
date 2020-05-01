// Math unit for ALU.
// Possible operations: MUL, DIV.

module math_unit(i_mode, i_op, i_A, i_B, i_C, i_D, o_out1, o_out2);

input i_mode;								// 1'b0 - simple arithmetics, 1'b1 - complex arithmetics.
input [3:0] i_op;							// 9 possible operations (in general, implemented)
input [15:0] i_A, i_B, i_C, i_D;			// input data.
output reg [31:0] o_out1, o_out2;			// output result data - o_out1 is X, o_out2 is Y: [Z = X + iY = Re + i*Im = o_out1 + i*o_out2]

/*
**	i_op - possible operations:
**	0111	"*"		Multiply
**	1000	"/"		Divide
*/

// Complex arithmetic

wire [15:0] Re_Z1, Im_Z1, Re_Z2, Im_Z2;

reg [31:0] o_out1_buff, o_out2_buff;

assign Re_Z1 = i_A;						// Real part of 		[Z1 = Re + i*Im]
assign Im_Z1 = i_B;						// Imaginary part of	[Z1 = Re + i*Im]
assign Re_Z2 = i_C;
assign Im_Z2 = i_D;

parameter [3:0] MUL = 4'd7, DIV = 4'd8;

always @(*) begin
	case(i_op) 
		MUL:
			begin
				// Z1 * Z2 = (X1 + i*Y1) * (X2 + i*Y2) = (X1 * X2) - (Y1 * Y2) + i*(X1 * Y2 + X2 * Y1) = o_out1 + i*o_out2
				
				o_out1 = (i_mode) ? (Re_Z1 * Re_Z2) - (Im_Z1 * Im_Z2) : (i_A * i_B);		// [Re] or [A*B]
				o_out2 = (i_mode) ? (Im_Z1 * Re_Z2) + (Re_Z1 * Im_Z2) : (i_C * i_D);		// [Im] or [C*D]
			end
		DIV:
			begin
				// Z1 - Z2 = (X1 + i*Y1) / (X2 + i*Y2) =
				// = (((X1 * X2) + (Y1 * Y2)) / (X2^2 + Y2^2)) + i*(((Y1 * X2) - (X1 * Y2)) / (X2^2 + Y2^2)) = 
				// = o_out1 + i*o_out2
				
				o_out1_buff = (i_mode) ? ((Re_Z1 * Re_Z2) + (Im_Z1 * Im_Z2)) / ((Re_Z2 * Re_Z2) + (Im_Z2 * Im_Z2)) : (i_A / i_B);		// [Re] or [A/B]
				o_out2_buff = (i_mode) ? ((Im_Z1 * Re_Z2) - (Im_Z2 * Re_Z1)) / ((Re_Z2 * Re_Z2) + (Im_Z2 * Im_Z2)) : (i_C / i_D);		// [Im] or [C/D]
		
				o_out1 = {{16{o_out1_buff[15]}}, o_out1_buff[15:0]};
				o_out2 = {{16{o_out2_buff[15]}}, o_out2_buff[15:0]};
			end
		
		default:
			begin
				o_out1 = {32{1'b0}};
				o_out2 = {32{1'b0}};
			end
	endcase
end
endmodule