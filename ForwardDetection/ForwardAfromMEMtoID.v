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
// CREATED		"Wed May 18 06:58:06 2022"

module ForwardAfromMEMtoID(
	IDrs,
	IDrt,
	MEMop,
	MEMrd,
	MEMrs,
	MEMrt,
	Y
);


input wire	[4:0] IDrs;
input wire	[4:0] IDrt;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrd;
input wire	[4:0] MEMrs;
input wire	[4:0] MEMrt;
output wire	Y;

wire	MEMopisADDI;
wire	MEMopisADDI_and_MEMrtisIDrs;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrdisIDrs;
wire	MEMrdisIDrs;
wire	MEMrtisIDrs;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_0));

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_0 & MEMrtisIDrs;

assign	MEMopisRTYPE_and_MEMrdisIDrs = MEMopisRTYPE & MEMrdisIDrs;

assign	Y = MEMopisRTYPE_and_MEMrdisIDrs | MEMopisADDI_and_MEMrtisIDrs | SYNTHESIZED_WIRE_1;

assign	MEMopisADDI_and_MEMrtisIDrs = MEMopisADDI & MEMrtisIDrs;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrdIDrs(
	.reg1(IDrs),
	.reg2(MEMrd),
	.Y(MEMrdisIDrs));


REGCheck	b2v_MEMrtIDrs(
	.reg1(IDrs),
	.reg2(MEMrt),
	.Y(MEMrtisIDrs));


endmodule
