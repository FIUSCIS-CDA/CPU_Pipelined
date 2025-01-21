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
// CREATED		"Tue Jan 21 10:45:09 2025"

module ForwardDetection(
	EXrm,
	EXrn,
	IDrm,
	IDrn,
	MEMop,
	MEMrn,
	MEMrp,
	WBop,
	WBrn,
	WBrp,
	ForwardA_EX,
	ForwardA_ID,
	ForwardB_EX,
	ForwardB_ID
);


input wire	[25:21] EXrm;
input wire	[20:16] EXrn;
input wire	[25:21] IDrm;
input wire	[20:16] IDrn;
input wire	[31:26] MEMop;
input wire	[20:16] MEMrn;
input wire	[15:11] MEMrp;
input wire	[31:26] WBop;
input wire	[20:16] WBrn;
input wire	[15:11] WBrp;
output wire	[1:0] ForwardA_EX;
output wire	[1:0] ForwardA_ID;
output wire	[1:0] ForwardB_EX;
output wire	[1:0] ForwardB_ID;

wire	AWBtoEX;
wire	AWBtoID;
wire	BWBtoEX;
wire	BWBtoID;
wire	[1:0] ForwardA_EX_ALTERA_SYNTHESIZED;
wire	[1:0] ForwardA_ID_ALTERA_SYNTHESIZED;
wire	[1:0] ForwardB_EX_ALTERA_SYNTHESIZED;
wire	[1:0] ForwardB_ID_ALTERA_SYNTHESIZED;
wire	NOTAMEMtoEX;
wire	NOTAMEMtoID;
wire	NOTBMEMtoEX;
wire	NOTBMEMtoID;





ForwardAfromMEMtoEX	b2v_fwdAMEMtoEX(
	.EXrm(EXrm),
	.MEMop(MEMop),
	.MEMrn(MEMrn),
	.MEMrp(MEMrp),
	.Y(ForwardA_EX_ALTERA_SYNTHESIZED[0]));


ForwardAfromMEMtoID	b2v_fwdAMEMtoID(
	.IDrm(IDrm),
	.MEMop(MEMop),
	.MEMrn(MEMrn),
	.MEMrp(MEMrp),
	.Y(ForwardA_ID_ALTERA_SYNTHESIZED[0]));


ForwardAfromWBtoEX	b2v_fwdAWBtoEX(
	.EXrm(EXrm),
	.WBop(WBop),
	.WBrn(WBrn),
	.WBrp(WBrp),
	.Y(AWBtoEX));


ForwardAfromWBtoID	b2v_fwdAWBtoID(
	.IDrm(IDrm),
	.WBop(WBop),
	.WBrn(WBrn),
	.WBrp(WBrp),
	.Y(AWBtoID));


ForwardBfromMEMtoEX	b2v_fwdBMEMtoEX(
	.EXrn(EXrn),
	.MEMop(MEMop),
	.MEMrn(MEMrn),
	.MEMrp(MEMrp),
	.Y(ForwardB_EX_ALTERA_SYNTHESIZED[0]));


ForwardBfromMEMtoID	b2v_fwdBMEMtoID(
	.IDrn(IDrn),
	.MEMop(MEMop),
	.MEMrn(MEMrn),
	.MEMrp(MEMrp),
	.Y(ForwardB_ID_ALTERA_SYNTHESIZED[0]));


ForwardBfromWBtoEX	b2v_fwdBWBtoEX(
	.EXrn(EXrn),
	.WBop(WBop),
	.WBrn(WBrn),
	.WBrp(WBrp),
	.Y(BWBtoEX));


ForwardBfromWBtoID	b2v_fwdBWBtoID(
	.IDrn(IDrn),
	.WBop(WBop),
	.WBrn(WBrn),
	.WBrp(WBrp),
	.Y(BWBtoID));

assign	NOTBMEMtoEX =  ~ForwardB_EX_ALTERA_SYNTHESIZED[0];

assign	ForwardB_EX_ALTERA_SYNTHESIZED[1] = NOTBMEMtoEX & BWBtoEX;

assign	NOTAMEMtoID =  ~ForwardA_ID_ALTERA_SYNTHESIZED[0];

assign	ForwardA_ID_ALTERA_SYNTHESIZED[1] = NOTAMEMtoID & AWBtoID;

assign	NOTBMEMtoID =  ~ForwardB_ID_ALTERA_SYNTHESIZED[0];

assign	ForwardB_ID_ALTERA_SYNTHESIZED[1] = NOTBMEMtoID & BWBtoID;

assign	NOTAMEMtoEX =  ~ForwardA_EX_ALTERA_SYNTHESIZED[0];

assign	ForwardA_EX_ALTERA_SYNTHESIZED[1] = NOTAMEMtoEX & AWBtoEX;

assign	ForwardA_EX = ForwardA_EX_ALTERA_SYNTHESIZED;
assign	ForwardA_ID = ForwardA_ID_ALTERA_SYNTHESIZED;
assign	ForwardB_EX = ForwardB_EX_ALTERA_SYNTHESIZED;
assign	ForwardB_ID = ForwardB_ID_ALTERA_SYNTHESIZED;

endmodule
