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
// CREATED		"Tue Feb  2 07:59:13 2021"

module IDEXTower(
	reset,
	clk,
	EXstall,
	IDA,
	IDB,
	IDIR,
	OLDA,
	OLDB,
	EXA,
	EXB,
	EXIR
);


input wire	reset;
input wire	clk;
input wire	EXstall;
input wire	[31:0] IDA;
input wire	[31:0] IDB;
input wire	[31:0] IDIR;
input wire	[31:0] OLDA;
input wire	[31:0] OLDB;
output wire	[31:0] EXA;
output wire	[31:0] EXB;
output wire	[31:0] EXIR;

wire	[31:0] A;
wire	[31:0] B;
wire	NOTEXstall;





Flopr_32	b2v_A_REG(
	.reset(reset),
	.clk(clk),
	.D(A),
	.Q(EXA));


Flopr_32	b2v_B_REG(
	.reset(reset),
	.clk(clk),
	.D(B),
	.Q(EXB));


MUX2_32	b2v_EXAMUX(
	.S(EXstall),
	.A(IDA),
	.B(OLDA),
	.Y(A));


MUX2_32	b2v_EXBMUX(
	.S(EXstall),
	.A(IDB),
	.B(OLDB),
	.Y(B));

assign	NOTEXstall =  ~EXstall;


Flopenr_32	b2v_IR_REG(
	.reset(reset),
	.clk(clk),
	.E(NOTEXstall),
	.D(IDIR),
	.Q(EXIR));


endmodule
