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
// CREATED		"Tue Dec 20 13:30:34 2022"

module ALUCtl(
	Functcode,
	Opcode,
	ALUSLL,
	ALUOp
);


input wire	[5:0] Functcode;
input wire	[5:0] Opcode;
output wire	ALUSLL;
output wire	[4:0] ALUOp;

wire	ADDIinstruction;
wire	ADDinstruction;
wire	[4:0] ALUOp_ALTERA_SYNTHESIZED;
wire	LWinstruction;
wire	ORinstruction;
wire	SLTinstruction;
wire	SUBinstruction;
wire	SWinstruction;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_12;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;






SLTI	b2v_inst1(
	.Op(Opcode),
	.slti_output(SYNTHESIZED_WIRE_18));

assign	SYNTHESIZED_WIRE_3 = LWinstruction | ADDinstruction | SWinstruction | SUBinstruction | SLTinstruction | ADDIinstruction;

assign	SYNTHESIZED_WIRE_12 =  ~Opcode[3];

assign	SYNTHESIZED_WIRE_15 =  ~Opcode[2];

assign	SYNTHESIZED_WIRE_16 =  ~Opcode[1];

assign	SYNTHESIZED_WIRE_17 =  ~Opcode[0];

assign	SYNTHESIZED_WIRE_7 =  ~Functcode[5];

assign	SYNTHESIZED_WIRE_11 =  ~Functcode[0];

assign	SYNTHESIZED_WIRE_8 =  ~Functcode[4];

assign	SYNTHESIZED_WIRE_6 =  ~Functcode[3];

assign	SYNTHESIZED_WIRE_9 =  ~Functcode[2];

assign	ALUOp_ALTERA_SYNTHESIZED[3] = SLTinstruction | SYNTHESIZED_WIRE_18 | SUBinstruction;

assign	SYNTHESIZED_WIRE_10 =  ~Functcode[1];

assign	ALUOp_ALTERA_SYNTHESIZED[0] = SYNTHESIZED_WIRE_18 | ORinstruction | SLTinstruction;

assign	ALUOp_ALTERA_SYNTHESIZED[1] = SYNTHESIZED_WIRE_18 | SYNTHESIZED_WIRE_3;

assign	ALUSLL = SYNTHESIZED_WIRE_4 & SYNTHESIZED_WIRE_5;

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_6 & SYNTHESIZED_WIRE_7 & SYNTHESIZED_WIRE_8 & SYNTHESIZED_WIRE_9 & SYNTHESIZED_WIRE_10 & SYNTHESIZED_WIRE_11;

assign	SYNTHESIZED_WIRE_4 = SYNTHESIZED_WIRE_12 & SYNTHESIZED_WIRE_13 & SYNTHESIZED_WIRE_14 & SYNTHESIZED_WIRE_15 & SYNTHESIZED_WIRE_16 & SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_13 =  ~Opcode[5];

assign	SYNTHESIZED_WIRE_14 =  ~Opcode[4];


ADD	b2v_isADD(
	.Funct(Functcode),
	.Op(Opcode),
	.Y(ADDinstruction));


ADDI	b2v_isADDI(
	.Op(Opcode),
	.addi_output(ADDIinstruction));


LW	b2v_isLW(
	.Op(Opcode),
	.Y(LWinstruction));


ORR	b2v_isOR(
	.Funct(Functcode),
	.Op(Opcode),
	.Y(ORinstruction));


SLT	b2v_isSLT(
	.Funct(Functcode),
	.Op(Opcode),
	.Y(SLTinstruction));


SUB	b2v_isSUB(
	.Funct(Functcode),
	.Op(Opcode),
	.Y(SUBinstruction));


SW	b2v_isSW(
	.Op(Opcode),
	.Y(SWinstruction));


SameBit	b2v_sameBitBlock(
	.Ain(ALUOp_ALTERA_SYNTHESIZED[3]),
	.Aout(ALUOp_ALTERA_SYNTHESIZED[2]));

assign	ALUOp = ALUOp_ALTERA_SYNTHESIZED;
assign	ALUOp_ALTERA_SYNTHESIZED[4] = 0;

endmodule
