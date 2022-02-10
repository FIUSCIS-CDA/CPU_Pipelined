`timescale 1ps / 1ps

module testbench();
  reg[5:0] MEMop, WBop;
  reg[4:0] EXrd, EXrs, EXrt, IDrs, IDrt, MEMrt, MEMrd, WBrt, WBrd, MEMrs, WBrs;
  wire forwardBfromWBtoID, forwardBfromWBtoEX, forwardBfromMEMtoID, forwardBfromMEMtoEX;
  wire forwardAfromWBtoID, forwardAfromWBtoEX, forwardAfromMEMtoID, forwardAfromMEMtoEX;

   ///////////////////////////////////////
   // SUPPORTED OPCODES
   parameter LW = 6'b100011;
   parameter SW = 6'b101011;
   parameter RTYPE = 6'b000000;
   parameter BEQ = 6'b000100;
   parameter J = 6'b000010;
   parameter ADDI = 6'b001000;
   parameter BNE = 6'b000101;
   ///////////////////////////////////////

task initialState;
   begin
   // Initial state, opcodes all zero, registers all different
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

task checkForward;
   input theforward;

   begin
      if (theforward !== 1)
      begin 
         $display("[ERROR] Expected a forward\n");
      end
   end
endtask

task setupForward;
   output [6:0] op1;
   input [6:0] opcode1;
   output [5:0] reg1;
   output [5:0] reg2;

begin
   initialState; #10;
   op1 = opcode1; reg1=5'b10101; reg2=5'b10101; #10;     
end
endtask

ForwardAfromMEMtoEX unit0(EXrd,EXrs,EXrt,MEMop,MEMrd,MEMrs,MEMrt,forwardAfromMEMtoEX);
ForwardAfromMEMtoID unit1(IDrs,IDrt,MEMop,MEMrd,MEMrs,MEMrt,forwardAfromMEMtoID);
ForwardAfromWBtoEX unit2(EXrd,EXrs,EXrt,WBop,WBrd,WBrs,WBrt,forwardAfromWBtoEX);
ForwardAfromWBtoID unit3(IDrs,IDrt,WBop,WBrd,WBrs,WBrt,forwardAfromWBtoID);
ForwardBfromMEMtoEX unit4(EXrd,EXrs,EXrt,MEMop,MEMrd,MEMrs,MEMrt,forwardBfromMEMtoEX);
ForwardBfromMEMtoID unit5(IDrs,IDrt,MEMop,MEMrd,MEMrs,MEMrt,forwardBfromMEMtoID);
ForwardBfromWBtoEX unit6(EXrd,EXrs,EXrt,WBop,WBrd,WBrs,WBrt,forwardBfromWBtoEX);
ForwardBfromWBtoID unit7(IDrs,IDrt,WBop,WBrd,WBrs,WBrt,forwardBfromWBtoID);
   
   initial begin
 
   setupForward(WBop, RTYPE, WBrd, IDrt); #10;
   checkForward(forwardBfromWBtoID); #10;

   setupForward(WBop, ADDI, WBrt, IDrt); #10;
   checkForward(forwardBfromWBtoID); #10;

   setupForward(WBop, LW, WBrt, IDrt); #10;
   checkForward(forwardBfromWBtoID); #10;



   setupForward(WBop, RTYPE, WBrd, EXrt); #10;
   checkForward(forwardBfromWBtoEX); #10;

   setupForward(WBop, ADDI, WBrt, EXrt); #10;
   checkForward(forwardBfromWBtoEX); #10;

   setupForward(WBop, LW, WBrt, EXrt); #10;
   checkForward(forwardBfromWBtoEX); #10;


   setupForward(MEMop, RTYPE, MEMrd, IDrt); #10;
   checkForward(forwardBfromMEMtoID); #10;

   setupForward(MEMop, ADDI, MEMrt, IDrt); #10;
   checkForward(forwardBfromMEMtoID); #10;



   setupForward(MEMop, RTYPE, MEMrd, EXrt); #10;
   checkForward(forwardBfromMEMtoEX); #10;

   setupForward(MEMop, ADDI, MEMrt, EXrt); #10;
   checkForward(forwardBfromMEMtoEX); #10;



   setupForward(WBop, RTYPE, WBrd, IDrs); #10;
   checkForward(forwardAfromWBtoID); #10;

   setupForward(WBop, ADDI, WBrt, IDrs); #10;
   checkForward(forwardAfromWBtoID); #10;

   setupForward(WBop, LW, WBrt, IDrs); #10;
   checkForward(forwardAfromWBtoID); #10;



   setupForward(WBop, RTYPE, WBrd, EXrs); #10;
   checkForward(forwardAfromWBtoEX); #10;

   setupForward(WBop, ADDI, WBrt, EXrs); #10;
   checkForward(forwardAfromWBtoEX); #10;

   setupForward(WBop, LW, WBrt, EXrs); #10;
   checkForward(forwardAfromWBtoEX); #10;


   setupForward(MEMop, RTYPE, MEMrd, IDrs); #10;
   checkForward(forwardAfromMEMtoID); #10;

   setupForward(MEMop, ADDI, MEMrt, IDrs); #10;
   checkForward(forwardAfromMEMtoID); #10;



   setupForward(MEMop, RTYPE, MEMrd, EXrs); #10;
   checkForward(forwardAfromMEMtoEX); #10;

   setupForward(MEMop, ADDI, MEMrt, EXrs); #10;
   checkForward(forwardAfromMEMtoEX); #10;












      
      $display("All tests passed.\n");

   end


endmodule