`timescale 1ps / 1ps

module testbench();
  reg[5:0] IDop, EXop, MEMop;
  reg[4:0] EXrd, EXrs, EXrt, IDrs, IDrt, MEMrt;
  wire IDstall, EXstall;

   ///////////////////////////////////////
   // SUPPORTED OPCODES
   parameter LW = 6'b100011;
   parameter SW = 6'b101011;
   parameter RTYPE = 6'b000000;
   parameter BEQ = 6'b000100;
   parameter J = 6'b000010;
   parameter ADDI = 6'b001000;
   ///////////////////////////////////////

task initialState;
   begin
   // Initial state, opcodes all zero, registers all different
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

task checkStall;
   input thestall;

   begin
      if (thestall !== 1)
      begin 
         $display("[ERROR] Expected a stall\n");
      end
   end
endtask

task setupStall;
   output [6:0] op1;
   input [6:0] opcode1;
   output [6:0] op2;
   input [6:0] opcode2;
   output [5:0] reg1;
   output [5:0] reg2;

begin
   initialState; #10;
   op1 = opcode1; op2=opcode2; reg1=5'b10101; reg2=5'b10101; #10;     
end
endtask

/*task lala;

begin
      // Begin by setting everything to different values
      
      
end

endtask*/

StallDetection stallDetector(EXop, EXrd, EXrs, EXrt, IDop, IDrs, IDrt, MEMop, MEMrt, IDstall, EXstall);
   
   initial begin
 
   setupStall(IDop, BEQ, EXop, RTYPE, EXrd, IDrs); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, EXop, RTYPE, EXrd, IDrt); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, EXop, LW, EXrt, IDrs); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, EXop, LW, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, EXop, ADDI, EXrt, IDrs); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, EXop, ADDI, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, MEMop, LW, MEMrt, IDrs); #10;
   checkStall(IDstall); #10;

   setupStall(IDop, BEQ, MEMop, LW, MEMrt, IDrt); #10;
   checkStall(IDstall); #10;

   

   setupStall(MEMop, LW, EXop, RTYPE, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   setupStall(MEMop, LW, EXop, RTYPE, MEMrt, EXrt); #10;
   checkStall(EXstall); #10;

   setupStall(MEMop, LW, EXop, LW, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   setupStall(MEMop, LW, EXop, SW, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   setupStall(MEMop, LW, EXop, ADDI, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;
      
      $display("All tests passed.\n");

   end


endmodule