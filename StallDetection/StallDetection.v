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
// CREATED		"Tue Jan 21 10:47:08 2025"

module StallDetection(
	EXop,
	EXrm,
	EXrn,
	EXrp,
	IDop,
	IDrm,
	IDrn,
	MEMop,
	MEMrn,
	IDStall,
	EXStall
);


input wire	[31:26] EXop;
input wire	[25:21] EXrm;
input wire	[20:16] EXrn;
input wire	[15:11] EXrp;
input wire	[31:26] IDop;
input wire	[25:21] IDrm;
input wire	[20:16] IDrn;
input wire	[31:26] MEMop;
input wire	[20:16] MEMrn;
output wire	IDStall;
output wire	EXStall;

wire	EXopisIType;
wire	EXopisITypeandMEMrnisEXrm;
wire	EXopisLW;
wire	EXopisLWorADDI_and_RAWhazardonEXrn;
wire	EXopisRTYPE;
wire	EXopisRTYPE_and_RAWhazardonEXrp;
wire	EXopisRTYPEandMEMrnisEXrmorEXrn;
wire	EXrnisIDrm;
wire	EXrnisIDrmorIDrn;
wire	EXrnisIDrn;
wire	EXrpisIDrm;
wire	EXrpisIDrmorIDrn;
wire	EXrpisIDrn;
wire	IDRAWhazard;
wire	MEMopisLW;
wire	MEMopisLW_and_RAWhazardonMEMrn;
wire	MEMrnisIDrm;
wire	MEMrnisIDrn;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;

assign	SYNTHESIZED_WIRE_0 = 0;




LW	b2v_EXopLW(
	.Op(EXop),
	.Y(EXopisLW));


RTYPE	b2v_EXopRTYPE(
	.Op(EXop),
	.Y(EXopisRTYPE));


REGCheck	b2v_EXrnIDrm(
	.reg1(EXrn),
	.reg2(IDrm),
	.Y(EXrnisIDrm));


REGCheck	b2v_EXrnIDrn(
	.reg1(EXrn),
	.reg2(IDrn),
	.Y(EXrnisIDrn));


REGCheck	b2v_EXrpIDrm(
	.reg1(EXrp),
	.reg2(IDrm),
	.Y(EXrpisIDrm));


REGCheck	b2v_EXrpIDrn(
	.reg1(EXrp),
	.reg2(IDrn),
	.Y(EXrpisIDrn));


BEQ	b2v_IDopBEQ(
	.Op(IDop),
	.Y(SYNTHESIZED_WIRE_12));


BNE	b2v_inst(
	.Op(IDop),
	.Y(SYNTHESIZED_WIRE_13));

assign	IDRAWhazard = EXopisLWorADDI_and_RAWhazardonEXrn | MEMopisLW_and_RAWhazardonMEMrn | EXopisRTYPE_and_RAWhazardonEXrp;


LUI	b2v_inst11(
	.Op(EXop),
	.Y(SYNTHESIZED_WIRE_3));


SLTI	b2v_inst12(
	.Op(EXop),
	.Y(SYNTHESIZED_WIRE_4));

assign	EXopisIType = SYNTHESIZED_WIRE_0 | EXopisLW | SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2 | SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4;


assign	IDStall = SYNTHESIZED_WIRE_5 & IDRAWhazard;

assign	EXrpisIDrmorIDrn = EXrpisIDrn | EXrpisIDrm;

assign	EXrnisIDrmorIDrn = EXrnisIDrn | EXrnisIDrm;

assign	SYNTHESIZED_WIRE_8 = MEMrnisIDrn | MEMrnisIDrm;

assign	SYNTHESIZED_WIRE_9 = SYNTHESIZED_WIRE_6 | SYNTHESIZED_WIRE_14;

assign	EXopisLWorADDI_and_RAWhazardonEXrn = EXopisIType & EXrnisIDrmorIDrn;

assign	EXopisRTYPE_and_RAWhazardonEXrp = EXopisRTYPE & EXrpisIDrmorIDrn;

assign	MEMopisLW_and_RAWhazardonMEMrn = MEMopisLW & SYNTHESIZED_WIRE_8;

assign	EXopisRTYPEandMEMrnisEXrmorEXrn = EXopisRTYPE & SYNTHESIZED_WIRE_9;

assign	EXopisITypeandMEMrnisEXrm = EXopisIType & SYNTHESIZED_WIRE_14;

assign	EXStall = MEMopisLW & SYNTHESIZED_WIRE_11;

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_12 | SYNTHESIZED_WIRE_13;


ADDI	b2v_inst7(
	.Op(EXop),
	.Y(SYNTHESIZED_WIRE_1));


ORI	b2v_inst8(
	.Op(EXop),
	.Y(SYNTHESIZED_WIRE_2));

assign	SYNTHESIZED_WIRE_11 = EXopisITypeandMEMrnisEXrm | EXopisRTYPEandMEMrnisEXrmorEXrn;


LW	b2v_MEMopLW(
	.Op(MEMop),
	.Y(MEMopisLW));


REGCheck	b2v_MEMrnEXrm(
	.reg1(MEMrn),
	.reg2(EXrm),
	.Y(SYNTHESIZED_WIRE_14));


REGCheck	b2v_MEMrnEXrn(
	.reg1(MEMrn),
	.reg2(EXrn),
	.Y(SYNTHESIZED_WIRE_6));


REGCheck	b2v_MEMrnIDrm(
	.reg1(MEMrn),
	.reg2(IDrm),
	.Y(MEMrnisIDrm));


REGCheck	b2v_MEMrnIDrn(
	.reg1(MEMrn),
	.reg2(IDrn),
	.Y(MEMrnisIDrn));


endmodule
