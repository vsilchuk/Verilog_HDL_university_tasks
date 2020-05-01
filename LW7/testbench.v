`timescale 1ns / 1ns

module testbench;

reg mode;					// 1'b0 - simple, 1'b1 - complex
reg [3:0] op;				// ADD, SUB, SLL, SRL, SRA, SCL, SCR, MUL, DIV
reg [15:0] A, B, C, D;		// input data
wire [31:0] out1, out2;		// output result data

parameter [3:0] ADD = 4'd0, SUB = 4'd1, SLL = 4'd2, SRL = 4'd3, SRA = 4'd4, SCL = 4'd5, SCR = 4'd6, MUL = 4'd7, DIV = 4'd8;

alu alu_inst (.i_mode(mode), 
				.i_op(op), 
				.i_A(A), 
				.i_B(B),
				.i_C(C),
				.i_D(D),
				.o_out1(out1),
				.o_out2(out2));

always @(out1, out2) begin
	case(op)
		ADD:	
			begin	
				if(mode) begin
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A + i*B) + (C + i*D) = (%0d + i*%0d)", $time, A, B, C, D, out1, out2);
				end else begin	
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A + B) = %0d, (C + D) = %0d", $time, A, B, C, D, out1, out2);
				end
			end
		SUB:
			begin
				if(mode) begin
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A + i*B) - (C + i*D) = (%0d + i*%0d)", $time, A, B, C, D, out1, out2);
				end else begin	
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A - B) = %0d, (C - D) = %0d", $time, A, B, C, D, out1, out2);
				end
			end
		SLL:
			begin
				$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A << B) = %0d, (C << D) = %0d", $time, A, B, C, D, out1, out2);
			end
		SRL:
			begin
				$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A >> B) = %0d, (C >> D) = %0d", $time, A, B, C, D, out1, out2);
			end
		SRA:
			begin
				$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A >>> B) = %0d, (C >>> D) = %0d", $time, A, B, C, D, out1, out2);
			end	
		SCL:
			begin
				$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A <-- B) = %0d, (C <-- D) = %0d", $time, A, B, C, D, out1, out2);
			end	
		SCR:
			begin
				$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A --> B) = %0d, (C --> D) = %0d", $time, A, B, C, D, out1, out2);
			end
		MUL:
			begin	
				if(mode) begin
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A + i*B) * (C + i*D) = (%0d + i*%0d)", $time, A, B, C, D, out1, out2);
				end else begin	
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A * B) = %0d, (C * D) = %0d", $time, A, B, C, D, out1, out2);
				end
			end
		DIV:
			begin	
				if(mode) begin
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A + i*B) / (C + i*D) = (%0d + i*%0d)", $time, A, B, C, D, out1, out2);
				end else begin	
					$display("%0t ns. A: %0d, B: %0d, C: %0d, D: %0d\t\t(A / B) = %0d, (C / D) = %0d", $time, A, B, C, D, out1, out2);
				end
			end	
		
		default:
			$display("%0t ns. Default case situation.", $time);
		
	endcase
end

initial begin
#0

#20
	A = 16'd10;
	B = 16'd5;
	C = 16'd100;
	D = 16'd75;
	mode = 1'b0;	// simple arithmetic
	op = 4'd0;		// ADD: (A + B) = 15, (C + D) = 175
	
#20
	op = 4'd1;		// SUB: (A - B) = 5, (C - D) = 25

#20
	A = 16'd1;		
	B = 16'd5;		// 0000 0001 << 5 = 0010 0000 (32)
	C = 16'd1;
	D = 16'd15;		// 0000 0001 << 15 = ‭1000 0000 0000 0000‬ (32768)
	op = 4'd2;		// SLL
	
#20
	A = 16'd32;
	B = 16'd5;		// 0010 0000 >> 5 = 0000 0001 (1) 
	C = 16'd32768;
	D = 16'd15;		// 1000 0000 0000 0000‬ >> 15 = 0000 0000 0000 0001 (1) 
	op = 4'd3;		// SRL
	
#20
	A = 16'd32768;
	B = 16'd15;		// [1]000 0000 0000 0000‬ >>> 15 = 1111 1111 1111 1111 (65535) 
	C = 16'd32;
	D = 16'd5;		// [0]000 0000 0010 0000 >>> 5 = 0000 0000 0000 0001 (1) (because we are filling with MSB)
	op = 4'd4;		// SRA 

#20
	A = 16'hAA00;	// 1010 1010 0000 0000 (‭43520‬)
	B = 16'd8;		// 1010 1010 0000 0000 <-- 8 = 0000 0000 1010 1010 (‭170‬)
	C = 16'hA000;	// ‭1010 0000 0000 0000‬ (‭40960‬)
	D = 16'd15;		// 1010 0000 0000 0000‬ <-- 15 = 0101 0000 0000 0000 (‭20480‬)
	op = 4'd5;		// SCL
	
#20
	A = 16'hAA;		// 0000 0000 1010 1010 (170)
	B = 16'd8;		// 0000 0000 1010 1010 --> 8 = 1010 1010 0000 0000 (‭43520‬)
	C = 16'hA000;	// ‭1010 0000 0000 0000‬ (‭40960‬)
	D = 16'd12;		// 1010 0000 0000 0000 --> 12 = 0000 0000 0000 1010 (10)
	op = 4'd6;		// SCR

#20
	A = 16'd10;
	B = 16'd5;		// (A * B) = 10 * 5 = 50
	C = 16'd100; 
	D = 16'd42; 	// (C * D) = 100 * 42 = 4200
	op = 4'd7;		// MUL

#20 
	A = 16'd50;
	B = 16'd10;		// (A / B) = 50 / 10 = 5
	C = 16'd1000; 
	D = 16'd20;		// (C / D) = 1000 / 20 = 50
	op = 4'd8;		// DIV
	
#20 
	A = 16'd2; 
	B = 16'd3;		// Z1 = (2 + i*3)
	C = 16'd3; 
	D = 16'd1;		// Z2 = (3 + i*1) 
	op = 4'd7;		// MUL
	mode = 1'b1;	// complex arithmetic: (2 + i*3) * (3 + i*1) = (3 + i*11)

#20
	A = 16'd6; 
	B = 16'd2;		// Z1 = (6 + i*2)
	C = 16'd1; 
	D = 16'd1;		// Z2 = (1 + i*1) 
		mode = 1'b1;
	op = 4'd8;		// DIV: (6 + i*2) / (1 + i*1) = (4 - i*2)

#20
	A = 16'd2; 
	B = 16'd3;		// Z1 = (2 + i*3)
	C = 16'd3; 
	D = 16'd1;		// Z2 = (3 + i*1) 
	op = 4'd0;		// ADD:	(2 + i*3) + (3 + i*1) = (2 + 3) + i*(3 + 1) = (5 + i*4)
	
#20
	A = 16'd10; 
	B = 16'd5;		// Z1 = (10 + i*5)
	C = 16'd5; 
	D = 16'd3;		// Z2 = (5 + i*3) 
	op = 4'd1;		// SUB:	(10 + i*5) + (5 + i*3) = (10 - 5) + i*(5 - 3) = (5 + i*2)

#50
    $finish;  
end
endmodule