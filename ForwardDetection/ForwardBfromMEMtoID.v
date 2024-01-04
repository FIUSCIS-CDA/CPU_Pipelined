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
// CREATED		"Thu Jan 04 12:12:15 2024"

module ForwardBfromMEMtoID(
	IDrm,
	IDrn,
	MEMop,
	MEMrm,
	MEMrn,
	MEMrp,
	Y
);


input wire	[4:0] IDrm;
input wire	[4:0] IDrn;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrm;
input wire	[4:0] MEMrn;
input wire	[4:0] MEMrp;
output wire	Y;

wire	MEMopisADDI;
wire	MEMopisADDI_and_MEMrnisIDrn;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrpisIDrn;
wire	MEMrnisIDrn;
wire	MEMrpisIDrn;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_2));


LUI	b2v_inst1(
	.Op(MEMop),
	.lui_output(SYNTHESIZED_WIRE_1));

assign	MEMopisRTYPE_and_MEMrpisIDrn = MEMopisRTYPE & MEMrpisIDrn;

assign	MEMopisADDI_and_MEMrnisIDrn = SYNTHESIZED_WIRE_0 & MEMrnisIDrn;

assign	Y = MEMopisADDI_and_MEMrnisIDrn | MEMopisRTYPE_and_MEMrpisIDrn;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2 | MEMopisADDI;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrnIDrn(
	.reg1(IDrn),
	.reg2(MEMrn),
	.Y(MEMrnisIDrn));


REGCheck	b2v_MEMrpIDrn(
	.reg1(IDrn),
	.reg2(MEMrp),
	.Y(MEMrpisIDrn));


endmodule
