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
// CREATED		"Thu Feb  4 14:53:55 2021"

module StallDetection(
	EXop,
	EXrd,
	EXrs,
	EXrt,
	IDop,
	IDrs,
	IDrt,
	MEMop,
	MEMrt,
	IDStall,
	EXStall
);


input wire	[5:0] EXop;
input wire	[4:0] EXrd;
input wire	[4:0] EXrs;
input wire	[4:0] EXrt;
input wire	[5:0] IDop;
input wire	[4:0] IDrs;
input wire	[4:0] IDrt;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrt;
output wire	IDStall;
output wire	EXStall;

wire	EXopisADDI;
wire	EXopisLW;
wire	EXopisLWorADDI;
wire	EXopisLWorADDI_and_RAWhazardonEXrt;
wire	EXopisLWorSWorADDI;
wire	EXopisLWorSWorADDI_and_EXRAWhazard;
wire	EXopisRTYPE;
wire	EXopisRTYPE_and_EXRAWhazard;
wire	EXopisRTYPE_and_RAWhazardonEXrd;
wire	EXopisSW;
wire	EXrdisIDrs;
wire	EXrdisIDrsorIDrt;
wire	EXrdisIDrt;
wire	EXrtisIDrs;
wire	EXrtisIDrsorIDrt;
wire	EXrtisIDrt;
wire	IDopisBEQ;
wire	IDRAWhazard;
wire	MEMopisLW;
wire	MEMopisLW_and_MEMrtisNOT0;
wire	MEMopisLW_and_RAWhazardonMEMrt;
wire	MEMopisLW_and_RAWhazardonMEMrtEXrsorrt;
wire	MEMrtisEXrs;
wire	MEMrtisEXrsorEXrt;
wire	MEMrtisEXrt;
wire	MEMrtisIDrs;
wire	MEMrtisIDrsorIDrt;
wire	MEMrtisIDrt;





ADDI	b2v_EXopADDI(
	.Op(EXop),
	.addi_output(EXopisADDI));


ADDI	b2v_EXopADDI2(
	.Op(EXop),
	.addi_output(EXopisADDI));


LW	b2v_EXopLW(
	.Op(EXop),
	.Y(EXopisLW));


LW	b2v_EXopLW2(
	.Op(EXop),
	.Y(EXopisLW));


RTYPE	b2v_EXopRTYPE(
	.Op(EXop),
	.Y(EXopisRTYPE));


RTYPE	b2v_EXopRTYPE2(
	.Op(EXop),
	.Y(EXopisRTYPE));


SW	b2v_EXopSW(
	.Op(EXop),
	.Y(EXopisSW));


REGCheck	b2v_EXrdIDrs(
	.reg1(EXrd),
	.reg2(IDrs),
	.Y(EXrdisIDrs));


REGCheck	b2v_EXrdIDrt(
	.reg1(EXrd),
	.reg2(IDrt),
	.Y(EXrdisIDrt));


REGCheck	b2v_EXrtIDrs(
	.reg1(EXrt),
	.reg2(IDrs),
	.Y(EXrtisIDrs));


REGCheck	b2v_EXrtIDrt(
	.reg1(EXrt),
	.reg2(IDrt),
	.Y(EXrtisIDrt));


BEQ	b2v_IDopBEQ(
	.Op(IDop),
	.Y(IDopisBEQ));

assign	IDRAWhazard = EXopisLWorADDI_and_RAWhazardonEXrt | MEMopisLW_and_RAWhazardonMEMrt | EXopisRTYPE_and_RAWhazardonEXrd;

assign	IDStall = IDopisBEQ & IDRAWhazard;

assign	EXrdisIDrsorIDrt = EXrdisIDrt | EXrdisIDrs;

assign	EXrtisIDrsorIDrt = EXrtisIDrt | EXrtisIDrs;

assign	MEMrtisIDrsorIDrt = MEMrtisIDrt | MEMrtisIDrs;

assign	MEMrtisEXrsorEXrt = MEMrtisEXrt | MEMrtisEXrs;

assign	EXopisLWorADDI_and_RAWhazardonEXrt = EXopisLWorADDI & EXrtisIDrsorIDrt;

assign	EXopisRTYPE_and_EXRAWhazard = EXopisRTYPE & MEMopisLW_and_RAWhazardonMEMrtEXrsorrt;

assign	EXopisLWorSWorADDI_and_EXRAWhazard = EXopisLWorSWorADDI & MEMopisLW_and_MEMrtisNOT0;

assign	EXopisRTYPE_and_RAWhazardonEXrd = EXopisRTYPE & EXrdisIDrsorIDrt;

assign	EXopisLWorADDI = EXopisLW | EXopisADDI;

assign	EXopisLWorSWorADDI = EXopisSW | EXopisADDI | EXopisLW;

assign	EXStall = EXopisLWorSWorADDI_and_EXRAWhazard | EXopisRTYPE_and_EXRAWhazard;

assign	MEMopisLW_and_RAWhazardonMEMrt = MEMopisLW & MEMrtisIDrsorIDrt;

assign	MEMopisLW_and_RAWhazardonMEMrtEXrsorrt = MEMopisLW & MEMrtisEXrsorEXrt;

assign	MEMopisLW_and_MEMrtisNOT0 = MEMopisLW & MEMrtisEXrs;


LW	b2v_MEMopLW(
	.Op(MEMop),
	.Y(MEMopisLW));


REGCheck	b2v_MEMrtEXrs(
	.reg1(MEMrt),
	.reg2(EXrs),
	.Y(MEMrtisEXrs));


REGCheck	b2v_MEMrtEXrt(
	.reg1(MEMrt),
	.reg2(EXrt),
	.Y(MEMrtisEXrt));


REGCheck	b2v_MEMrtIDrs(
	.reg1(MEMrt),
	.reg2(IDrs),
	.Y(MEMrtisIDrs));


REGCheck	b2v_MEMrtIDrt(
	.reg1(MEMrt),
	.reg2(IDrt),
	.Y(MEMrtisIDrt));


endmodule
