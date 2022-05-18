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
// CREATED		"Wed May 18 06:42:35 2022"

module ForwardBfromWBtoID(
	IDrs,
	IDrt,
	WBop,
	WBrd,
	WBrs,
	WBrt,
	Y
);


input wire	[4:0] IDrs;
input wire	[4:0] IDrt;
input wire	[5:0] WBop;
input wire	[4:0] WBrd;
input wire	[4:0] WBrs;
input wire	[4:0] WBrt;
output wire	Y;

wire	WBopisADDI;
wire	WBopisLW;
wire	WBopisLWorADDI_and_WBrtisIDrt;
wire	WBopisRTYPE;
wire	WBopisRTYPE_and_WBrdisIDrt;
wire	WBrdisIDrt;
wire	WBrtisIDrt;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





SLTI	b2v_inst(
	.Op(WBop),
	.slti_output(SYNTHESIZED_WIRE_0));

assign	SYNTHESIZED_WIRE_1 = WBopisLW | SYNTHESIZED_WIRE_0 | WBopisADDI;

assign	WBopisRTYPE_and_WBrdisIDrt = WBopisRTYPE & WBrdisIDrt;

assign	WBopisLWorADDI_and_WBrtisIDrt = SYNTHESIZED_WIRE_1 & WBrtisIDrt;

assign	Y = WBopisLWorADDI_and_WBrtisIDrt | WBopisRTYPE_and_WBrdisIDrt;


ADDI	b2v_WBopADDI(
	.Op(WBop),
	.addi_output(WBopisADDI));


LW	b2v_WBopLW(
	.Op(WBop),
	.Y(WBopisLW));


RTYPE	b2v_WBopRTYPE(
	.Op(WBop),
	.Y(WBopisRTYPE));


REGCheck	b2v_WBrdIDrt(
	.reg1(IDrt),
	.reg2(WBrd),
	.Y(WBrdisIDrt));


REGCheck	b2v_WBrtIDrt(
	.reg1(IDrt),
	.reg2(WBrt),
	.Y(WBrtisIDrt));


endmodule
