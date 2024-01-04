#### MODULE NAME
       CPU_PipeLined

#### DEPENDENCIES
       SameBit,  MUX2,  Flopr_32, Flopenr_32, Flopr, DSwitch, MUX2_5, MUX2_32,
       Four,  SE16_32,  SL2_32,  RF,  Flopenr,  DESwitch,  MUX4_32,   MUX3_32,
       MUX32_32,  MUX32,  Decoder_32, MUX4, MUX3, ALU_32, IM, DM_synch, SPLICE_PCJ, 
       ALUBit31, ALUBits0To30, OneBitAdder, INC4_32, Adder_32, Grounder, OverflowDetection,
       Sixteen

#### INPUTS
Name  | Size(Bits)
-------|------------
clk  |     1      
reset |     1   
Strategy  | 2

#### OUTPUTS
Name  | Siae (Bits)
------|------------
PC  | 32
IFIR  | 32
IDIR  | 32
EXIR  | 32
MEMIR | 32
WBIR  | 32

#### DESCRIPTION
       MIPS Five-Stage Pipedlined CPU

       Standard clk and reset inputs; also takes a Branch Prediction Strategy
       (00=Not taken, 01=Taken, 10=Delay Slot)
       Outputs the following information:
       PC: Address of the current Instruction
       IFIR: Instruction in IF state
       IDIR: Instruction in ID state
       EXIR: Instruction in EX state
       MEMIR: Instruction in MEM state
       WBIR: Instruction in WB state

#### SUPPORTED INSTRUCTIONS
       LUI (FA23)
       MFLO (SP23)
       MULT (SP23)
       SLL (FA22)
       SLTI (SP22)
       BNE (SP21)
       ADDI (FA20)
       J
       BEQ
       LW
       SW
       ADD
       SUB
       AND
       OR
       SLT

#### SUPPORTED BRANCH PREDICTION STRATEGIES
       DELAY SLOT (FA20)
       TAKEN (FA20)
       NOT TAKEN


#### AUTHOR
       Alexander T Pastoriza
       Idiel E Guerra
       Trevor Cickovski

#### SEE ALSO
       qms(1), modclone(1)
