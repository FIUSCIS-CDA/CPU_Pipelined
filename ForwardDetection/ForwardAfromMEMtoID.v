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
// CREATED		"Thu Jan 04 12:08:23 2024"

module ForwardAfromMEMtoID(
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
wire	MEMopisADDI_and_MEMrnisIDrm;
wire	MEMopisRTYPE;
wire	MEMopisRTYPE_and_MEMrpisIDrm;
wire	MEMrnisIDrm;
wire	MEMrpisIDrm;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;





SLTI	b2v_inst(
	.Op(MEMop),
	.slti_output(SYNTHESIZED_WIRE_2));


LUI	b2v_inst1(
	.Op(MEMop),
	.lui_output(SYNTHESIZED_WIRE_3));

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_0 & MEMrnisIDrm;

assign	MEMopisRTYPE_and_MEMrpisIDrm = MEMopisRTYPE & MEMrpisIDrm;

assign	Y = MEMopisRTYPE_and_MEMrpisIDrm | MEMopisADDI_and_MEMrnisIDrm | SYNTHESIZED_WIRE_1;

assign	MEMopisADDI_and_MEMrnisIDrm = MEMopisADDI & MEMrnisIDrm;

assign	SYNTHESIZED_WIRE_0 = SYNTHESIZED_WIRE_2 | SYNTHESIZED_WIRE_3;


ADDI	b2v_MEMopADDI(
	.Op(MEMop),
	.addi_output(MEMopisADDI));


RTYPE	b2v_MEMopRTYPE(
	.Op(MEMop),
	.Y(MEMopisRTYPE));


REGCheck	b2v_MEMrnIDrm(
	.reg1(IDrm),
	.reg2(MEMrn),
	.Y(MEMrnisIDrm));


REGCheck	b2v_MEMrpIDrm(
	.reg1(IDrm),
	.reg2(MEMrp),
	.Y(MEMrpisIDrm));


endmodule
