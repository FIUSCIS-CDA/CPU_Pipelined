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
// CREATED		"Tue Feb  2 08:05:16 2021"

module ForwardBfromWBtoEX(
	EXrd,
	EXrs,
	EXrt,
	WBop,
	WBrd,
	WBrs,
	WBrt,
	Y
);


input wire	[4:0] EXrd;
input wire	[4:0] EXrs;
input wire	[4:0] EXrt;
input wire	[5:0] WBop;
input wire	[4:0] WBrd;
input wire	[4:0] WBrs;
input wire	[4:0] WBrt;
output wire	Y;

wire	WBopisADDI;
wire	WBopisADDIorLW_and_WBrtisEXrt;
wire	WBopisLW;
wire	WBopisLWorADDI;
wire	WBopisRTYPE;
wire	WBopisRTYPE_and_WBrdisEXrt;
wire	WBrdisEXrt;
wire	WBrtisEXrt;




assign	WBopisLWorADDI = WBopisLW | WBopisADDI;

assign	WBopisADDIorLW_and_WBrtisEXrt = WBopisLWorADDI & WBrtisEXrt;

assign	WBopisRTYPE_and_WBrdisEXrt = WBopisRTYPE & WBrdisEXrt;

assign	Y = WBopisADDIorLW_and_WBrtisEXrt | WBopisRTYPE_and_WBrdisEXrt;


ADDI	b2v_WBopADDI(
	.Op(WBop),
	.addi_output(WBopisADDI));


LW	b2v_WBopLW(
	.Op(WBop),
	.Y(WBopisLW));


RTYPE	b2v_WBopRTYPE(
	.Op(WBop),
	.Y(WBopisRTYPE));


REGCheck	b2v_WBrdEXrt(
	.reg1(EXrt),
	.reg2(WBrd),
	.Y(WBrdisEXrt));


REGCheck	b2v_WBrtEXrt(
	.reg1(EXrt),
	.reg2(WBrt),
	.Y(WBrtisEXrt));


endmodule
