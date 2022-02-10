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
// CREATED		"Thu Feb 10 13:05:34 2022"

module BNE(
	Op,
	Y
);


input wire	[31:26] Op;
output wire	Y;

wire	NOTOp27;
wire	NOTOp29;
wire	NOTOp30;
wire	NOTOp31;




assign	Y = NOTOp29 & NOTOp31 & NOTOp30 & Op[28] & NOTOp27 & Op[26];

assign	NOTOp30 =  ~Op[30];

assign	NOTOp29 =  ~Op[29];

assign	NOTOp27 =  ~Op[27];

assign	NOTOp31 =  ~Op[31];


endmodule
