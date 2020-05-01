`timescale 1ns / 1ps

module testbench;

localparam expected = 16'd15;

reg [7:0] A, B;
reg [1:0] mode;		// 00 - A+B, 01 - A*B, 10 - A-1, 11 - B 
wire [15:0] out;

alu alu_inst (.i_A(A), 
				.i_B(B), 
				.i_mode(mode), 
				.o_out(out));
				
always @(*) begin
	if(out == expected) begin
		$monitor("Current time: %0t ps, expected result: %0d, your result: %0d. Result is OK!", $time, expected, out);
	end else begin
		$monitor("Current time: %0t ps, expected result: %0d, your result: %0d. Result is NOT OK!", $time, expected, out);
	end
end
				
initial begin
#0
	A = 8'd10;
	B = 8'd5;
	mode = 2'b00;

#20
	mode = 2'b01;
	
#20
	mode = 2'b10;

#20
	mode = 2'b11;
	
#20
	A = 8'd0;
	mode = 2'b10;

#20
    $finish;  
end
  
endmodule
