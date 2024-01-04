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
// CREATED		"Thu Jan 04 12:08:56 2024"

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


input wire	[5:0] EXop;
input wire	[4:0] EXrm;
input wire	[4:0] EXrn;
input wire	[4:0] EXrp;
input wire	[5:0] IDop;
input wire	[4:0] IDrm;
input wire	[4:0] IDrn;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrn;
output wire	IDStall;
output wire	EXStall;

wire	EXopisADDI;
wire	EXopisLW;
wire	EXopisLWorADDI_and_RAWhazardonEXrn;
wire	EXopisLWorSWorADDI;
wire	EXopisLWorSWorADDI_and_EXRAWhazard;
wire	EXopisRTYPE;
wire	EXopisRTYPE_and_EXRAWhazard;
wire	EXopisRTYPE_and_RAWhazardonEXrp;
wire	EXrnisIDrm;
wire	EXrnisIDrmorIDrn;
wire	EXrnisIDrn;
wire	EXrpisIDrm;
wire	EXrpisIDrmorIDrn;
wire	EXrpisIDrn;
wire	IDRAWhazard;
wire	MEMopisLW;
wire	MEMopisLW_and_MEMrnisNOT0;
wire	MEMopisLW_and_RAWhazardonMEMrn;
wire	MEMopisLW_and_RAWhazardonMEMrnEXrmorrt;
wire	MEMrnisEXrm;
wire	MEMrnisEXrmorEXrn;
wire	MEMrnisEXrn;
wire	MEMrnisIDrm;
wire	MEMrnisIDrmorIDrn;
wire	MEMrnisIDrn;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;





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
	.Y(SYNTHESIZED_WIRE_1));


RTYPE	b2v_EXopRTYPE(
	.Op(EXop),
	.Y(EXopisRTYPE));


RTYPE	b2v_EXopRTYPE2(
	.Op(EXop),
	.Y(EXopisRTYPE));


SW	b2v_EXopSW(
	.Op(EXop),
	.Y(SYNTHESIZED_WIRE_2));


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
	.Y(SYNTHESIZED_WIRE_7));


BNE	b2v_inst(
	.Op(IDop),
	.Y(SYNTHESIZED_WIRE_8));

assign	IDRAWhazard = EXopisLWorADDI_and_RAWhazardonEXrn | MEMopisLW_and_RAWhazardonMEMrn | EXopisRTYPE_and_RAWhazardonEXrp;

assign	EXStall = EXopisRTYPE_and_EXRAWhazard | EXopisLWorSWorADDI_and_EXRAWhazard | SYNTHESIZED_WIRE_0;

assign	EXopisLWorSWorADDI = SYNTHESIZED_WIRE_1 | EXopisADDI | SYNTHESIZED_WIRE_2;

assign	IDStall = SYNTHESIZED_WIRE_3 & IDRAWhazard;

assign	EXrpisIDrmorIDrn = EXrpisIDrn | EXrpisIDrm;


LUI	b2v_inst21(
	.Op(EXop),
	.lui_output(SYNTHESIZED_WIRE_4));

assign	EXrnisIDrmorIDrn = EXrnisIDrn | EXrnisIDrm;

assign	MEMrnisIDrmorIDrn = MEMrnisIDrn | MEMrnisIDrm;

assign	MEMrnisEXrmorEXrn = MEMrnisEXrn | MEMrnisEXrm;

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_5;

assign	EXopisLWorADDI_and_RAWhazardonEXrn = SYNTHESIZED_WIRE_6 & EXrnisIDrmorIDrn;

assign	EXopisRTYPE_and_EXRAWhazard = EXopisRTYPE & MEMopisLW_and_RAWhazardonMEMrnEXrmorrt;

assign	EXopisLWorSWorADDI_and_EXRAWhazard = EXopisLWorSWorADDI & MEMopisLW_and_MEMrnisNOT0;

assign	EXopisRTYPE_and_RAWhazardonEXrp = EXopisRTYPE & EXrpisIDrmorIDrn;

assign	MEMopisLW_and_RAWhazardonMEMrn = MEMopisLW & MEMrnisIDrmorIDrn;

assign	MEMopisLW_and_RAWhazardonMEMrnEXrmorrt = MEMopisLW & MEMrnisEXrmorEXrn;


SLTI	b2v_inst5(
	.Op(EXop),
	.slti_output(SYNTHESIZED_WIRE_10));

assign	MEMopisLW_and_MEMrnisNOT0 = MEMopisLW & MEMrnisEXrm;

assign	SYNTHESIZED_WIRE_3 = SYNTHESIZED_WIRE_7 | SYNTHESIZED_WIRE_8;


SLTI	b2v_inst7(
	.Op(EXop),
	.slti_output(SYNTHESIZED_WIRE_9));

assign	SYNTHESIZED_WIRE_5 = EXopisLW | SYNTHESIZED_WIRE_9 | EXopisADDI;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_10 & MEMrnisEXrm;


LW	b2v_MEMopLW(
	.Op(MEMop),
	.Y(MEMopisLW));


REGCheck	b2v_MEMrnEXrm(
	.reg1(MEMrn),
	.reg2(EXrm),
	.Y(MEMrnisEXrm));


REGCheck	b2v_MEMrnEXrn(
	.reg1(MEMrn),
	.reg2(EXrn),
	.Y(MEMrnisEXrn));


REGCheck	b2v_MEMrnIDrm(
	.reg1(MEMrn),
	.reg2(IDrm),
	.Y(MEMrnisIDrm));


REGCheck	b2v_MEMrnIDrn(
	.reg1(MEMrn),
	.reg2(IDrn),
	.Y(MEMrnisIDrn));


endmodule
