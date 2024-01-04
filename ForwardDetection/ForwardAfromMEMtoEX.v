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
// CREATED		"Thu Jan 04 12:08:08 2024"

module ForwardAfromMEMtoEX(
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
wire	MEMopisADDI_and_MEMrnisEXrm;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrpisEXrm;
wire	MEMrnisEXrm;
wire	MEMrpisEXrm;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_1));


LUI	b2v_inst1(
	.Op(MEMop),
	.lui_output(SYNTHESIZED_WIRE_0));

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1 | MEMopisADDI;

assign	MEMopisRTYPE_and_MEMrpisEXrm = MEMopisRTYPE & MEMrpisEXrm;

assign	Y = MEMopisADDI_and_MEMrnisEXrm | MEMopisRTYPE_and_MEMrpisEXrm;

assign	MEMopisADDI_and_MEMrnisEXrm = SYNTHESIZED_WIRE_2 & MEMrnisEXrm;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrnEXrm(
	.reg1(MEMrn),
	.reg2(EXrm),
	.Y(MEMrnisEXrm));


REGCheck	b2v_MEMrpEXrm(
	.reg1(MEMrp),
	.reg2(EXrm),
	.Y(MEMrpisEXrm));


endmodule
