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
// CREATED		"Wed May 18 05:26:35 2022"

module WB(
	Instruction,
	WBValue,
	WBwe,
	WBData,
	WBForward,
	WBop,
	WBrd,
	WBReg,
	WBrs,
	WBrt
);


input wire	[31:0] Instruction;
input wire	[31:0] WBValue;
output wire	WBwe;
output wire	[31:0] WBData;
output wire	[31:0] WBForward;
output wire	[5:0] WBop;
output wire	[4:0] WBrd;
output wire	[4:0] WBReg;
output wire	[4:0] WBrs;
output wire	[4:0] WBrt;

wire	[31:0] WBIR;
wire	WBopisADDI;
wire	WBopisLW;
wire	WBopisLWorADDI;
wire	WBopisRTYPE;
wire	WBopRTYPE;
wire	WBrdisNOT0;

assign	WBData = WBValue;
assign	WBForward = WBValue;



assign	WBopisRTYPE = WBopRTYPE & WBrdisNOT0;

assign	WBwe = WBopisRTYPE | WBopisLWorADDI;

assign	WBopisLWorADDI = WBopisLW | WBopisADDI;


ADDI	b2v_isADDI(
	.Op(WBIR[31:26]),
	.addi_output(WBopisADDI));


LW	b2v_isLW(
	.Op(WBIR[31:26]),
	.Y(WBopisLW));


RTYPE	b2v_isRTYPE(
	.Op(WBIR[31:26]),
	.Y(WBopRTYPE));


MUX2_5	b2v_MUXWBReg(
	.S(WBopisLWorADDI),
	.A(WBIR[15:11]),
	.B(WBIR[20:16]),
	.Y(WBReg));


NONZERO	b2v_nonZeroReg(
	.Register(WBIR[15:11]),
	.Y(WBrdisNOT0));

assign	WBIR = Instruction;
assign	WBop[5:0] = WBIR[31:26];
assign	WBrd[4:0] = WBIR[15:11];
assign	WBrs[4:0] = WBIR[25:21];
assign	WBrt[4:0] = WBIR[20:16];

endmodule
