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
// CREATED		"Wed May 18 06:20:53 2022"

module MEMM(
	clk,
	Instruction,
	MEMALUOut,
	MEMB,
	MEMForward,
	MEMIR,
	MEMop,
	MEMrd,
	MEMrs,
	MEMrt,
	MEMValue
);


input wire	clk;
input wire	[31:0] Instruction;
input wire	[31:0] MEMALUOut;
input wire	[31:0] MEMB;
output wire	[31:0] MEMForward;
output wire	[31:0] MEMIR;
output wire	[5:0] MEMop;
output wire	[4:0] MEMrd;
output wire	[4:0] MEMrs;
output wire	[4:0] MEMrt;
output wire	[31:0] MEMValue;

wire	[31:0] IR;
wire	LWinstruction;
wire	[31:0] ReadData;
wire	SWinstruction;

assign	MEMForward = MEMALUOut;




LW	b2v_isLW(
	.Op(IR[31:26]),
	.Y(LWinstruction));


SW	b2v_isSW(
	.Op(IR[31:26]),
	.Y(SWinstruction));


MUX2_32	b2v_MUXMEMValue(
	.S(LWinstruction),
	.A(MEMALUOut),
	.B(ReadData),
	.Y(MEMValue));


DM_synch	b2v_MYDM(
	.clk(clk),
	.we(SWinstruction),
	.a(MEMALUOut),
	.wd(MEMB),
	.rd(ReadData));

assign	MEMIR = IR;
assign	IR = Instruction;
assign	MEMop[5:0] = IR[31:26];
assign	MEMrd[4:0] = IR[15:11];
assign	MEMrs[4:0] = IR[25:21];
assign	MEMrt[4:0] = IR[20:16];

endmodule
