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
// CREATED		"Wed May 18 06:46:57 2022"

module ForwardBfromMEMtoID(
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
wire	MEMopisADDI_and_MEMrtisIDrt;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrdisIDrt;
wire	MEMrdisIDrt;
wire	MEMrtisIDrt;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_1));

assign	MEMopisRTYPE_and_MEMrdisIDrt = MEMopisRTYPE & MEMrdisIDrt;

assign	MEMopisADDI_and_MEMrtisIDrt = SYNTHESIZED_WIRE_0 & MEMrtisIDrt;

assign	Y = MEMopisADDI_and_MEMrtisIDrt | MEMopisRTYPE_and_MEMrdisIDrt;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_1 | MEMopisADDI;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrdIDrt(
	.reg1(IDrt),
	.reg2(MEMrd),
	.Y(MEMrdisIDrt));


REGCheck	b2v_MEMrtIDrt(
	.reg1(IDrt),
	.reg2(MEMrt),
	.Y(MEMrtisIDrt));


endmodule
