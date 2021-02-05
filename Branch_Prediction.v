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
// CREATED		"Tue Feb  2 07:58:15 2021"

module Branch_Prediction(
	Taken,
	DelaySlot,
	IDA,
	IDB,
	IDop,
	IFop,
	Fix,
	Pick
);


input wire	Taken;
input wire	DelaySlot;
input wire	[31:0] IDA;
input wire	[31:0] IDB;
input wire	[31:26] IDop;
input wire	[31:26] IFop;
output wire	Fix;
output wire	[1:0] Pick;

wire	FixMUXOut;
wire	Ground;
wire	IDAeqIDB;
wire	IDAnoteqIDB;
wire	IDopBEQ;
wire	IFopBEQ;
wire	IFopisBEQorisNotTakenBranch;
wire	IFopisBEQorJandNoFix;
wire	IFopisJandNOTaNOTTakenBranch;
wire	IFopisJandNOTaTakenBranch;
wire	IFopJ;
wire	isNotTakenBranch;
wire	isTakenBranch;
wire	isTakenBranch2;
wire	NOTaNotTakenBranch;
wire	NOTaTakenBranch;
wire	[1:0] S;





BEQ	b2v_BEQ1(
	.Op(IFop),
	.Y(IFopBEQ));


BEQ	b2v_BEQ2(
	.Op(IDop),
	.Y(IDopBEQ));


MUX2	b2v_DelaySlotMUX(
	.S(DelaySlot),
	.A(FixMUXOut),
	.B(Ground),
	.Y(Fix));


EQ_32	b2v_EQ_checker(
	.A(IDA),
	.B(IDB),
	.Y(IDAeqIDB));


MUX2	b2v_FixMUX(
	.S(Taken),
	.A(isTakenBranch2),
	.B(isNotTakenBranch),
	.Y(FixMUXOut));

assign	NOTaTakenBranch =  ~isTakenBranch;

assign	IDAnoteqIDB =  ~IDAeqIDB;

assign	IFopisJandNOTaTakenBranch = IFopJ & NOTaTakenBranch;

assign	IFopisJandNOTaNOTTakenBranch = IFopJ & NOTaNotTakenBranch;

assign	isTakenBranch = IDopBEQ & IDAeqIDB;

assign	isNotTakenBranch = IDopBEQ & IDAnoteqIDB;

assign	IFopisBEQorisNotTakenBranch = isNotTakenBranch | IFopBEQ;

assign	IFopisBEQorJandNoFix = IFopBEQ | IFopisJandNOTaNOTTakenBranch;

assign	NOTaNotTakenBranch =  ~isNotTakenBranch;



J	b2v_J1(
	.Op(IFop),
	.Y(IFopJ));


MUX2	b2v_pickMUX(
	.S(Taken),
	.A(IFopisJandNOTaTakenBranch),
	.B(IFopisBEQorJandNoFix),
	.Y(S[1]));


MUX2	b2v_S0MUX(
	.S(Taken),
	.A(isTakenBranch),
	.B(IFopisBEQorisNotTakenBranch),
	.Y(S[0]));


SameBit	b2v_sameBit(
	.Ain(isTakenBranch),
	.Aout(isTakenBranch2));

assign	Pick = S;
assign	Ground = 0;

endmodule
