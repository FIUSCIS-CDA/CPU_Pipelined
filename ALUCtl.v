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
// CREATED		"Tue Feb  2 08:00:57 2021"

module ALUCtl(
	Functcode,
	Opcode,
	ALUOp
);


input wire	[5:0] Functcode;
input wire	[5:0] Opcode;
output wire	[4:0] ALUOp;

wire	ADDIinstruction;
wire	ADDinstruction;
wire	[4:0] ALUOp_ALTERA_SYNTHESIZED;
wire	LWinstruction;
wire	ORinstruction;
wire	SLTinstruction;
wire	SUBinstruction;
wire	SWinstruction;





assign	ALUOp_ALTERA_SYNTHESIZED[1] = LWinstruction | ADDinstruction | SWinstruction | SUBinstruction | SLTinstruction | ADDIinstruction;

assign	ALUOp_ALTERA_SYNTHESIZED[0] = ORinstruction | SLTinstruction;

assign	ALUOp_ALTERA_SYNTHESIZED[3] = SLTinstruction | SUBinstruction;


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
