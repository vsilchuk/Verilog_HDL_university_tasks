`timescale 1ns / 1ns

module testbench;

parameter PERIOD = 10;
parameter [1:0] A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;

reg clk, en;		// input clock and input signal 
wire max;			// output signal
wire [1:0] state;	// current state

initial begin
#0	
	clk = 0;
	forever	#(PERIOD/2)	clk = ~clk;
end

fsm fsm_inst (.i_clk(clk), 
				.i_en(en), 
				.o_max(max),
				.state(state));
				
always @(state) begin
	case(state)
		A:
			$display("%0tns\t\tA", $time);
		B:
			$display("%0tns\t\tB", $time);
		C:
			$display("%0tns\t\tC", $time);
		D:
			$display("%0tns\t\tD", $time);
		
		default:
			$display("%0tns\t\tdefault situation.", $time);
	endcase
end
			
initial begin
#0
	en = 1'b1;
	
#200
	en = 1'b0;

#100
	en = 1'b1;
	
#80
    $finish;  
end
endmodule
