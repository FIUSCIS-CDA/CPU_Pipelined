`timescale 1ps / 1ps
module testbenchBubble();
// Clock should be set to period=100 to accomodate memory
// Total execution time: 85900ps
   reg clk_tb, rst_tb;
   
   localparam CLK_PERIOD = 100;
   
   wire[31:0] PC, IFIR, IDIR, EXIR, MEMIR, WBIR;

   // Third parameter is branch prediction strategy
   // 00=NOT TAKEN (works)
   // 01=TAKEN (does not work yet)
   // 10=DELAY SLOT (works if the program uses delay slots - the bubble sort below does not)   
   CPU_Pipelined myCPU(rst_tb, clk_tb, 'b00, EXIR, IDIR, IFIR, MEMIR, PC, WBIR);
   
   initial begin
      // initialize instruction memory
      myCPU.b2v_inst.b2v_inst.memory[0] = 'b10001100000100000000000111110100; // lw $s0, 500($zero)   # Assume arr=512  0
      myCPU.b2v_inst.b2v_inst.memory[1] = 'b10001100000100010000000111111000; // lw $s1, 504($zero)    # Size (N) is 12  4
      /////////////////////////////////////////////////////////////
      // PUT BUBBLE SORT CODE HERE
      myCPU.b2v_inst.b2v_inst.memory[2] = 'b10001100000011010000000111111100; // lw $t5, 508($zero)                      8
      myCPU.b2v_inst.b2v_inst.memory[3] = 'b00000010001011011001000000100010; // sub $s2, $s1, $t5                     12
      myCPU.b2v_inst.b2v_inst.memory[4] = 'b00000000000100100100000000101010; // loop1:   slt $t0, $zero, $s2            16
      myCPU.b2v_inst.b2v_inst.memory[5] = 'b00010001000000000000000000010000; // beq $t0, $zero, doneloop1               20
      myCPU.b2v_inst.b2v_inst.memory[6] = 'b00000000000000001001100000100000; // add $s3, $zero, $zero                      24
      myCPU.b2v_inst.b2v_inst.memory[7] = 'b00000010011100100100100000101010; // loop2:   slt $t1, $s3, $s2              28
      myCPU.b2v_inst.b2v_inst.memory[8] = 'b00010001001000000000000000001011; // beq $t1, $zero, doneloop2              32
      myCPU.b2v_inst.b2v_inst.memory[9] = 'b00000010011100110101000000100000; // add $t2, $s3, $s3                      36
      myCPU.b2v_inst.b2v_inst.memory[10] = 'b00000001010010100101000000100000; // add $t2, $t2, $t2                      40
      myCPU.b2v_inst.b2v_inst.memory[11] = 'b00000010000010100101100000100000; // add $t3, $s0, $t2                      44
      myCPU.b2v_inst.b2v_inst.memory[12] = 'b10001101011101000000000000000000; // lw $s4, 0($t3)                         48
      myCPU.b2v_inst.b2v_inst.memory[13] = 'b10001101011101010000000000000100; // lw $s5, 4($t3)                         52
      myCPU.b2v_inst.b2v_inst.memory[14] = 'b00000010101101000110000000101010; // slt $t4, $s5, $s4                      56
      myCPU.b2v_inst.b2v_inst.memory[15] = 'b00010001100000000000000000000010; // beq $t4, $zero, doneif                 60
      myCPU.b2v_inst.b2v_inst.memory[16] = 'b10101101011101010000000000000000; // sw $s5, 0($t3)                         64
      myCPU.b2v_inst.b2v_inst.memory[17] = 'b10101101011101000000000000000100; // sw $s4, 4($t3)                         68
      myCPU.b2v_inst.b2v_inst.memory[18] = 'b00000010011011011001100000100000; // doneif:    add $s3, $s3, $t5            72
      myCPU.b2v_inst.b2v_inst.memory[19] = 'b00001000000000000000000000000111; // j loop2 //instruction 9                76
      myCPU.b2v_inst.b2v_inst.memory[20] = 'b00000010010011011001000000100010; //doneloop2: sub $s2, $s2, $t5            80
      myCPU.b2v_inst.b2v_inst.memory[21] = 'b00001000000000000000000000000100; // j loop1 //instruction 6                84
       // doneloop1: 
      // Next instruction, uses myCPU.b2v_inst.b2v_inst.memory[4]

      /////////////////////////////////////////////////////////////

      // Constants (Note: addi not supported here)
      myCPU.b2v_inst5.b2v_inst.memory[500 >> 2] = 512;
      myCPU.b2v_inst5.b2v_inst.memory[504 >> 2] = 12;
      myCPU.b2v_inst5.b2v_inst.memory[508 >> 2] = 1;
      // Initialized array manually
      myCPU.b2v_inst5.b2v_inst.memory[512 >> 2] = 55;
      myCPU.b2v_inst5.b2v_inst.memory[516 >> 2] = 88;
      myCPU.b2v_inst5.b2v_inst.memory[520 >> 2] = 0;
      myCPU.b2v_inst5.b2v_inst.memory[524 >> 2] = 22;
      myCPU.b2v_inst5.b2v_inst.memory[528 >> 2] = 77;
      myCPU.b2v_inst5.b2v_inst.memory[532 >> 2] = 11;
      myCPU.b2v_inst5.b2v_inst.memory[536 >> 2] = 99;
      myCPU.b2v_inst5.b2v_inst.memory[540 >> 2] = 33;
      myCPU.b2v_inst5.b2v_inst.memory[544 >> 2] = 110;
      myCPU.b2v_inst5.b2v_inst.memory[548 >> 2] = 66;
      myCPU.b2v_inst5.b2v_inst.memory[552 >> 2] = 121;
      myCPU.b2v_inst5.b2v_inst.memory[556 >> 2] = 44;

      rst_tb <= 1;  # (CLK_PERIOD/2);
      rst_tb <= 0; 
   end


   // Generate clock
   always @*
   begin
      clk_tb <= 1;       # (CLK_PERIOD/2);
      clk_tb <= 0;       # (CLK_PERIOD/2);
   end
   

  always@(posedge clk_tb)
    begin

        //////////////////////////////////////////////////
        // CHANGE PC VALUE IN THIS IF STATEMENT
        // ADD 4 TIMES THE AMOUNT OF INSTRUCTIONS YOU RUN
        if(myCPU.b2v_inst.b2v_PCREG.Q === 88) begin

        //////////////////////////////////////////////////
        // CHANGE THIS TEST
        // CURRENT TEST ASSUMES YOU SWAPPED THE THIRD AND SIXTH
          if ( 
             (myCPU.b2v_inst5.b2v_inst.memory[512 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[516 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[516 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[520 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[520 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[524 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[524 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[528 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[528 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[532 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[532 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[536 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[536 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[540 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[540 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[544 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[544 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[548 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[548 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[552 >> 2]) &&
             (myCPU.b2v_inst5.b2v_inst.memory[552 >> 2] < myCPU.b2v_inst5.b2v_inst.memory[556 >> 2])  )


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
