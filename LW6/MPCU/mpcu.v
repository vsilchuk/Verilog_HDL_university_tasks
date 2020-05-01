// Microprogram control unit module.
// There is also additional "state" output signal for comfortable using in the testbench.

module mpcu(i_clk, i_rst, i_x1, i_x2, o_out, state);

input i_clk, i_rst, i_x1, i_x2;		// input signals
output reg o_out;					// output signal

output reg [3:0] state;				// 2^4 = 16 possible states

// MPCU states
parameter [3:0] Y0 = 4'd0, Y1 = 4'd1, Y2 = 4'd2, Y3 = 4'd3, Y4 = 4'd4, Y5 = 4'd5, Y6 = 4'd6, Y7 = 4'd7, Y8 = 4'd8, Yk = 4'd9;

// MPCU's logic of transitions
always @(posedge i_clk, posedge i_rst) begin
	if(i_rst) begin
		state <= Y0;
	end else begin
		case(state)
			Y0:
				state <= Y1;
			Y1:
				/*
				if(i_x1) begin
					state <= Y4;
				end else begin
					state <= Y2;
				end
				*/
				state <= (i_x1) ? Y4 : Y2;
			Y2:
				state <= Y3;
			Y3:
				state <= Y7;
			Y4:
				state <= Y5;
			Y5:
				/*
				if(i_x2) begin
					state <= Y6;
				end else begin
					state <= Y4;
				end
				*/
				state <= (i_x2) ? Y6 : Y4;
			Y6:
				state <= Y8;
			Y7:
				state <= Y8;
			Y8:
				state <= Yk;	// Yk --> default --> Y0?
				
			default:
				state <= Y0;
		endcase
	end
end

// MPCU's output logic 
always @(state) begin
	case(state)		
		Yk:	
			o_out <= 1'b1;		
			
		default:
			o_out <= 1'b0;
	endcase
end
endmodule								