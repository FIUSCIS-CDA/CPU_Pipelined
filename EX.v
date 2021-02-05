// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Fri Feb 05 09:19:03 2021"

module EX(
	EXStall,
	EXA,
	EXB,
	Forward_MEM,
	Forward_WB,
	ForwardA_EX,
	ForwardB_EX,
	Instruction,
	EXALUB,
	EXALUOut,
	EXIR,
	Exop,
	EXrd,
	EXrs,
	EXrt,
	OLDA,
	OLDB
);


input wire	EXStall;
input wire	[31:0] EXA;
input wire	[31:0] EXB;
input wire	[31:0] Forward_MEM;
input wire	[31:0] Forward_WB;
input wire	[1:0] ForwardA_EX;
input wire	[1:0] ForwardB_EX;
input wire	[31:0] Instruction;
output wire	[31:0] EXALUB;
output wire	[31:0] EXALUOut;
output wire	[31:0] EXIR;
output wire	[5:0] Exop;
output wire	[4:0] EXrd;
output wire	[4:0] EXrs;
output wire	[4:0] EXrt;
output wire	[31:0] OLDA;
output wire	[31:0] OLDB;

wire	[4:0] ALUOp;
wire	[31:0] EXALUBwire;
wire	[31:0] EXIROUT;
wire	EXopisADDI;
wire	EXopisLW;
wire	EXopisLWorSWorADDI;
wire	EXopisSW;
wire	[31:0] Lower16BitsSignExtended;
wire	[31:0] OLDAwire;
wire	[31:0] OLDBwire;
wire	[31:0] Temp;
wire	[31:0] TheConstant0;
wire	wire_to_ground;
wire	wire_to_ground2;





MUX3_32	b2v_AMUX(
	.A(EXA),
	.B(Forward_MEM),
	.C(Forward_WB),
	.S(ForwardA_EX),
	.Y(OLDAwire));


MUX3_32	b2v_BMUX(
	.A(EXB),
	.B(Forward_MEM),
	.C(Forward_WB),
	.S(ForwardB_EX),
	.Y(EXALUBwire));


MUX2_32	b2v_EXIROUTMUX(
	.S(EXStall),
	.A(Temp),
	.B(TheConstant0),
	.Y(EXIROUT));


ALU32	b2v_inst(
	.A(OLDAwire),
	.alu_op(ALUOp),
	.B(OLDBwire),
	.Overflow(wire_to_ground),
	.eq(wire_to_ground2),
	.Result(EXALUOut));

assign	EXopisLWorSWorADDI = EXopisSW | EXopisADDI | EXopisLW;


ADDI	b2v_isADDI(
	.Op(EXIROUT[31:26]),
	.addi_output(EXopisADDI));


LW	b2v_isLW(
	.Op(EXIROUT[31:26]),
	.Y(EXopisLW));


SW	b2v_isSW(
	.Op(EXIROUT[31:26]),
	.Y(EXopisSW));


ALUCtl	b2v_myALUCtl(
	.Functcode(EXIROUT[5:0]),
	.Opcode(Temp[31:26]),
	.ALUOp(ALUOp));


Grounder	b2v_myGrounder(
	.Input_To_Ground(wire_to_ground));


Grounder	b2v_myGrounder2(
	.Input_To_Ground(wire_to_ground2));


MUX2_32	b2v_OLDBMUX(
	.S(EXopisLWorSWorADDI),
	.A(EXALUBwire),
	.B(Lower16BitsSignExtended),
	.Y(OLDBwire));


SE16_32	b2v_SignExtend(
	.A(EXIROUT[15:0]),
	.Y(Lower16BitsSignExtended));


Zero	b2v_Value0(
	.Zero(TheConstant0));

assign	EXALUB = EXALUBwire;
assign	Temp = Instruction;
assign	EXIR = EXIROUT;
assign	Exop[5:0] = EXIROUT[31:26];
assign	EXrd[4:0] = Temp[15:11];
assign	EXrs[4:0] = Temp[25:21];
assign	EXrt[4:0] = Temp[20:16];
assign	OLDA = OLDAwire;
assign	OLDB = OLDBwire;

endmodule
