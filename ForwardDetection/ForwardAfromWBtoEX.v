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
// CREATED		"Wed Aug 16 14:48:38 2023"

module ForwardAfromWBtoEX(
	EXrm,
	EXrn,
	EXrp,
	WBop,
	WBrm,
	WBrn,
	WBrp,
	Y
);


input wire	[4:0] EXrm;
input wire	[4:0] EXrn;
input wire	[4:0] EXrp;
input wire	[5:0] WBop;
input wire	[4:0] WBrm;
input wire	[4:0] WBrn;
input wire	[4:0] WBrp;
output wire	Y;

wire	WBopisADDI;
wire	WBopisLW;
wire	WBopisLWorADDI;
wire	WBopisLWorADDI_and_WBrnisEXrm;
wire	WBopisRTYPE;
wire	WBopisRTYPE_and_WBrpisEXrm;
wire	WBrnisEXrm;
wire	WBrpisEXrm;
wire	SYNTHESIZED_WIRE_0;





SLTI	b2v_inst(
	.Op(WBop),
	.slti_output(SYNTHESIZED_WIRE_0));

assign	WBopisLWorADDI = WBopisLW | SYNTHESIZED_WIRE_0 | WBopisADDI;

assign	WBopisRTYPE_and_WBrpisEXrm = WBopisRTYPE & WBrpisEXrm;

assign	WBopisLWorADDI_and_WBrnisEXrm = WBopisLWorADDI & WBrnisEXrm;

assign	Y = WBopisLWorADDI_and_WBrnisEXrm | WBopisRTYPE_and_WBrpisEXrm;


ADDI	b2v_WBopADDI(
	.Op(WBop),
	.addi_output(WBopisADDI));


LW	b2v_WBopLW(
	.Op(WBop),
	.Y(WBopisLW));


RTYPE	b2v_WBopRTYPE(
	.Op(WBop),
	.Y(WBopisRTYPE));


REGCheck	b2v_WBrnEXrm(
	.reg1(EXrm),
	.reg2(WBrn),
	.Y(WBrnisEXrm));


REGCheck	b2v_WBrpEXrm(
	.reg1(EXrm),
	.reg2(WBrp),
	.Y(WBrpisEXrm));


endmodule
