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
// CREATED		"Tue Feb  2 08:01:19 2021"

module MEMWBTower(
	reset,
	clk,
	MEMIR,
	MEMValue,
	WBIR,
	WBValue
);


input wire	reset;
input wire	clk;
input wire	[31:0] MEMIR;
input wire	[31:0] MEMValue;
output wire	[31:0] WBIR;
output wire	[31:0] WBValue;






Flopr_32	b2v_IR_REG(
	.reset(reset),
	.clk(clk),
	.D(MEMIR),
	.Q(WBIR));


Flopr_32	b2v_Value_REG(
	.reset(reset),
	.clk(clk),
	.D(MEMValue),
	.Q(WBValue));


endmodule
