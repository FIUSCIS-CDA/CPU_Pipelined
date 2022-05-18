///////////////////////////////////////////////////////////////////////////////////
// Testbench for Component: StallDetection
// Package: FIUSCIS-CDA
// Course: CDA3102 (Computer Architecture), Florida International University
// Developer: Trevor Cickovski
// Extended By: CDA3102 students
// License: MIT, (C) 2020-2022 All Rights Reserved
///////////////////////////////////////////////////////////////////////////////////

module testbench();
`include "../../Test/Test.v"
///////////////////////////////////////////////////////////////////////////////////
// Inputs: IDop, EXop, MEMop (6-bit)
//         EXrd, EXrs, EXrt, IDs, IDrt, MEMrt (5-bit)
  reg[5:0] IDop, EXop, MEMop;
  reg[4:0] EXrd, EXrs, EXrt, IDrs, IDrt, MEMrt;
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
// Outputs: IDstall, EXstall (1-bit)
  wire IDstall, EXstall;
///////////////////////////////////////////////////////////////////////////////////

   ///////////////////////////////////////
   // SUPPORTED OPCODES
   parameter LW = 6'b100011;
   parameter SW = 6'b101011;
   parameter RTYPE = 6'b000000;
   parameter BEQ = 6'b000100;
   parameter BNE = 6'b000101;
   parameter J = 6'b000010;
   parameter ADDI = 6'b001000;
   parameter SLTI = 6'b001010;
   ///////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// ROUTINE TO SET INITIAL STATE
// OPCODES ALL ZERO
// REGISTERS ALL DIFFERENT
task initialState;
   begin
      IDop = 6'b000000;
      EXop = 6'b000000;
      MEMop = 6'b000000;      
      EXrd = 5'b00001;
      EXrs = 5'b00010;
      EXrt = 5'b00011;
      IDrs = 5'b00100;
      IDrt = 5'b00101;
      MEMrt = 5'b00110;
   end
endtask
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// ROUTINE TO SETUP A STALL (TOTAL TIME: 10)
// GO BACK TO INITIAL STATE
// THEN SET WIRES TO PASSED VALUES
task setupStall;
   input theStall;
   output [6:0] op1;
   input [6:0] opcode1;
   output [6:0] op2;
   input [6:0] opcode2;
   output [5:0] reg1;
   output [5:0] reg2;


begin
   initialState; #10;
   op1 = opcode1; op2=opcode2; reg1=5'b10101; reg2=5'b10101;  
end
endtask
///////////////////////////////////////////////////////////////////////////
	
StallDetection stallDetector(.EXop(EXop), .EXrd(EXrd), .EXrs(EXrs), .EXrt(EXrt), 
                             .IDop(IDop), .IDrs(IDrs), .IDrt(IDrt), 
                             .MEMop(MEMop), .MEMrt(MEMrt), .IDStall(IDstall), .EXStall(EXstall));
   
   initial begin

   ///////////////////////////////////////////////////////////////////////////////
   // IDSTALL TESTS (Time: 20 each)
   $display("[IDSTALL] IDop=BEQ, EXop=RTYPE, EXrd=IDrs");
   setupStall(IDstall, IDop, BEQ, EXop, RTYPE, EXrd, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, EXop=RTYPE, EXrd=IDrt");
   setupStall(IDstall, IDop, BEQ, EXop, RTYPE, EXrd, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, EXop=LW, EXrt=IDrs");
   setupStall(IDstall, IDop, BEQ, EXop, LW, EXrt, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, EXop=LW, EXrt=IDrt");
   setupStall(IDstall, IDop, BEQ, EXop, LW, EXrt, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, EXop=ADDI, EXrt=IDrs");
   setupStall(IDstall, IDop, BEQ, EXop, ADDI, EXrt, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, EXop=ADDI, EXrt=IDrt");
   setupStall(IDstall, IDop, BEQ, EXop, ADDI, EXrt, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, MEMop=LW, MEMrt=IDrs");
   setupStall(IDstall, IDop, BEQ, MEMop, LW, MEMrt, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, MEMop=LW, MEMrt=IDrt");
   setupStall(IDstall, IDop, BEQ, MEMop, LW, MEMrt, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BEQ, EXop=SLTI, EXrt=IDrs");
   setupStall(IDstall, IDop, BEQ, EXop, SLTI, EXrt, IDrs); #10;
   verifyEqual(IDstall, 1);
   
   $display("[IDSTALL] IDop=BEQ, EXop=SLTI, EXrt=IDrt");
   setupStall(IDstall, IDop, BEQ, EXop, SLTI, EXrt, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, EXop=RTYPE, EXrd=IDrs");
   setupStall(IDstall, IDop, BNE, EXop, RTYPE, EXrd, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, EXop=RTYPE, EXrd=IDrt");
   setupStall(IDstall, IDop, BNE, EXop, RTYPE, EXrd, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, EXop=LW, EXrt=IDrs");
   setupStall(IDstall, IDop, BNE, EXop, LW, EXrt, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, EXop=LW, EXrt=IDrt");
   setupStall(IDstall, IDop, BNE, EXop, LW, EXrt, IDrt);  #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, EXop=ADDI, EXrt=IDrs");
   setupStall(IDstall, IDop, BNE, EXop, ADDI, EXrt, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, EXop=ADDI, EXrt=IDrt");
   setupStall(IDstall, IDop, BNE, EXop, ADDI, EXrt, IDrt); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, MEMop=LW, MEMrt=IDrs");
   setupStall(IDstall, IDop, BNE, MEMop, LW, MEMrt, IDrs); #10;
   verifyEqual(IDstall, 1);

   $display("[IDSTALL] IDop=BNE, MEMop=LW, MEMrt=IDrt");
   setupStall(IDstall, IDop, BNE, MEMop, LW, MEMrt, IDrt); #10;
   verifyEqual(IDstall, 1);
   
   $display("[IDSTALL] IDop=BNE, EXop=SLTI, EXrt=IDrs");
   setupStall(IDstall, IDop, BNE, EXop, SLTI, EXrt, IDrs); #10;
   verifyEqual(IDstall, 1);
   
   $display("[IDSTALL] IDop=BNE, EXop=SLTI, EXrt=IDrt");
   setupStall(IDstall, IDop, BNE, EXop, SLTI, EXrt, IDrt); #10;
   verifyEqual(IDstall, 1);
   ///////////////////////////////////////////////////////////////////////////////

   ///////////////////////////////////////////////////////////////////////////////
   // EXSTALL TESTS (Time: 20 each)
   $display("[EXSTALL] MEMop=LW, EXop=RTYPE, MEMrt=EXrs");
   setupStall(EXstall, MEMop, LW, EXop, RTYPE, MEMrt, EXrs); #10;
   verifyEqual(EXstall, 1);

   $display("[EXSTALL] MEMop=LW, EXop=RTYPE, MEMrt=EXrt");
   setupStall(EXstall, MEMop, LW, EXop, RTYPE, MEMrt, EXrt);  #10;
   verifyEqual(EXstall, 1);

   $display("[EXSTALL] MEMop=LW, EXop=LW, MEMrt=EXrs");
   setupStall(EXstall, MEMop, LW, EXop, LW, MEMrt, EXrs); #10;
   verifyEqual(EXstall, 1);

   $display("[EXSTALL] MEMop=LW, EXop=SW, MEMrt=EXrs");
   setupStall(EXstall, MEMop, LW, EXop, SW, MEMrt, EXrs); #10;
   verifyEqual(EXstall, 1);

   $display("[EXSTALL] MEMop=LW, EXop=ADDI, MEMrt=EXrs");
   setupStall(EXstall, MEMop, LW, EXop, ADDI, MEMrt, EXrs); #10;
   verifyEqual(EXstall, 1);

   $display("[EXSTALL] MEMop=LW, EXop=SLTI, MEMrt=EXrs");
   setupStall(EXstall, MEMop, LW, EXop, SLTI, MEMrt, EXrs); #10;
   verifyEqual(EXstall, 1);
   ///////////////////////////////////////////////////////////////////////////////
   $display("All tests passed.");

   end


endmodule
