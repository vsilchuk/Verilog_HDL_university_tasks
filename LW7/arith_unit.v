// Arithmetic unit for ALU.
// Possible operations: arithmetic: ADD, SUB, shift: SLL, SRL, SRA, SCL, SCR.

module arith_unit(i_mode, i_op, i_A, i_B, i_C, i_D, o_out1, o_out2);

input i_mode;								// 1'b0 - simple arithmetics, 1'b1 - complex arithmetics.
input [2:0] i_op;							// 7 possible operations.
input [15:0] i_A, i_B, i_C, i_D;			// input data.
output reg [15:0] o_out1, o_out2;			// output result data - o_out1 is X, o_out2 is Y: [Z = X + iY = Re + i*Im = o_out1 + i*o_out2]

/*
**	i_op - possible operations:
**	000		"+"		Add
**	001		"-"		Subtract	
**	010		"<<"	Shift Left Logical
**	011		">>"	Shift Right Logical
**	100		">>>"	Shift Right Arithmetic
**	101		"<--"	Shift Cyclic Left
**	110		"-->"	Shift Cyclic Right
*/

// Complex arithmetic

wire [15:0] Re_Z1, Im_Z1, Re_Z2, Im_Z2;

assign Re_Z1 = i_A;						// Real part of 		[Z1 = Re + i*Im]
assign Im_Z1 = i_B;						// Imaginary part of	[Z1 = Re + i*Im]
assign Re_Z2 = i_C;
assign Im_Z2 = i_D;

parameter [2:0] ADD = 3'd0, SUB = 3'd1, SLL = 3'd2, SRL = 3'd3, SRA = 3'd4, SCL = 3'd5, SCR = 3'd6;

// Shifter implementation

wire [31:0] sll_A, sll_C, srl_A, srl_C;

assign sll_A = {i_A, i_A} << i_B[3:0];	// i_A << i_B[3:0], first 4 digits (LSB) of input data i_B - are the "Shift amount" value
assign sll_C = {i_C, i_C} << i_D[3:0];
assign srl_A = {i_A, i_A} >> i_B[3:0];
assign srl_C = {i_C, i_C} >> i_D[3:0];

always @(*) begin
	case(i_op) 
		ADD:
			begin
				// Z1 + Z2 = (X1 + i*Y1) + (X2 + i*Y2) = (X1 + X2) + i*(Y1 + Y2) = o_out1 + i*o_out2
				
				o_out1 = (i_mode) ? (Re_Z1 + Re_Z2) : (i_A + i_B);		// [Re] or [A+B]
				o_out2 = (i_mode) ? (Im_Z1 + Im_Z2) : (i_C + i_D);		// [Im] or [C+D]
			end
		SUB:
			begin
				// Z1 - Z2 = (X1 + i*Y1) - (X2 + i*Y2) = (X1 - X2) + i*(Y1 - Y2) = o_out1 + i*o_out2
				
				o_out1 = (i_mode) ? (Re_Z1 - Re_Z2) : (i_A - i_B);		// [Re] or [A-B]
				o_out2 = (i_mode) ? (Im_Z1 - Im_Z2) : (i_C - i_D);		// [Im] or [C-D]
			end
		SLL:
			begin
				o_out1 = sll_A[15:0];									// Shift left logical
				o_out2 = sll_C[15:0];
			end
		SRL:
			begin
				o_out1 = srl_A[31:16];									// Shift right logical
				o_out2 = srl_C[31:16];
			end
		SRA:
			begin
				o_out1 = $signed(i_A) >>> i_B[3:0];						// Arithmetic right
				o_out2 = $signed(i_C) >>> i_D[3:0];
			end
		SCL:
			begin
				o_out1 = sll_A[31:16];									// Cyclic left
				o_out2 = sll_C[31:16];
			end
		SCR:
			begin
				o_out1 = srl_A[15:0];									// Cyclic right
				o_out1 = srl_C[15:0];
			end
		
		default:														// Maybe, MUL or DIV - but we have the multiplexer in alu.v.
			begin
				o_out1 = {16{1'b0}};		
				o_out2 = {16{1'b0}};
			end
	endcase
end
					
/*
function [15:0] SLL;
	input [15:0] data;
	input [3:0] shift_amount;
	reg [31:0] l_shifted;							
	
	begin
		l_shifted = {data, data} << shift_amount;
		
		SLL = l_shifted[15:0];
	end
endfunction
*/
endmodule
	