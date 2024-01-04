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
// CREATED		"Thu Jan 04 12:08:49 2024"

module LUI(
	Op,
	lui_output
);


input wire	[31:26] Op;
output wire	lui_output;

wire	NOTOp30;
wire	NOTOp31;




assign	lui_output = Op[29] & NOTOp31 & NOTOp30 & Op[28] & Op[27] & Op[26];

assign	NOTOp31 =  ~Op[31];

assign	NOTOp30 =  ~Op[30];


endmodule
