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
// CREATED		"Tue Feb  2 08:05:27 2021"

module ForwardBfromMEMtoID(
	IDrs,
	IDrt,
	MEMop,
	MEMrd,
	MEMrs,
	MEMrt,
	Y
);


input wire	[4:0] IDrs;
input wire	[4:0] IDrt;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrd;
input wire	[4:0] MEMrs;
input wire	[4:0] MEMrt;
output wire	Y;

wire	MEMopisADDI;
wire	MEMopisADDI_and_MEMrtisIDrt;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrdisIDrt;
wire	MEMrdisIDrt;
wire	MEMrtisIDrt;




assign	MEMopisRTYPE_and_MEMrdisIDrt = MEMopisRTYPE & MEMrdisIDrt;

assign	MEMopisADDI_and_MEMrtisIDrt = MEMopisADDI & MEMrtisIDrt;

assign	Y = MEMopisADDI_and_MEMrtisIDrt | MEMopisRTYPE_and_MEMrdisIDrt;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrdIDrt(
	.reg1(IDrt),
	.reg2(MEMrd),
	.Y(MEMrdisIDrt));


REGCheck	b2v_MEMrtIDrt(
	.reg1(IDrt),
	.reg2(MEMrt),
	.Y(MEMrtisIDrt));


endmodule
