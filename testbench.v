//`timescale 1ps / 1ps
module testbench();
// Clock should be set to period=100 to accomodate memory
   reg clk, rst;
   
   localparam CLK_PERIOD = 100;
   
   wire[31:0] PC, IFIR, IDIR, EXIR, MEMIR, WBIR;

   // Third parameter is branch prediction strategy
   // 00=NOT TAKEN 
   // 01=TAKEN 
   // 10=DELAY SLOT (works if the program uses delay slots - the bubble sort below does not)   
   CPU_Pipelined myCPU(rst, clk, 2'b00, EXIR, IDIR, IFIR, MEMIR, PC, WBIR);   // Not Taken
   //CPU_Pipelined myCPU(rst, clk, 2'b01, EXIR, IDIR, IFIR, MEMIR, PC, WBIR);     // Taken
   



   initial begin
      // initialize instruction memory
      myCPU.b2v_IFStage.b2v_MYIM.memory[0] = 'b00100000000100000000001000000000; // addi $s0, $zero, 512
      myCPU.b2v_IFStage.b2v_MYIM.memory[1] = 'b00100000000100010000000000001100; // addi $s1, $zero, 12
      /////////////////////////////////////////////////////////////
      // PUT BUBBLE SORT CODE HERE
      myCPU.b2v_IFStage.b2v_MYIM.memory[2] = 'b00100010001100101111111111111111; // addi $s2, $s1, -1             8
      myCPU.b2v_IFStage.b2v_MYIM.memory[3] = 'b00000000000100100100000000101010; // loop1:   slt $t0, $zero, $s2            16
      myCPU.b2v_IFStage.b2v_MYIM.memory[4] = 'b00010001000000000000000000010000; // beq $t0, $zero, doneloop1               20
      myCPU.b2v_IFStage.b2v_MYIM.memory[5] = 'b00000000000000001001100000100000; // add $s3, $zero, $zero                      24
      myCPU.b2v_IFStage.b2v_MYIM.memory[6] = 'b00000010011100100100100000101010; // loop2:   slt $t1, $s3, $s2              28
      myCPU.b2v_IFStage.b2v_MYIM.memory[7] = 'b00010001001000000000000000001011; // beq $t1, $zero, doneloop2              32
      myCPU.b2v_IFStage.b2v_MYIM.memory[8] = 'b00000010011100110101000000100000; // add $t2, $s3, $s3                      36
      myCPU.b2v_IFStage.b2v_MYIM.memory[9] = 'b00000001010010100101000000100000; // add $t2, $t2, $t2                      40
      myCPU.b2v_IFStage.b2v_MYIM.memory[10] = 'b00000010000010100101100000100000; // add $t3, $s0, $t2                      44
      myCPU.b2v_IFStage.b2v_MYIM.memory[11] = 'b10001101011101000000000000000000; // lw $s4, 0($t3)                         48
      myCPU.b2v_IFStage.b2v_MYIM.memory[12] = 'b10001101011101010000000000000100; // lw $s5, 4($t3)                         52
      myCPU.b2v_IFStage.b2v_MYIM.memory[13] = 'b00000010101101000110000000101010; // slt $t4, $s5, $s4                      56
      myCPU.b2v_IFStage.b2v_MYIM.memory[14] = 'b00010001100000000000000000000010; // beq $t4, $zero, doneif                 60
      myCPU.b2v_IFStage.b2v_MYIM.memory[15] = 'b10101101011101010000000000000000; // sw $s5, 0($t3)                         64
      myCPU.b2v_IFStage.b2v_MYIM.memory[16] = 'b10101101011101000000000000000100; // sw $s4, 4($t3)                         68
      myCPU.b2v_IFStage.b2v_MYIM.memory[17] = 'b00100010011100110000000000000001; // doneif:    addi $s3, $s2, 1            72
      myCPU.b2v_IFStage.b2v_MYIM.memory[18] = 'b00001000000000000000000000000110; // j loop2 //instruction 9                76
      myCPU.b2v_IFStage.b2v_MYIM.memory[19] = 'b00100010010100101111111111111111; //doneloop2: addi $s2, $s2, -1            80
      myCPU.b2v_IFStage.b2v_MYIM.memory[20] = 'b00001000000000000000000000000011; // j loop1 //instruction 6                84 
      myCPU.b2v_IFStage.b2v_MYIM.memory[21] = 'b00000000000000000000000000000000; // doneloop1:
       // doneloop1: 
      // Next instruction, uses myCPU.b2v_MEMStage.b2v_MYDM.memory[4]

      /////////////////////////////////////////////////////////////

      // Constants (Note: addi not supported here)
      myCPU.b2v_MEMStage.b2v_MYDM.memory[500 >> 2] = 512;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[504 >> 2] = 12;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[508 >> 2] = 1;
      // Initializedarray manually
      myCPU.b2v_MEMStage.b2v_MYDM.memory[512 >> 2] = 55;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[516 >> 2] = 88;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[520 >> 2] = 0;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[524 >> 2] = 22;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[528 >> 2] = 77;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[532 >> 2] = 11;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[536 >> 2] = 99;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[540 >> 2] = 33;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[544 >> 2] = 110;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[548 >> 2] = 66;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[552 >> 2] = 121;
      myCPU.b2v_MEMStage.b2v_MYDM.memory[556 >> 2] = 44;
      rst <= 1;  # (CLK_PERIOD/2);
      rst <= 0; 
   end


   // Generate clock
   always @*
   begin
      clk <= 1;       # (CLK_PERIOD/2);
      clk <= 0;       # (CLK_PERIOD/2);
   end
   

  always@(posedge clk)
    begin

        //////////////////////////////////////////////////
        // CHANGE PC VALUE IN THIS IF STATEMENT
        // ADD 4 TIMES THE AMOUNT OF INSTRUCTIONS YOU RUN
        if(PC === 88) begin

        //////////////////////////////////////////////////
        // CHANGE THIS TEST
        // CURRENT TEST ASSUMES YOU SWAPPED THE THIRD AND SIXTH
          if ( 
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[512 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[516 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[516 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[520 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[520 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[524 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[524 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[528 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[528 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[532 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[532 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[536 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[536 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[540 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[540 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[544 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[544 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[548 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[548 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[552 >> 2]) &&
             (myCPU.b2v_MEMStage.b2v_MYDM.memory[552 >> 2] < myCPU.b2v_MEMStage.b2v_MYDM.memory[556 >> 2])  )


 begin
             $display("CPU functional");
             $stop;
          end
          else begin
             $display("CPU not functional");
             $stop;
           end
       end
   end
 
endmodule
