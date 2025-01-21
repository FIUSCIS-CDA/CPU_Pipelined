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
// CREATED		"Tue Jan 21 11:26:45 2025"

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
	EXrm,
	EXrn,
	EXrp,
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
output wire	[31:26] Exop;
output wire	[25:21] EXrm;
output wire	[20:16] EXrn;
output wire	[15:11] EXrp;
output wire	[31:0] OLDA;
output wire	[31:0] OLDB;

wire	[31:0] EXALUBwire;
wire	[31:0] EXIROUT;
wire	EXopisADDI;
wire	EXopisSLTI;
wire	[31:0] OLDAwire;
wire	[31:0] OLDBwire;
wire	[31:0] Temp;
wire	[31:0] TheConstant0;
wire	wire_to_ground;
wire	wire_to_ground2;
wire	[6:0] SYNTHESIZED_WIRE_0;
wire	[4:0] SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_10;
wire	[4:0] SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	[31:0] SYNTHESIZED_WIRE_9;





ALU_32	b2v_ALU32(
	.A(OLDAwire),
	.alu_op(SYNTHESIZED_WIRE_0),
	.B(OLDBwire),
	.H(SYNTHESIZED_WIRE_1),
	.Overflow(wire_to_ground),
	.Zero(wire_to_ground2),
	.Result(EXALUOut));


ALUCtl	b2v_ALUCtlUnit(
	.Functcode(EXIROUT[5:0]),
	.Opcode(EXIROUT[31:26]),
	.ALUOp(SYNTHESIZED_WIRE_0));


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

assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_2 | EXopisADDI | SYNTHESIZED_WIRE_3 | EXopisSLTI | SYNTHESIZED_WIRE_4 | SYNTHESIZED_WIRE_10;


ADDI	b2v_inst2(
	.Op(EXIROUT[31:26]),
	.Y(EXopisADDI));


MUX2_5	b2v_inst3(
	.S(SYNTHESIZED_WIRE_10),
	.A(Temp[10:6]),
	.B(SYNTHESIZED_WIRE_7),
	.Y(SYNTHESIZED_WIRE_1));


Sixteen	b2v_inst5(
	.Y(SYNTHESIZED_WIRE_7));


SLTI	b2v_inst6(
	.Op(EXIROUT[31:26]),
	.Y(EXopisSLTI));


ORI	b2v_inst7(
	.Op(EXIROUT[31:26]),
	.Y(SYNTHESIZED_WIRE_4));


LUI	b2v_inst8(
	.Op(EXIROUT[31:26]),
	.Y(SYNTHESIZED_WIRE_10));


LW	b2v_isLW(
	.Op(EXIROUT[31:26]),
	.Y(SYNTHESIZED_WIRE_2));


SW	b2v_isSW(
	.Op(EXIROUT[31:26]),
	.Y(SYNTHESIZED_WIRE_3));


Grounder	b2v_myGrounder(
	.Input_To_Ground(wire_to_ground));


Grounder	b2v_myGrounder2(
	.Input_To_Ground(wire_to_ground2));


MUX2_32	b2v_OLDBMUX(
	.S(SYNTHESIZED_WIRE_8),
	.A(EXALUBwire),
	.B(SYNTHESIZED_WIRE_9),
	.Y(OLDBwire));


SE16_32	b2v_SignExtend(
	.A(EXIROUT[15:0]),
	.Y(SYNTHESIZED_WIRE_9));


Zero	b2v_Value0(
	.Zero(TheConstant0));

assign	EXALUB = EXALUBwire;
assign	Temp = Instruction;
assign	EXIR = EXIROUT;
assign	Exop[31:26] = EXIROUT[31:26];
assign	EXrm[25:21] = Temp[25:21];
assign	EXrn[20:16] = Temp[20:16];
assign	EXrp[15:11] = Temp[15:11];
assign	OLDA = OLDAwire;
assign	OLDB = OLDBwire;

endmodule
