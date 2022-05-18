// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Wed May 18 06:46:49 2022"

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
wire	SYNTHESIZED_WIRE_0;





SLTI	b2v_inst(
	.Op(WBop),
	.slti_output(SYNTHESIZED_WIRE_0));

assign	WBopisLWorADDI = WBopisLW | SYNTHESIZED_WIRE_0 | WBopisADDI;

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
