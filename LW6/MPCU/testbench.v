`timescale 1ns / 1ns

module testbench;

parameter PERIOD = 20;

reg clk, rst;		// clock and reset signals
reg x1, x2;			// input signals
wire out;			// output signal
wire [3:0] state;	// current state signal

initial begin
#0	
	clk = 0;
	forever	#(PERIOD/2)	clk = ~clk;
end

mpcu mpcu_inst (.i_clk(clk), 
				.i_rst(rst), 
				.i_x1(x1), 
				.i_x2(x2),
				.o_out(out),
				.state(state));
				
always @(*) begin
	$monitor("Time: %0t ns,\t\tX1: %0d, X2: %0d, out: %0d, FSM state: Y%0d.", $time, x1, x2, out, state);	// $time/1000 --> ns
end

initial begin
#0
	rst = 1'b1;
	x1 = 1'b0;
	x2 = 1'b1;
	
#10 
	rst = 1'b0;
	
#150
	rst = 1'b1;
	x1 = 1'b1;

#10
	rst = 1'b0;

#150
	rst = 1'b1;
	x2 = 1'b0;
	
#10
	rst = 1'b0;

#150
	x2 = 1'b1;
	
#170
    $finish;  
end
  
endmodule
