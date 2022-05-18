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
// CREATED		"Wed May 18 05:31:08 2022"

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
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;





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
	.Y(SYNTHESIZED_WIRE_2));


BNE	b2v_inst(
	.Op(IDop),
	.Y(SYNTHESIZED_WIRE_3));

assign	IDRAWhazard = EXopisLWorADDI_and_RAWhazardonEXrt | MEMopisLW_and_RAWhazardonMEMrt | EXopisRTYPE_and_RAWhazardonEXrd;

assign	EXStall = EXopisRTYPE_and_EXRAWhazard | EXopisLWorSWorADDI_and_EXRAWhazard | SYNTHESIZED_WIRE_0;

assign	IDStall = SYNTHESIZED_WIRE_1 & IDRAWhazard;

assign	EXrdisIDrsorIDrt = EXrdisIDrt | EXrdisIDrs;

assign	EXrtisIDrsorIDrt = EXrtisIDrt | EXrtisIDrs;

assign	MEMrtisIDrsorIDrt = MEMrtisIDrt | MEMrtisIDrs;

assign	MEMrtisEXrsorEXrt = MEMrtisEXrt | MEMrtisEXrs;

assign	EXopisLWorADDI_and_RAWhazardonEXrt = EXopisLWorADDI & EXrtisIDrsorIDrt;

assign	EXopisRTYPE_and_EXRAWhazard = EXopisRTYPE & MEMopisLW_and_RAWhazardonMEMrtEXrsorrt;

assign	EXopisLWorSWorADDI_and_EXRAWhazard = EXopisLWorSWorADDI & MEMopisLW_and_MEMrtisNOT0;

assign	EXopisRTYPE_and_RAWhazardonEXrd = EXopisRTYPE & EXrdisIDrsorIDrt;

assign	EXopisLWorSWorADDI = EXopisSW | EXopisADDI | EXopisLW;

assign	MEMopisLW_and_RAWhazardonMEMrt = MEMopisLW & MEMrtisIDrsorIDrt;

assign	MEMopisLW_and_RAWhazardonMEMrtEXrsorrt = MEMopisLW & MEMrtisEXrsorEXrt;


SLTI	b2v_inst5(
	.Op(EXop),
	.slti_output(SYNTHESIZED_WIRE_5));

assign	MEMopisLW_and_MEMrtisNOT0 = MEMopisLW & MEMrtisEXrs;

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_2 | SYNTHESIZED_WIRE_3;


SLTI	b2v_inst7(
	.Op(EXop),
	.slti_output(SYNTHESIZED_WIRE_4));

assign	EXopisLWorADDI = EXopisLW | SYNTHESIZED_WIRE_4 | EXopisADDI;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_5 & MEMrtisEXrs;


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
