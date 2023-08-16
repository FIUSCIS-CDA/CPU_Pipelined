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
// CREATED		"Wed Aug 16 14:48:22 2023"

module ForwardBfromMEMtoEX(
	EXrm,
	EXrn,
	EXrp,
	MEMop,
	MEMrm,
	MEMrn,
	MEMrp,
	Y
);


input wire	[4:0] EXrm;
input wire	[4:0] EXrn;
input wire	[4:0] EXrp;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrm;
input wire	[4:0] MEMrn;
input wire	[4:0] MEMrp;
output wire	Y;

wire	MEMopisADDI;
wire	MEMopisADDI_and_MEMrnisEXrn;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrpisEXrn;
wire	MEMrnisEXrn;
wire	MEMrpisEXrn;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_1));

assign	Y = MEMopisADDI_and_MEMrnisEXrn | MEMopisRTYPE_and_MEMrpisEXrn;

assign	MEMopisRTYPE_and_MEMrpisEXrn = MEMopisRTYPE & MEMrpisEXrn;

assign	MEMopisADDI_and_MEMrnisEXrn = SYNTHESIZED_WIRE_0 & MEMrnisEXrn;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_1 | MEMopisADDI;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrnEXrn(
	.reg1(EXrn),
	.reg2(MEMrn),
	.Y(MEMrnisEXrn));


REGCheck	b2v_MEMrpEXrn(
	.reg1(EXrn),
	.reg2(MEMrp),
	.Y(MEMrpisEXrn));


endmodule
