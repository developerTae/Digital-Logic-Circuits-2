//32bits Arithmetic Logic Unit
module alu32(a, b, op, result, c, n, z, v);
	input[31:0] a, b;
	input[2:0] op;
	output[31:0] result;
	output c, n, z, v;

	wire[31:0] w_not_a, w_not_b, w_and, w_or, w_xor, w_xnor, w_add, w_sub;
	wire co_prev_add, co_add, co_prev_sub, co_sub;

	//Not A
	_inv_32bits U0_inv_32bits(.a(a), .y(w_not_a));
	//Not B
	_inv_32bits U1_inv_32bits(.a(b), .y(w_not_b));
	//And
	_and2_32bits U2_and2_32bits(.a(a), .b(b), .y(w_and));
	//Or
	_or2_32bits U3_or2_32bits(.a(a), .b(b), .y(w_or));
	//Exclusive or
	_xor2_32bits U4_xor2_32bits(.a(a), .b(b), .y(w_xor));
	//Exclusive nor
	_xnor2_32bits U5_xnor2_32bits(.a(a), .b(b), .y(w_xnor));
	//Addition
	cla32_ov U6_cla32_ov(.a(a), .b(b), .ci(1'b0), .s(w_add), .co_prev(co_prev_add), .co(co_add));
	//Subtraction
	cla32_ov U7_cla32_ov(.a(a), .b(w_not_b), .ci(1'b1), .s(w_sub), .co_prev(co_prev_sub), .co(co_sub));

	mx8_32bits U8_mx8_32bits(.a(w_not_a), .b(w_not_b), .c(w_and), .d(w_or), .e(w_xor), .f(w_xnor), .g(w_add), .h(w_sub),
	 .s2(op[2]), .s1(op[1]), .s0(op[0]), .y(result));
	 
	 cla_flags32 U9_cla_flags32(.op(op), .result(result), .co_add(co_add), .co_prev_add(co_prev_add), .co_sub(co_sub), .co_prev_sub(co_prev_sub),
	 .c(c), .n(n), .z(z), .v(v));
 
 endmodule
 