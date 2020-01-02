//Calculation of 4bits Flags
module cal_flags4(op, result, co_add, c3_add, co_sub, c3_sub, c, n, z, v);
	input[2:0] op;
	input[3:0] result;
	input co_add, c3_add, co_sub, c3_sub;
	output c, n, z, v;

	//Assign Variable = (condition) True : False
	assign c = (op[2:1] != 2'b11) ? 1'b0 : ((op[0] == 1'b0) ? co_add : co_sub);
	assign n = result[3];
	assign z = (result == 0) ? 1'b1 : 1'b0;
	assign v = (op[2:1] != 2'b11) ? 1'b0 : ((op[0] == 1'b0) ? co_add ^ c3_add : co_sub ^ c3_sub);

	//opcode
	//3'b110 = Addition
	//3'b111 = Subtraction
endmodule
