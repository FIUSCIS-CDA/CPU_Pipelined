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
// CREATED		"Tue Feb  2 08:01:08 2021"

module EXMEMTower(
	reset,
	clk,
	EXALUOut,
	EXB,
	EXIR,
	MEMALUOut,
	MEMB,
	MEMIR
);


input wire	reset;
input wire	clk;
input wire	[31:0] EXALUOut;
input wire	[31:0] EXB;
input wire	[31:0] EXIR;
output wire	[31:0] MEMALUOut;
output wire	[31:0] MEMB;
output wire	[31:0] MEMIR;






Flopr_32	b2v_ALUOut_REG(
	.reset(reset),
	.clk(clk),
	.D(EXALUOut),
	.Q(MEMALUOut));


Flopr_32	b2v_B_REG(
	.reset(reset),
	.clk(clk),
	.D(EXB),
	.Q(MEMB));


Flopr_32	b2v_IR_REG(
	.reset(reset),
	.clk(clk),
	.D(EXIR),
	.Q(MEMIR));


endmodule
