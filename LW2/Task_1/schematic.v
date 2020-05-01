module schematic(i_A, i_B, i_C, o_Y);
	input i_A, i_B, i_C;
	output o_Y;
	
	assign o_Y = (i_A & i_B) | (~i_A & ~i_B & i_C);	
endmodule

