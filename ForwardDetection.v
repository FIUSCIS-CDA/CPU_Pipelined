// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus II License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 15.0.0 Build 145 04/22/2015 SJ Web Edition"
// CREATED		"Tue Feb  2 08:16:11 2021"

module ForwardDetection(
	EXop,
	EXrd,
	EXrs,
	EXrt,
	IDrs,
	IDrt,
	MEMop,
	MEMrd,
	MEMrs,
	MEMrt,
	WBop,
	WBrd,
	WBrs,
	WBrt,
	ForwardA_EX,
	ForwardA_ID,
	ForwardB_EX,
	ForwardB_ID
);


input wire	[5:0] EXop;
input wire	[4:0] EXrd;
input wire	[4:0] EXrs;
input wire	[4:0] EXrt;
input wire	[4:0] IDrs;
input wire	[4:0] IDrt;
input wire	[5:0] MEMop;
input wire	[4:0] MEMrd;
input wire	[4:0] MEMrs;
input wire	[4:0] MEMrt;
input wire	[5:0] WBop;
input wire	[4:0] WBrd;
input wire	[4:0] WBrs;
input wire	[4:0] WBrt;
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





ForwardAfromMEMtoEX	b2v_AMEMEX(
	.EXrd(EXrd),
	.EXrs(EXrs),
	.EXrt(EXrt),
	.MEMop(MEMop),
	.MEMrd(MEMrd),
	.MEMrs(MEMrs),
	.MEMrt(MEMrt),
	.Y(ForwardA_EX_ALTERA_SYNTHESIZED[0]));


ForwardAfromMEMtoID	b2v_AMEMID(
	.IDrs(IDrs),
	.IDrt(IDrt),
	.MEMop(MEMop),
	.MEMrd(MEMrd),
	.MEMrs(MEMrs),
	.MEMrt(MEMrt),
	.Y(ForwardA_ID_ALTERA_SYNTHESIZED[0]));


ForwardAfromWBtoEX	b2v_AWBEX(
	.EXrd(EXrd),
	.EXrs(EXrs),
	.EXrt(EXrt),
	.WBop(WBop),
	.WBrd(WBrd),
	.WBrs(WBrs),
	.WBrt(WBrt),
	.Y(AWBtoEX));


ForwardAfromWBtoID	b2v_AWBID(
	.IDrs(IDrs),
	.IDrt(IDrt),
	.WBop(WBop),
	.WBrd(WBrd),
	.WBrs(WBrs),
	.WBrt(WBrt),
	.Y(AWBtoID));


ForwardBfromMEMtoEX	b2v_BMEMEX(
	.EXrd(EXrd),
	.EXrs(EXrs),
	.EXrt(EXrt),
	.MEMop(MEMop),
	.MEMrd(MEMrd),
	.MEMrs(MEMrs),
	.MEMrt(MEMrt),
	.Y(ForwardB_EX_ALTERA_SYNTHESIZED[0]));


ForwardBfromMEMtoID	b2v_BMEMID(
	.IDrs(IDrs),
	.IDrt(IDrt),
	.MEMop(MEMop),
	.MEMrd(MEMrd),
	.MEMrs(MEMrs),
	.MEMrt(MEMrt),
	.Y(ForwardB_ID_ALTERA_SYNTHESIZED[0]));


ForwardBfromWBtoEX	b2v_BWBEX(
	.EXrd(EXrd),
	.EXrs(EXrs),
	.EXrt(EXrt),
	.WBop(WBop),
	.WBrd(WBrd),
	.WBrs(WBrs),
	.WBrt(WBrt),
	.Y(BWBtoEX));


ForwardBfromWBtoID	b2v_BWBID(
	.IDrs(IDrs),
	.IDrt(IDrt),
	.WBop(WBop),
	.WBrd(WBrd),
	.WBrs(WBrs),
	.WBrt(WBrt),
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
