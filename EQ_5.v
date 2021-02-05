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
// CREATED		"Tue Feb  2 08:02:53 2021"

module EQ_5(
	A,
	B,
	Y
);


input wire	[4:0] A;
input wire	[4:0] B;
output wire	Y;

wire	Bit0EQ;
wire	Bit1EQ;
wire	Bit2EQ;
wire	Bit3EQ;
wire	Bit4EQ;
wire	Power;




assign	Y = Bit3EQ & Power & Bit4EQ & Bit2EQ & Bit1EQ & Bit0EQ;


assign	Bit4EQ = A[4] ~^ B[4];

assign	Bit3EQ = A[3] ~^ B[3];

assign	Bit2EQ = A[2] ~^ B[2];

assign	Bit1EQ = A[1] ~^ B[1];

assign	Bit0EQ = A[0] ~^ B[0];

assign	Power = 1;

endmodule
