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
// CREATED		"Tue May 06 11:26:57 2025"

module ForwardBfromMEMtoEX(
	EXrn,
	MEMop,
	MEMrn,
	MEMrp,
	Y
);


input wire	[20:16] EXrn;
input wire	[31:26] MEMop;
input wire	[20:16] MEMrn;
input wire	[15:11] MEMrp;
output wire	Y;

wire	MEMopisADDI;
wire	MEMopisADDI_and_MEMrnisEXrn;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrpisEXrn;
wire	MEMrnisEXrn;
wire	MEMrpisEXrn;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;

assign	SYNTHESIZED_WIRE_5 = 0;




ADDI	b2v_inst(
	.Op(MEMop),
	.Y(MEMopisADDI));

assign	Y = MEMopisADDI_and_MEMrnisEXrn | MEMopisRTYPE_and_MEMrpisEXrn;



SLTI	b2v_inst2(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_1));

assign	MEMopisRTYPE_and_MEMrpisEXrn = MEMopisRTYPE & MEMrpisEXrn;

assign	MEMopisADDI_and_MEMrnisEXrn = SYNTHESIZED_WIRE_0 & MEMrnisEXrn;


LUI	b2v_inst5(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_2));


ORI	b2v_inst6(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_3));


ANDI	b2v_inst8(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_4));

assign	SYNTHESIZED_WIRE_0 = MEMopisADDI | SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2 | SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_5;


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrnEXrn(
	.reg1(EXrn),
	.reg2(MEMrn),
	.Y(MEMrnisEXrn));


REGCheck	b2v_MEMrpEXrn(
	.reg1(EXrn),
	.reg2(MEMrp),
	.Y(MEMrpisEXrn));


endmodule
