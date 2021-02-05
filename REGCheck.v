// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 15.0.0 Build 145 04/22/2015 SJ Web Edition"
// CREATED		"Tue Feb  2 08:03:07 2021"

module REGCheck(
	reg1,
	reg2,
	Y
);


input wire	[4:0] reg1;
input wire	[4:0] reg2;
output wire	Y;

wire	registersAreNotZero;
wire	registersAreTheSame;




assign	Y = registersAreTheSame & registersAreNotZero;


EQ_5	b2v_reg1EQreg2(
	.A(reg1),
	.B(reg2),
	.Y(registersAreTheSame));


NONZERO	b2v_reg1NOTZERO(
	.Register(reg1),
	.Y(registersAreNotZero));


endmodule
