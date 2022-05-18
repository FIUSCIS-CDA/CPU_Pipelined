`timescale 1ps / 1ps

// NO CLOCK NECESSARY
// RUN LONG ENOUGH TO COVER ALL TESTS
// AS OF NOW 500 IS ENOUGH

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
   parameter BNE = 6'b000101;
   parameter J = 6'b000010;
   parameter ADDI = 6'b001000;
   parameter SLTI = 6'b001010;
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
         $display("[ERROR] Expected a stall");
      end
      else
      begin
	      $display("[PASS]");
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


StallDetection stallDetector(EXop, EXrd, EXrs, EXrt, IDop, IDrs, IDrt, MEMop, MEMrt, IDstall, EXstall);
   
   initial begin

   $display("[IDSTALL] IDop=BEQ, EXop=RTYPE, EXrd=IDrs");
   setupStall(IDop, BEQ, EXop, RTYPE, EXrd, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, EXop=RTYPE, EXrd=IDrt");
   setupStall(IDop, BEQ, EXop, RTYPE, EXrd, IDrt); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, EXop=LW, EXrt=IDrs");
   setupStall(IDop, BEQ, EXop, LW, EXrt, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, EXop=LW, EXrt=IDrt");
   setupStall(IDop, BEQ, EXop, LW, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, EXop=ADDI, EXrt=IDrs");
   setupStall(IDop, BEQ, EXop, ADDI, EXrt, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, EXop=ADDI, EXrt=IDrt");
   setupStall(IDop, BEQ, EXop, ADDI, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, MEMop=LW, MEMrt=IDrs");
   setupStall(IDop, BEQ, MEMop, LW, MEMrt, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BEQ, MEMop=LW, MEMrt=IDrt");
   setupStall(IDop, BEQ, MEMop, LW, MEMrt, IDrt); #10;
   checkStall(IDstall); #10;
 
   $display("[IDSTALL] IDop=BEQ, EXop=SLTI, EXrt=IDrs");
   setupStall(IDop, BEQ, EXop, SLTI, EXrt, IDrs); #10;
   checkStall(IDstall); #10;
   
   $display("[IDSTALL] IDop=BEQ, EXop=SLTI, EXrt=IDrt");
   setupStall(IDop, BEQ, EXop, SLTI, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

/////

   $display("[IDSTALL] IDop=BNE, EXop=RTYPE, EXrd=IDrs");
   setupStall(IDop, BNE, EXop, RTYPE, EXrd, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, EXop=RTYPE, EXrd=IDrt");
   setupStall(IDop, BNE, EXop, RTYPE, EXrd, IDrt); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, EXop=LW, EXrt=IDrs");
   setupStall(IDop, BNE, EXop, LW, EXrt, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, EXop=LW, EXrt=IDrt");
   setupStall(IDop, BNE, EXop, LW, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, EXop=ADDI, EXrt=IDrs");
   setupStall(IDop, BNE, EXop, ADDI, EXrt, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, EXop=ADDI, EXrt=IDrt");
   setupStall(IDop, BNE, EXop, ADDI, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, MEMop=LW, MEMrt=IDrs");
   setupStall(IDop, BNE, MEMop, LW, MEMrt, IDrs); #10;
   checkStall(IDstall); #10;

   $display("[IDSTALL] IDop=BNE, MEMop=LW, MEMrt=IDrt");
   setupStall(IDop, BNE, MEMop, LW, MEMrt, IDrt); #10;
   checkStall(IDstall); #10;
   
   $display("[IDSTALL] IDop=BNE, EXop=SLTI, EXrt=IDrs");
   setupStall(IDop, BNE, EXop, SLTI, EXrt, IDrs); #10;
   checkStall(IDstall); #10;
   
   $display("[IDSTALL] IDop=BNE, EXop=SLTI, EXrt=IDrt");
   setupStall(IDop, BNE, EXop, SLTI, EXrt, IDrt); #10;
   checkStall(IDstall); #10;

////

   $display("[EXSTALL] MEMop=LW, EXop=RTYPE, MEMrt=EXrs");
   setupStall(MEMop, LW, EXop, RTYPE, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   $display("[EXSTALL] MEMop=LW, EXop=RTYPE, MEMrt=EXrt");
   setupStall(MEMop, LW, EXop, RTYPE, MEMrt, EXrt); #10;
   checkStall(EXstall); #10;

   $display("[EXSTALL] MEMop=LW, EXop=LW, MEMrt=EXrs");
   setupStall(MEMop, LW, EXop, LW, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   $display("[EXSTALL] MEMop=LW, EXop=SW, MEMrt=EXrs");
   setupStall(MEMop, LW, EXop, SW, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   $display("[EXSTALL] MEMop=LW, EXop=ADDI, MEMrt=EXrs");
   setupStall(MEMop, LW, EXop, ADDI, MEMrt, EXrs); #10;
   checkStall(EXstall); #10;

   $display("[EXSTALL] MEMop=LW, EXop=SLTI, MEMrt=EXrs");
   setupStall(MEMop, LW, EXop, SLTI, MEMrt, EXrs); #10;
   checkStall (EXstall); #10;

   //$display("[ALL TESTS PASS]");

   end


endmodule
