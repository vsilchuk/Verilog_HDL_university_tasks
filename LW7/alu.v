// Top hierarchy module. 
// Arithmetic logic unit (ALU). 

module alu(i_mode, i_op, i_A, i_B, i_C, i_D, o_out1, o_out2);

input i_mode;								// 1'b0 - simple arithmetics, 1'b1 - complex arithmetics.
input [3:0] i_op;							// 9 possible operations.
input [15:0] i_A, i_B, i_C, i_D;			// input data.
output reg [31:0] o_out1, o_out2;			// output result data.

wire [15:0] au_out1, au_out2;
wire [31:0] mu_out1, mu_out2;

/*
**	i_op - possible operations:
**	0000	"+"		Add
**	0001	"-"		Subtract	
**	0010	"<<"	Shift Left Logical
**	0011	">>"	Shift Right Logical
**	0100	">>>"	Shift Right Arithmetic
**	0101	"<--"	Shift Cyclic Left
**	0110	"-->"	Shift Cyclic Right
**	0111	"*"		Multiply
**	1000	"/"		Divide
*/

parameter [3:0] ADD = 4'd0, SUB = 4'd1, SLL = 4'd2, SRL = 4'd3, SRA = 4'd4, SCL = 4'd5, SCR = 4'd6, MUL = 4'd7, DIV = 4'd8;

// Arithmetic: ADD, SUB, shift: SLL, SRL, SRA, SCL, SCR.
arith_unit au_inst(.i_mode(i_mode),
			.i_op(i_op[2:0]),
			.i_A(i_A),
			.i_B(i_B),
			.i_C(i_C),
			.i_D(i_D),
			.o_out1(au_out1),
			.o_out2(au_out2));

// Multiply, Divide.
math_unit mu_inst(.i_mode(i_mode),
			.i_op(i_op),
			.i_A(i_A),
			.i_B(i_B),
			.i_C(i_C),
			.i_D(i_D),
			.o_out1(mu_out1),
			.o_out2(mu_out2));

always @(*) begin
	case(i_op) 
		ADD, SUB, SLL, SRL, SRA, SCL, SCR: 
			begin
				o_out1 = au_out1;
				o_out2 = au_out2;
			end
		MUL, DIV:
			begin
				o_out1 = mu_out1;
				o_out2 = mu_out2;
			end
		
		default:							// This situation will be caught by testbench by $display("Default case situation.");
			begin
				o_out1 = {32{1'b0}};
				o_out2 = {32{1'b0}};
			end
	endcase
end
endmodule