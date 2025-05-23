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
// CREATED		"Tue May 06 11:29:22 2025"

module ForwardAfromMEMtoEX(
	EXrm,
	MEMop,
	MEMrn,
	MEMrp,
	Y
);


input wire	[25:21] EXrm;
input wire	[31:26] MEMop;
input wire	[20:16] MEMrn;
input wire	[15:11] MEMrp;
output wire	Y;

wire	MEMopisADDI_and_MEMrnisEXrm;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrpisEXrm;
wire	MEMrnisEXrm;
wire	MEMrpisEXrm;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;

assign	SYNTHESIZED_WIRE_5 = 0;




SLTI	b2v_inst(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_2));


ANDI	b2v_inst1(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_4));

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2 | SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_5;

assign	MEMopisRTYPE_and_MEMrpisEXrm = MEMopisRTYPE & MEMrpisEXrm;

assign	Y = MEMopisADDI_and_MEMrnisEXrm | MEMopisRTYPE_and_MEMrpisEXrm;


ADDI	b2v_inst5(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_0));

assign	MEMopisADDI_and_MEMrnisEXrm = SYNTHESIZED_WIRE_6 & MEMrnisEXrm;



LUI	b2v_inst8(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_1));


ORI	b2v_inst9(
	.Op(MEMop),
	.Y(SYNTHESIZED_WIRE_3));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrnEXrm(
	.reg1(MEMrn),
	.reg2(EXrm),
	.Y(MEMrnisEXrm));


REGCheck	b2v_MEMrpEXrm(
	.reg1(MEMrp),
	.reg2(EXrm),
	.Y(MEMrpisEXrm));


endmodule
