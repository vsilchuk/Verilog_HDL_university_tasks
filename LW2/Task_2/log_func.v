module log_func(i_A, i_B, i_C, o_F);
	input i_A, i_B, i_C;
	output o_F;
	
	assign o_F = (i_A & ~i_C) | (i_B & i_C);
endmodule

