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
// CREATED		"Tue May 06 11:27:05 2025"

module ForwardAfromWBtoID(
	IDrm,
	WBop,
	WBrn,
	WBrp,
	Y
);


input wire	[25:21] IDrm;
input wire	[31:26] WBop;
input wire	[20:16] WBrn;
input wire	[15:11] WBrp;
output wire	Y;

wire	WBopisLW;
wire	WBopisLWorADDI_and_WBrnisIDrm;
wire	WBopisRTYPE;
wire	WBopisRTYPE_and_WBrpisIDrm;
wire	WBrnisIDrm;
wire	WBrpisIDrm;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;





ORI	b2v_inst(
	.Op(WBop),
	.Y(SYNTHESIZED_WIRE_3));


ANDI	b2v_inst1(
	.Op(WBop),
	.Y(SYNTHESIZED_WIRE_4));


LUI	b2v_inst2(
	.Op(WBop),
	.Y(SYNTHESIZED_WIRE_1));

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2 | WBopisLW | SYNTHESIZED_WIRE_3 | SYNTHESIZED_WIRE_4;


ADDI	b2v_inst4(
	.Op(WBop),
	.Y(SYNTHESIZED_WIRE_2));


SLTI	b2v_inst5(
	.Op(WBop),
	.Y(SYNTHESIZED_WIRE_0));

assign	WBopisRTYPE_and_WBrpisIDrm = WBopisRTYPE & WBrpisIDrm;

assign	WBopisLWorADDI_and_WBrnisIDrm = SYNTHESIZED_WIRE_5 & WBrnisIDrm;

assign	Y = WBopisLWorADDI_and_WBrnisIDrm | WBopisRTYPE_and_WBrpisIDrm;


LW	b2v_WBopLW(
	.Op(WBop),
	.Y(WBopisLW));


RTYPE	b2v_WBopRTYPE(
	.Op(WBop),
	.Y(WBopisRTYPE));


REGCheck	b2v_WBrnIDrm(
	.reg1(IDrm),
	.reg2(WBrn),
	.Y(WBrnisIDrm));


REGCheck	b2v_WBrpIDrm(
	.reg1(IDrm),
	.reg2(WBrp),
	.Y(WBrpisIDrm));


endmodule
