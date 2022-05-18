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
// CREATED		"Wed May 18 07:00:01 2022"

module ForwardAfromMEMtoEX(
	EXrd,
	EXrs,
	EXrt,
	MEMop,
	MEMrd,
	MEMrs,
	MEMrt,
	Y
);


input wire	[4:0] EXrd;
input wire	[4:0] EXrs;
input wire	[4:0] EXrt;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrd;
input wire	[4:0] MEMrs;
input wire	[4:0] MEMrt;
output wire	Y;

wire	MEMopisADDI;
wire	MEMopisADDI_and_MEMrtisEXrs;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrdisEXrs;
wire	MEMrdisEXrs;
wire	MEMrtisEXrs;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_0));

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_0 | MEMopisADDI;

assign	MEMopisRTYPE_and_MEMrdisEXrs = MEMopisRTYPE & MEMrdisEXrs;

assign	Y = MEMopisADDI_and_MEMrtisEXrs | MEMopisRTYPE_and_MEMrdisEXrs;

assign	MEMopisADDI_and_MEMrtisEXrs = SYNTHESIZED_WIRE_1 & MEMrtisEXrs;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrdEXrs(
	.reg1(MEMrd),
	.reg2(EXrs),
	.Y(MEMrdisEXrs));


REGCheck	b2v_MEMrtEXrs(
	.reg1(MEMrt),
	.reg2(EXrs),
	.Y(MEMrtisEXrs));


endmodule
