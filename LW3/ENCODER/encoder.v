// Encoder: to convert decimal numbers from 0 to 15 to binary code.

module encoder(i_dec, o_bin, o_AI);

input [15:0] i_dec;		// must be one-hot 
output [3:0] o_bin;
output o_AI;			// "active input" - to signalize, that we have at least one "1" at the input - and the output has a sense

assign o_AI = |i_dec;	// reduction OR

assign o_bin[3] = i_dec[8] | i_dec[9] | i_dec[10] | i_dec[11] | i_dec[12] | i_dec[13] | i_dec[14] | i_dec[15];
assign o_bin[2] = i_dec[4] | i_dec[5] | i_dec[6] | i_dec[7] | i_dec[12] | i_dec[13] | i_dec[14] | i_dec[15];
assign o_bin[1] = i_dec[2] | i_dec[3] | i_dec[6] | i_dec[7] | i_dec[10] | i_dec[11] | i_dec[14] | i_dec[15];
assign o_bin[0] = i_dec[1] | i_dec[3] | i_dec[5] | i_dec[7] | i_dec[9] | i_dec[11] | i_dec[13] | i_dec[15];

endmodule