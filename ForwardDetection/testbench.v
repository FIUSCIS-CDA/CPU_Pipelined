//////////////////////////////////////////////////////////////
// Testbench for Component: ForwardDetection
// Package: FIUSCIS-CDA
// Course: CDA3102 (Computer Architecture), Florida International University
// Developer: Trevor Cickovski
// Extended By: CDA3102 students
// License: MIT, (C) 2020-2022 All Rights Reserved
///////////////////////////////////////////////////////////////////////////////////

module testbench();
`include "../../Test/Test.v"
///////////////////////////////////////////////////////////////////////////////////
// Inputs: MEMop, WBop (6-bit)
//         EXrd, EXrs, EXrt, IDs, IDrt, MEMrt,
//         MEMrd, WBrt, WBrd, MEMrs, WBrs (5-bit)
  reg[5:0] MEMop, WBop;
  reg[4:0] EXrd, EXrs, EXrt, IDrs, IDrt, MEMrt, MEMrd, WBrt, WBrd, MEMrs, WBrs;
///////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// Outputs: forwardBfromWBtoID, forwardBfromWBtoEX, forwardBfromMEMtoID, forwardBfromMEMtoEX,
// forwardAfromWBtoID, forwardAfromWBtoEX, forwardAfromMEMtoID, forwardAfromMEMtoEX (1 bit) 
  wire forwardBfromWBtoID, forwardBfromWBtoEX, forwardBfromMEMtoID, forwardBfromMEMtoEX;
  wire forwardAfromWBtoID, forwardAfromWBtoEX, forwardAfromMEMtoID, forwardAfromMEMtoEX;
/////////////////////////////////////////////////////////////////////////////////////////////

   ///////////////////////////////////////
   // SUPPORTED OPCODES
   parameter LW = 6'b100011;
   parameter SW = 6'b101011;
   parameter RTYPE = 6'b000000;
   parameter BEQ = 6'b000100;
   parameter J = 6'b000010;
   parameter ADDI = 6'b001000;
   parameter BNE = 6'b000101;
   parameter SLTI = 6'b001010;
   ///////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// ROUTINE TO SET INITIAL STATE
// OPCODES ALL ZERO
// REGISTERS ALL DIFFERENT
task initialState;
   begin
      WBop = 6'b000000;
      MEMop = 6'b000000;      
      EXrd = 5'b00001;
      EXrs = 5'b00010;
      EXrt = 5'b00011;
      IDrs = 5'b00100;
      IDrt = 5'b00101;
      MEMrt = 5'b00110;
      MEMrd = 5'b00111;
      WBrt = 5'b01000;
      WBrd = 5'b01001;
   end
endtask
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// ROUTINE TO SETUP A FORWARD (TOTAL TIME: 10)
// GO BACK TO INITIAL STATE
// THEN SET WIRES TO PASSED VALUES
task setupForward;
   output [6:0] op1;
   input [6:0] opcode1;
   output [5:0] reg1;
   output [5:0] reg2;

begin
   initialState; #10;
   op1 = opcode1; reg1=5'b10101; reg2=5'b10101;      
end
endtask
///////////////////////////////////////////////////////////////////////////


ForwardAfromMEMtoEX unit0(.EXrd(EXrd),.EXrs(EXrs),.EXrt(EXrt),.MEMop(MEMop),
                          .MEMrd(MEMrd),.MEMrs(MEMrs),.MEMrt(MEMrt),.Y(forwardAfromMEMtoEX));
ForwardAfromMEMtoID unit1(.IDrs(IDrs),.IDrt(IDrt),.MEMop(MEMop),.MEMrd(MEMrd),
                          .MEMrs(MEMrs),.MEMrt(MEMrt),.Y(forwardAfromMEMtoID));
ForwardAfromWBtoEX unit2(.EXrd(EXrd),.EXrs(EXrs),.EXrt(EXrt),.WBop(WBop),
                         .WBrd(WBrd),.WBrs(WBrs),.WBrt(WBrt),.Y(forwardAfromWBtoEX));
ForwardAfromWBtoID unit3(.IDrs(IDrs),.IDrt(IDrt),.WBop(WBop),.WBrd(WBrd),
                         .WBrs(WBrs),.WBrt(WBrt),.Y(forwardAfromWBtoID));
ForwardBfromMEMtoEX unit4(.EXrd(EXrd),.EXrs(EXrs),.EXrt(EXrt),.MEMop(MEMop),
                          .MEMrd(MEMrd),.MEMrs(MEMrs),.MEMrt(MEMrt),.Y(forwardBfromMEMtoEX));
ForwardBfromMEMtoID unit5(.IDrs(IDrs),.IDrt(IDrt),.MEMop(MEMop),.MEMrd(MEMrd),
                          .MEMrs(MEMrs),.MEMrt(MEMrt),.Y(forwardBfromMEMtoID));
ForwardBfromWBtoEX unit6(.EXrd(EXrd),.EXrs(EXrs),.EXrt(EXrt),.WBop(WBop),
                         .WBrd(WBrd),.WBrs(WBrs),.WBrt(WBrt),.Y(forwardBfromWBtoEX));
ForwardBfromWBtoID unit7(.IDrs(IDrs),.IDrt(IDrt),.WBop(WBop),.WBrd(WBrd),
                         .WBrs(WBrs),.WBrt(WBrt),.Y(forwardBfromWBtoID));
   
   initial begin
   ////////////////////////////////////////////////////////////////////
   // Each test is 20 time units total
   ///////////////////////////////////////////////////////////////////
   // A, MEM->ID
   $display("[A, MEM->ID] MEMop=RTYPE, MEMrd=IDrs");
   setupForward(MEMop, RTYPE, MEMrd, IDrs); #10;
   verifyEqual(forwardAfromMEMtoID, 1); 

   $display("[A, MEM->ID] MEMop=ADDI, MEMrt=IDrs");
   setupForward(MEMop, ADDI, MEMrt, IDrs); #10;
   verifyEqual(forwardAfromMEMtoID, 1);

   $display("[A, MEM->ID] MEMop=SLTI, MEMrt=IDrs");
   setupForward(MEMop, SLTI, MEMrt, IDrs); #10;
   verifyEqual(forwardAfromMEMtoID, 1); 
   ///////////////////////////////////////////////////////////////////

   ///////////////////////////////////////////////////////////////////
   // A, WB->ID
   $display("[A, WB->ID] WBop=RTYPE, WBrd=IDrs");
   setupForward(WBop, RTYPE, WBrd, IDrs); #10;
   verifyEqual(forwardAfromWBtoID, 1); 

   $display("[A, WB->ID] WBop=ADDI, WBrt=IDrs");
   setupForward(WBop, ADDI, WBrt, IDrs); #10;
   verifyEqual(forwardAfromWBtoID, 1); 

   $display("[A, WB->ID] WBop=LW, WBrt=IDrs");
   setupForward(WBop, LW, WBrt, IDrs); #10;
   verifyEqual(forwardAfromWBtoID, 1); 

   $display("[A, WB->ID] WBop=SLTI, WBrt=IDrs");
   setupForward(WBop, SLTI, WBrt, IDrs); #10;
   verifyEqual(forwardAfromWBtoID, 1); 
   ///////////////////////////////////////////////////////////////////
   
   ///////////////////////////////////////////////////////////////////
   // B, MEM->ID
   $display("[B, MEM->ID] MEMop=RTYPE, MEMrd=IDrt");
   setupForward(MEMop, RTYPE, MEMrd, IDrt); #10;
   verifyEqual(forwardBfromMEMtoID, 1); 

   $display("[B, MEM->ID] MEMop=ADDI, MEMrt=IDrt");
   setupForward(MEMop, ADDI, MEMrt, IDrt); #10;
   verifyEqual(forwardBfromMEMtoID, 1); 

   $display("[B, MEM->ID] MEMop=SLTI, MEMrt=IDrt");
   setupForward(MEMop, SLTI, MEMrt, IDrt); #10;
   verifyEqual(forwardBfromMEMtoID, 1); 
   ///////////////////////////////////////////////////////////////////

   ///////////////////////////////////////////////////////////////////
   // B, WB->ID
   $display("[B, WB->ID] WBop=RTYPE, WBrd=IDrt");
   setupForward(WBop, RTYPE, WBrd, IDrt); #10;
   verifyEqual(forwardBfromWBtoID, 1); 

   $display("[B, WB->ID] WBop=ADDI, WBrt=IDrt");
   setupForward(WBop, ADDI, WBrt, IDrt); #10;
   verifyEqual(forwardBfromWBtoID, 1); 

   $display("[B, WB->ID] WBop=LW, WBrt=IDrt");
   setupForward(WBop, LW, WBrt, IDrt); #10;
   verifyEqual(forwardBfromWBtoID, 1); 

   $display("[B, WB->ID] WBop=SLTI, WBrt=IDrt");
   setupForward(WBop, SLTI, WBrt, IDrt); #10;
   verifyEqual(forwardBfromWBtoID, 1); 
   ///////////////////////////////////////////////////////////////////


   ///////////////////////////////////////////////////////////////////
   // A, MEM->EX
   $display("[A, MEM->EX] MEMop=RTYPE, MEMrd=EXrs");
   setupForward(MEMop, RTYPE, MEMrd, EXrs); #10;
   verifyEqual(forwardAfromMEMtoEX, 1); 

   $display("[A, MEM->EX] MEMop=ADDI, MEMrt=EXrs");
   setupForward(MEMop, ADDI, MEMrt, EXrs); #10;
   verifyEqual(forwardAfromMEMtoEX, 1); 

   $display("[A, MEM->EX] MEMop=SLTI, MEMrt=EXrs");
   setupForward(MEMop, SLTI, MEMrt, EXrs); #10;
   verifyEqual(forwardAfromMEMtoEX, 1); 
   //////////////////////////////////////////////////////////////////
   
   //////////////////////////////////////////////////////////////////
   // A, WB->EX
   $display("[A, WB->EX] WBop=RTYPE, WBrd=EXrs");
   setupForward(WBop, RTYPE, WBrd, EXrs); #10;
   verifyEqual(forwardAfromWBtoEX, 1); 

   $display("[A, WB->EX] WBop=ADDI, WBrt=EXrs");
   setupForward(WBop, ADDI, WBrt, EXrs); #10;
   verifyEqual(forwardAfromWBtoEX, 1); 

   $display("[A, WB->EX] WBop=LW, WBrt=EXrs");
   setupForward(WBop, LW, WBrt, EXrs); #10;
   verifyEqual(forwardAfromWBtoEX, 1); 

   $display("[A, WB->EX] WBop=SLTI, WBrt=EXrs");
   setupForward(WBop, SLTI, WBrt, EXrs); #10;
   verifyEqual(forwardAfromWBtoEX, 1); 
   /////////////////////////////////////////////////////////////////

   /////////////////////////////////////////////////////////////////
   // B, MEM->EX
   $display("[A, MEM->EX] MEMop=RTYPE, MEMrd=EXrt");
   setupForward(MEMop, RTYPE, MEMrd, EXrt); #10;
   verifyEqual(forwardBfromMEMtoEX, 1); 

   $display("[A, MEM->EX] MEMop=ADDI, MEMrt=EXrt");
   setupForward(MEMop, ADDI, MEMrt, EXrt); #10;
   verifyEqual(forwardBfromMEMtoEX, 1); 

   $display("[A, MEM->EX] MEMop=SLTI, MEMrt=EXrt");
   setupForward(MEMop, SLTI, MEMrt, EXrt); #10;
   verifyEqual(forwardBfromMEMtoEX, 1); 
   /////////////////////////////////////////////////////////////////

   /////////////////////////////////////////////////////////////////
   // B, WB->EX
   $display("[A, WB->EX] WBop=RTYPE, WBrd=EXrt");
   setupForward(WBop, RTYPE, WBrd, EXrt); #10;
   verifyEqual(forwardBfromWBtoEX, 1); 

   $display("[A, WB->EX] WBop=ADDI, WBrt=EXrt");
   setupForward(WBop, ADDI, WBrt, EXrt); #10;
   verifyEqual(forwardBfromWBtoEX, 1); 

   $display("[A, WB->EX] WBop=LW, WBrt=EXrt");
   setupForward(WBop, LW, WBrt, EXrt); #10;
   verifyEqual(forwardBfromWBtoEX, 1); 

   $display("[A, WB->EX] WBop=SLTI, WBrt=EXrt");
   setupForward(WBop, SLTI, WBrt, EXrt); #10;
   verifyEqual(forwardBfromWBtoEX, 1);
   /////////////////////////////////////////////////////////////////

      
      $display("All tests passed.");

   end


endmodule
