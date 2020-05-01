// Moore FSM module.
// There is also additional "state" output signal for comfortable using in the testbench.

module fsm(i_clk, i_en, o_max, state);

input i_clk, i_en;
output reg o_max;

output reg [1:0] state;					// 2^2 = 4 possible states

// FSM states
parameter [1:0] A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

// FSM's logic of transitions
always @(posedge i_clk) begin
	case(state) 
		A:
			state <= (i_en) ? B : A;
		B:
			state <= (i_en) ? C : B;
		C:
			state <= (i_en) ? D : C;
		D:
			state <= (i_en) ? A : D;
		
		default:
			state <= A;			// just to save the state, but is it necessary, hm?
	endcase
end

// FSM's output logic 
always @(state) begin
	case(state)
		D:	
			o_max <= 1'b1;
			
		default:
			o_max <= 1'b0;
	endcase
end
endmodule