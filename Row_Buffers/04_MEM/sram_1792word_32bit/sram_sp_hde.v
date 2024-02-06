/* FE Release Version: 3.4.22 */
/* lang compiler Version: 3.0.4 */
//
//       CONFIDENTIAL AND PROPRIETARY SOFTWARE OF ARM PHYSICAL IP, INC.
//      
//       Copyright (c) 1993 - 2023 ARM Physical IP, Inc.  All Rights Reserved.
//      
//       Use of this Software is subject to the terms and conditions of the
//       applicable license agreement with ARM Physical IP, Inc.
//       In addition, this Software is protected by patents, copyright law 
//       and international treaties.
//      
//       The copyright notice(s) in this Software does not indicate actual or
//       intended publication of this Software.
//
//      Verilog model for Synchronous Single-Port Ram
//
//       Instance Name:              sram_sp_hde
//       Words:                      1792
//       Bits:                       32
//       Mux:                        8
//       Drive:                      6
//       Write Mask:                 Off
//       Write Thru:                 On
//       Extra Margin Adjustment:    On
//       Redundant Rows:             0
//       Redundant Columns:          0
//       Test Muxes                  On
//       Power Gating:               Off
//       Retention:                  On
//       Pipeline:                   Off
//       Weak Bit Test:	        Off
//       Read Disturb Test:	        Off
//       
//       Creation Date:  Mon Nov 27 18:40:08 2023
//       Version: 	r11p2
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v3.0 or v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All buses are modeled [MSB:LSB].  All 
//          ports are padded with Verilog primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
// If ARM_UD_MODEL is defined at Simulator Command Line, it Selects the Fast Functional Model
`ifdef ARM_UD_MODEL

// Following parameter Values can be overridden at Simulator Command Line.

// ARM_UD_DP Defines the delay through Data Paths, for Memory Models it represents BIST MUX output delays.
`ifdef ARM_UD_DP
`else
`define ARM_UD_DP #0.001
`endif
// ARM_UD_CP Defines the delay through Clock Path Cells, for Memory Models it is not used.
`ifdef ARM_UD_CP
`else
`define ARM_UD_CP
`endif
// ARM_UD_SEQ Defines the delay through the Memory, for Memory Models it is used for CLK->Q delays.
`ifdef ARM_UD_SEQ
`else
`define ARM_UD_SEQ #0.01
`endif

`celldefine
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
module sram_sp_hde (VDDCE, VDDPE, VSSE, CENY, WENY, AY, DY, Q, CLK, CEN, WEN, A, D,
    EMA, EMAW, EMAS, TEN, BEN, TCEN, TWEN, TA, TD, TQ, RET1N, STOV);
`else
module sram_sp_hde (CENY, WENY, AY, DY, Q, CLK, CEN, WEN, A, D, EMA, EMAW, EMAS, TEN,
    BEN, TCEN, TWEN, TA, TD, TQ, RET1N, STOV);
`endif

  parameter ASSERT_PREFIX = "";
  parameter BITS = 32;
  parameter WORDS = 1792;
  parameter MUX = 8;
  parameter MEM_WIDTH = 256; // redun block size 4, 128 on left, 128 on right
  parameter MEM_HEIGHT = 224;
  parameter WP_SIZE = 32 ;
  parameter UPM_WIDTH = 3;
  parameter UPMW_WIDTH = 2;
  parameter UPMS_WIDTH = 1;

  output  CENY;
  output  WENY;
  output [10:0] AY;
  output [31:0] DY;
  output [31:0] Q;
  input  CLK;
  input  CEN;
  input  WEN;
  input [10:0] A;
  input [31:0] D;
  input [2:0] EMA;
  input [1:0] EMAW;
  input  EMAS;
  input  TEN;
  input  BEN;
  input  TCEN;
  input  TWEN;
  input [10:0] TA;
  input [31:0] TD;
  input [31:0] TQ;
  input  RET1N;
  input  STOV;
`ifdef POWER_PINS
  inout VDDCE;
  inout VDDPE;
  inout VSSE;
`endif

  integer row_address;
  integer mux_address;
  reg [255:0] mem [0:223];
  reg [255:0] row;
  reg LAST_CLK;
  reg [255:0] row_mask;
  reg [255:0] new_data;
  reg [255:0] data_out;
  reg [63:0] readLatch0;
  reg [63:0] shifted_readLatch0;
  reg  read_mux_sel0;
  reg [31:0] Q_int;
  reg [31:0] Q_int_delayed;
  reg [31:0] writeEnable;

  reg NOT_CEN, NOT_WEN, NOT_A10, NOT_A9, NOT_A8, NOT_A7, NOT_A6, NOT_A5, NOT_A4, NOT_A3;
  reg NOT_A2, NOT_A1, NOT_A0, NOT_D31, NOT_D30, NOT_D29, NOT_D28, NOT_D27, NOT_D26;
  reg NOT_D25, NOT_D24, NOT_D23, NOT_D22, NOT_D21, NOT_D20, NOT_D19, NOT_D18, NOT_D17;
  reg NOT_D16, NOT_D15, NOT_D14, NOT_D13, NOT_D12, NOT_D11, NOT_D10, NOT_D9, NOT_D8;
  reg NOT_D7, NOT_D6, NOT_D5, NOT_D4, NOT_D3, NOT_D2, NOT_D1, NOT_D0, NOT_EMA2, NOT_EMA1;
  reg NOT_EMA0, NOT_EMAW1, NOT_EMAW0, NOT_EMAS, NOT_TEN, NOT_TCEN, NOT_TWEN, NOT_TA10;
  reg NOT_TA9, NOT_TA8, NOT_TA7, NOT_TA6, NOT_TA5, NOT_TA4, NOT_TA3, NOT_TA2, NOT_TA1;
  reg NOT_TA0, NOT_TD31, NOT_TD30, NOT_TD29, NOT_TD28, NOT_TD27, NOT_TD26, NOT_TD25;
  reg NOT_TD24, NOT_TD23, NOT_TD22, NOT_TD21, NOT_TD20, NOT_TD19, NOT_TD18, NOT_TD17;
  reg NOT_TD16, NOT_TD15, NOT_TD14, NOT_TD13, NOT_TD12, NOT_TD11, NOT_TD10, NOT_TD9;
  reg NOT_TD8, NOT_TD7, NOT_TD6, NOT_TD5, NOT_TD4, NOT_TD3, NOT_TD2, NOT_TD1, NOT_TD0;
  reg NOT_RET1N, NOT_STOV;
  reg NOT_CLK_PER, NOT_CLK_MINH, NOT_CLK_MINL;
  reg clk0_int;

  wire  CENY_;
  wire  WENY_;
  wire [10:0] AY_;
  wire [31:0] DY_;
  wire [31:0] Q_;
 wire  CLK_;
  wire  CEN_;
  reg  CEN_int;
  reg  CEN_p2;
  wire  WEN_;
  reg  WEN_int;
  wire [10:0] A_;
  reg [10:0] A_int;
  wire [31:0] D_;
  reg [31:0] D_int;
  wire [2:0] EMA_;
  reg [2:0] EMA_int;
  wire [1:0] EMAW_;
  reg [1:0] EMAW_int;
  wire  EMAS_;
  reg  EMAS_int;
  wire  TEN_;
  reg  TEN_int;
  wire  BEN_;
  reg  BEN_int;
  wire  TCEN_;
  reg  TCEN_int;
  reg  TCEN_p2;
  wire  TWEN_;
  reg  TWEN_int;
  wire [10:0] TA_;
  reg [10:0] TA_int;
  wire [31:0] TD_;
  reg [31:0] TD_int;
  wire [31:0] TQ_;
  reg [31:0] TQ_int;
  wire  RET1N_;
  reg  RET1N_int;
  wire  STOV_;
  reg  STOV_int;

  assign CENY = CENY_; 
  assign WENY = WENY_; 
  assign AY[0] = AY_[0]; 
  assign AY[1] = AY_[1]; 
  assign AY[2] = AY_[2]; 
  assign AY[3] = AY_[3]; 
  assign AY[4] = AY_[4]; 
  assign AY[5] = AY_[5]; 
  assign AY[6] = AY_[6]; 
  assign AY[7] = AY_[7]; 
  assign AY[8] = AY_[8]; 
  assign AY[9] = AY_[9]; 
  assign AY[10] = AY_[10]; 
  assign DY[0] = DY_[0]; 
  assign DY[1] = DY_[1]; 
  assign DY[2] = DY_[2]; 
  assign DY[3] = DY_[3]; 
  assign DY[4] = DY_[4]; 
  assign DY[5] = DY_[5]; 
  assign DY[6] = DY_[6]; 
  assign DY[7] = DY_[7]; 
  assign DY[8] = DY_[8]; 
  assign DY[9] = DY_[9]; 
  assign DY[10] = DY_[10]; 
  assign DY[11] = DY_[11]; 
  assign DY[12] = DY_[12]; 
  assign DY[13] = DY_[13]; 
  assign DY[14] = DY_[14]; 
  assign DY[15] = DY_[15]; 
  assign DY[16] = DY_[16]; 
  assign DY[17] = DY_[17]; 
  assign DY[18] = DY_[18]; 
  assign DY[19] = DY_[19]; 
  assign DY[20] = DY_[20]; 
  assign DY[21] = DY_[21]; 
  assign DY[22] = DY_[22]; 
  assign DY[23] = DY_[23]; 
  assign DY[24] = DY_[24]; 
  assign DY[25] = DY_[25]; 
  assign DY[26] = DY_[26]; 
  assign DY[27] = DY_[27]; 
  assign DY[28] = DY_[28]; 
  assign DY[29] = DY_[29]; 
  assign DY[30] = DY_[30]; 
  assign DY[31] = DY_[31]; 
  assign Q[0] = Q_[0]; 
  assign Q[1] = Q_[1]; 
  assign Q[2] = Q_[2]; 
  assign Q[3] = Q_[3]; 
  assign Q[4] = Q_[4]; 
  assign Q[5] = Q_[5]; 
  assign Q[6] = Q_[6]; 
  assign Q[7] = Q_[7]; 
  assign Q[8] = Q_[8]; 
  assign Q[9] = Q_[9]; 
  assign Q[10] = Q_[10]; 
  assign Q[11] = Q_[11]; 
  assign Q[12] = Q_[12]; 
  assign Q[13] = Q_[13]; 
  assign Q[14] = Q_[14]; 
  assign Q[15] = Q_[15]; 
  assign Q[16] = Q_[16]; 
  assign Q[17] = Q_[17]; 
  assign Q[18] = Q_[18]; 
  assign Q[19] = Q_[19]; 
  assign Q[20] = Q_[20]; 
  assign Q[21] = Q_[21]; 
  assign Q[22] = Q_[22]; 
  assign Q[23] = Q_[23]; 
  assign Q[24] = Q_[24]; 
  assign Q[25] = Q_[25]; 
  assign Q[26] = Q_[26]; 
  assign Q[27] = Q_[27]; 
  assign Q[28] = Q_[28]; 
  assign Q[29] = Q_[29]; 
  assign Q[30] = Q_[30]; 
  assign Q[31] = Q_[31]; 
  assign CLK_ = CLK;
  assign CEN_ = CEN;
  assign WEN_ = WEN;
  assign A_[0] = A[0];
  assign A_[1] = A[1];
  assign A_[2] = A[2];
  assign A_[3] = A[3];
  assign A_[4] = A[4];
  assign A_[5] = A[5];
  assign A_[6] = A[6];
  assign A_[7] = A[7];
  assign A_[8] = A[8];
  assign A_[9] = A[9];
  assign A_[10] = A[10];
  assign D_[0] = D[0];
  assign D_[1] = D[1];
  assign D_[2] = D[2];
  assign D_[3] = D[3];
  assign D_[4] = D[4];
  assign D_[5] = D[5];
  assign D_[6] = D[6];
  assign D_[7] = D[7];
  assign D_[8] = D[8];
  assign D_[9] = D[9];
  assign D_[10] = D[10];
  assign D_[11] = D[11];
  assign D_[12] = D[12];
  assign D_[13] = D[13];
  assign D_[14] = D[14];
  assign D_[15] = D[15];
  assign D_[16] = D[16];
  assign D_[17] = D[17];
  assign D_[18] = D[18];
  assign D_[19] = D[19];
  assign D_[20] = D[20];
  assign D_[21] = D[21];
  assign D_[22] = D[22];
  assign D_[23] = D[23];
  assign D_[24] = D[24];
  assign D_[25] = D[25];
  assign D_[26] = D[26];
  assign D_[27] = D[27];
  assign D_[28] = D[28];
  assign D_[29] = D[29];
  assign D_[30] = D[30];
  assign D_[31] = D[31];
  assign EMA_[0] = EMA[0];
  assign EMA_[1] = EMA[1];
  assign EMA_[2] = EMA[2];
  assign EMAW_[0] = EMAW[0];
  assign EMAW_[1] = EMAW[1];
  assign EMAS_ = EMAS;
  assign TEN_ = TEN;
  assign BEN_ = BEN;
  assign TCEN_ = TCEN;
  assign TWEN_ = TWEN;
  assign TA_[0] = TA[0];
  assign TA_[1] = TA[1];
  assign TA_[2] = TA[2];
  assign TA_[3] = TA[3];
  assign TA_[4] = TA[4];
  assign TA_[5] = TA[5];
  assign TA_[6] = TA[6];
  assign TA_[7] = TA[7];
  assign TA_[8] = TA[8];
  assign TA_[9] = TA[9];
  assign TA_[10] = TA[10];
  assign TD_[0] = TD[0];
  assign TD_[1] = TD[1];
  assign TD_[2] = TD[2];
  assign TD_[3] = TD[3];
  assign TD_[4] = TD[4];
  assign TD_[5] = TD[5];
  assign TD_[6] = TD[6];
  assign TD_[7] = TD[7];
  assign TD_[8] = TD[8];
  assign TD_[9] = TD[9];
  assign TD_[10] = TD[10];
  assign TD_[11] = TD[11];
  assign TD_[12] = TD[12];
  assign TD_[13] = TD[13];
  assign TD_[14] = TD[14];
  assign TD_[15] = TD[15];
  assign TD_[16] = TD[16];
  assign TD_[17] = TD[17];
  assign TD_[18] = TD[18];
  assign TD_[19] = TD[19];
  assign TD_[20] = TD[20];
  assign TD_[21] = TD[21];
  assign TD_[22] = TD[22];
  assign TD_[23] = TD[23];
  assign TD_[24] = TD[24];
  assign TD_[25] = TD[25];
  assign TD_[26] = TD[26];
  assign TD_[27] = TD[27];
  assign TD_[28] = TD[28];
  assign TD_[29] = TD[29];
  assign TD_[30] = TD[30];
  assign TD_[31] = TD[31];
  assign TQ_[0] = TQ[0];
  assign TQ_[1] = TQ[1];
  assign TQ_[2] = TQ[2];
  assign TQ_[3] = TQ[3];
  assign TQ_[4] = TQ[4];
  assign TQ_[5] = TQ[5];
  assign TQ_[6] = TQ[6];
  assign TQ_[7] = TQ[7];
  assign TQ_[8] = TQ[8];
  assign TQ_[9] = TQ[9];
  assign TQ_[10] = TQ[10];
  assign TQ_[11] = TQ[11];
  assign TQ_[12] = TQ[12];
  assign TQ_[13] = TQ[13];
  assign TQ_[14] = TQ[14];
  assign TQ_[15] = TQ[15];
  assign TQ_[16] = TQ[16];
  assign TQ_[17] = TQ[17];
  assign TQ_[18] = TQ[18];
  assign TQ_[19] = TQ[19];
  assign TQ_[20] = TQ[20];
  assign TQ_[21] = TQ[21];
  assign TQ_[22] = TQ[22];
  assign TQ_[23] = TQ[23];
  assign TQ_[24] = TQ[24];
  assign TQ_[25] = TQ[25];
  assign TQ_[26] = TQ[26];
  assign TQ_[27] = TQ[27];
  assign TQ_[28] = TQ[28];
  assign TQ_[29] = TQ[29];
  assign TQ_[30] = TQ[30];
  assign TQ_[31] = TQ[31];
  assign RET1N_ = RET1N;
  assign STOV_ = STOV;

  assign `ARM_UD_DP CENY_ = RET1N_ ? (TEN_ ? CEN_ : TCEN_) : 1'bx;
  assign `ARM_UD_DP WENY_ = RET1N_ ? (TEN_ ? WEN_ : TWEN_) : 1'bx;
  assign `ARM_UD_DP AY_ = RET1N_ ? (TEN_ ? A_ : TA_) : {11{1'bx}};
  assign `ARM_UD_DP DY_ = RET1N_ ? (TEN_ ? D_ : TD_) : {32{1'bx}};
  assign `ARM_UD_SEQ Q_ = RET1N_ ? (BEN_ ? ((STOV_ ? (Q_int_delayed) : (Q_int))) : TQ_) : {32{1'bx}};

// If INITIALIZE_MEMORY is defined at Simulator Command Line, it Initializes the Memory with all ZEROS.
`ifdef INITIALIZE_MEMORY
  integer i;
  initial
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'b0}};
`endif

  task failedWrite;
  input port_f;
  integer i;
  begin
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'bx}};
  end
  endtask

  function isBitX;
    input bitval;
    begin
      isBitX = ( bitval===1'bx || bitval==1'bz ) ? 1'b1 : 1'b0;
    end
  endfunction


task loadmem;
	input [1000*8-1:0] filename;
	reg [BITS-1:0] memld [0:WORDS-1];
	integer i;
	reg [BITS-1:0] wordtemp;
	reg [10:0] Atemp;
  begin
	$readmemb(filename, memld);
     if (CEN_ === 1'b1) begin
	  for (i=0;i<WORDS;i=i+1) begin
	  wordtemp = memld[i];
	  Atemp = i;
	  mux_address = (Atemp & 3'b111);
      row_address = (Atemp >> 3);
      row = mem[row_address];
        writeEnable = {32{1'b1}};
        row_mask =  ( {7'b0000000, writeEnable[31], 7'b0000000, writeEnable[30], 7'b0000000, writeEnable[29],
          7'b0000000, writeEnable[28], 7'b0000000, writeEnable[27], 7'b0000000, writeEnable[26],
          7'b0000000, writeEnable[25], 7'b0000000, writeEnable[24], 7'b0000000, writeEnable[23],
          7'b0000000, writeEnable[22], 7'b0000000, writeEnable[21], 7'b0000000, writeEnable[20],
          7'b0000000, writeEnable[19], 7'b0000000, writeEnable[18], 7'b0000000, writeEnable[17],
          7'b0000000, writeEnable[16], 7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14],
          7'b0000000, writeEnable[13], 7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11],
          7'b0000000, writeEnable[10], 7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8],
          7'b0000000, writeEnable[7], 7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5],
          7'b0000000, writeEnable[4], 7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2],
          7'b0000000, writeEnable[1], 7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, wordtemp[31], 7'b0000000, wordtemp[30], 7'b0000000, wordtemp[29],
          7'b0000000, wordtemp[28], 7'b0000000, wordtemp[27], 7'b0000000, wordtemp[26],
          7'b0000000, wordtemp[25], 7'b0000000, wordtemp[24], 7'b0000000, wordtemp[23],
          7'b0000000, wordtemp[22], 7'b0000000, wordtemp[21], 7'b0000000, wordtemp[20],
          7'b0000000, wordtemp[19], 7'b0000000, wordtemp[18], 7'b0000000, wordtemp[17],
          7'b0000000, wordtemp[16], 7'b0000000, wordtemp[15], 7'b0000000, wordtemp[14],
          7'b0000000, wordtemp[13], 7'b0000000, wordtemp[12], 7'b0000000, wordtemp[11],
          7'b0000000, wordtemp[10], 7'b0000000, wordtemp[9], 7'b0000000, wordtemp[8],
          7'b0000000, wordtemp[7], 7'b0000000, wordtemp[6], 7'b0000000, wordtemp[5],
          7'b0000000, wordtemp[4], 7'b0000000, wordtemp[3], 7'b0000000, wordtemp[2],
          7'b0000000, wordtemp[1], 7'b0000000, wordtemp[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        mem[row_address] = row;
  	end
  end
  end
  endtask

task dumpmem;
	input [1000*8-1:0] filename_dump;
	integer i, dump_file_desc;
	reg [BITS-1:0] wordtemp;
	reg [10:0] Atemp;
  begin
	dump_file_desc = $fopen(filename_dump);
     if (CEN_ === 1'b1) begin
	  for (i=0;i<WORDS;i=i+1) begin
	  Atemp = i;
	  mux_address = (Atemp & 3'b111);
      row_address = (Atemp >> 3);
      row = mem[row_address];
        writeEnable = {32{1'b1}};
        data_out = (row >> (mux_address));
        readLatch0 = {data_out[252], data_out[248], data_out[244], data_out[240], data_out[236],
          data_out[232], data_out[228], data_out[224], data_out[220], data_out[216],
          data_out[212], data_out[208], data_out[204], data_out[200], data_out[196],
          data_out[192], data_out[188], data_out[184], data_out[180], data_out[176],
          data_out[172], data_out[168], data_out[164], data_out[160], data_out[156],
          data_out[152], data_out[148], data_out[144], data_out[140], data_out[136],
          data_out[132], data_out[128], data_out[124], data_out[120], data_out[116],
          data_out[112], data_out[108], data_out[104], data_out[100], data_out[96],
          data_out[92], data_out[88], data_out[84], data_out[80], data_out[76], data_out[72],
          data_out[68], data_out[64], data_out[60], data_out[56], data_out[52], data_out[48],
          data_out[44], data_out[40], data_out[36], data_out[32], data_out[28], data_out[24],
          data_out[20], data_out[16], data_out[12], data_out[8], data_out[4], data_out[0]};
        shifted_readLatch0 = readLatch0;
        Q_int = {shifted_readLatch0[62], shifted_readLatch0[60], shifted_readLatch0[58],
          shifted_readLatch0[56], shifted_readLatch0[54], shifted_readLatch0[52], shifted_readLatch0[50],
          shifted_readLatch0[48], shifted_readLatch0[46], shifted_readLatch0[44], shifted_readLatch0[42],
          shifted_readLatch0[40], shifted_readLatch0[38], shifted_readLatch0[36], shifted_readLatch0[34],
          shifted_readLatch0[32], shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
   	$fdisplay(dump_file_desc, "%b", Q_int);
  end
  	end
//    $fclose(filename_dump);
  end
  endtask


  task readWrite;
  begin
    if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_int === 1'b0 && CEN_int === 1'b0) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{CEN_int, EMA_int, EMAW_int, EMAS_int, RET1N_int, (STOV_int && !CEN_int)} 
     === 1'bx) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if ((A_int >= WORDS) && (CEN_int === 1'b0)) begin
      Q_int = WEN_int !== 1'b1 ? D_int : {32{1'bx}};
      Q_int_delayed = WEN_int !== 1'b1 ? D_int : {32{1'bx}};
    end else if (CEN_int === 1'b0 && (^A_int) === 1'bx) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (CEN_int === 1'b0) begin
      mux_address = (A_int & 3'b111);
      row_address = (A_int >> 3);
      if (row_address > 223)
        row = {256{1'bx}};
      else
        row = mem[row_address];
      writeEnable = ~{32{WEN_int}};
      if (WEN_int !== 1'b1) begin
        row_mask =  ( {7'b0000000, writeEnable[31], 7'b0000000, writeEnable[30], 7'b0000000, writeEnable[29],
          7'b0000000, writeEnable[28], 7'b0000000, writeEnable[27], 7'b0000000, writeEnable[26],
          7'b0000000, writeEnable[25], 7'b0000000, writeEnable[24], 7'b0000000, writeEnable[23],
          7'b0000000, writeEnable[22], 7'b0000000, writeEnable[21], 7'b0000000, writeEnable[20],
          7'b0000000, writeEnable[19], 7'b0000000, writeEnable[18], 7'b0000000, writeEnable[17],
          7'b0000000, writeEnable[16], 7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14],
          7'b0000000, writeEnable[13], 7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11],
          7'b0000000, writeEnable[10], 7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8],
          7'b0000000, writeEnable[7], 7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5],
          7'b0000000, writeEnable[4], 7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2],
          7'b0000000, writeEnable[1], 7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, D_int[31], 7'b0000000, D_int[30], 7'b0000000, D_int[29],
          7'b0000000, D_int[28], 7'b0000000, D_int[27], 7'b0000000, D_int[26], 7'b0000000, D_int[25],
          7'b0000000, D_int[24], 7'b0000000, D_int[23], 7'b0000000, D_int[22], 7'b0000000, D_int[21],
          7'b0000000, D_int[20], 7'b0000000, D_int[19], 7'b0000000, D_int[18], 7'b0000000, D_int[17],
          7'b0000000, D_int[16], 7'b0000000, D_int[15], 7'b0000000, D_int[14], 7'b0000000, D_int[13],
          7'b0000000, D_int[12], 7'b0000000, D_int[11], 7'b0000000, D_int[10], 7'b0000000, D_int[9],
          7'b0000000, D_int[8], 7'b0000000, D_int[7], 7'b0000000, D_int[6], 7'b0000000, D_int[5],
          7'b0000000, D_int[4], 7'b0000000, D_int[3], 7'b0000000, D_int[2], 7'b0000000, D_int[1],
          7'b0000000, D_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        mem[row_address] = row;
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch0 = {data_out[252], data_out[248], data_out[244], data_out[240], data_out[236],
          data_out[232], data_out[228], data_out[224], data_out[220], data_out[216],
          data_out[212], data_out[208], data_out[204], data_out[200], data_out[196],
          data_out[192], data_out[188], data_out[184], data_out[180], data_out[176],
          data_out[172], data_out[168], data_out[164], data_out[160], data_out[156],
          data_out[152], data_out[148], data_out[144], data_out[140], data_out[136],
          data_out[132], data_out[128], data_out[124], data_out[120], data_out[116],
          data_out[112], data_out[108], data_out[104], data_out[100], data_out[96],
          data_out[92], data_out[88], data_out[84], data_out[80], data_out[76], data_out[72],
          data_out[68], data_out[64], data_out[60], data_out[56], data_out[52], data_out[48],
          data_out[44], data_out[40], data_out[36], data_out[32], data_out[28], data_out[24],
          data_out[20], data_out[16], data_out[12], data_out[8], data_out[4], data_out[0]};
      end
      if (WEN_int !== 1'b1) begin
        Q_int = D_int;
        Q_int_delayed = D_int;
      end else begin
        shifted_readLatch0 = (readLatch0 >> A_int[2]);
        Q_int = {shifted_readLatch0[62], shifted_readLatch0[60], shifted_readLatch0[58],
          shifted_readLatch0[56], shifted_readLatch0[54], shifted_readLatch0[52], shifted_readLatch0[50],
          shifted_readLatch0[48], shifted_readLatch0[46], shifted_readLatch0[44], shifted_readLatch0[42],
          shifted_readLatch0[40], shifted_readLatch0[38], shifted_readLatch0[36], shifted_readLatch0[34],
          shifted_readLatch0[32], shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
      end
    end
  end
  endtask
  always @ (CEN_ or TCEN_ or TEN_ or CLK_) begin
  	if(CLK_ == 1'b0) begin
  		CEN_p2 = CEN_;
  		TCEN_p2 = TCEN_;
  	end
  end

  always @ RET1N_ begin
    if (CLK_ == 1'b1) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CEN_p2 === 1'b0 || TCEN_p2 === 1'b0) ) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CEN_p2 === 1'b0 || TCEN_p2 === 1'b0) ) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end
    if (RET1N_ == 1'b0) begin
      Q_int = {32{1'bx}};
      Q_int_delayed = {32{1'bx}};
      CEN_int = 1'bx;
      WEN_int = 1'bx;
      A_int = {11{1'bx}};
      D_int = {32{1'bx}};
      EMA_int = {3{1'bx}};
      EMAW_int = {2{1'bx}};
      EMAS_int = 1'bx;
      TEN_int = 1'bx;
      BEN_int = 1'bx;
      TCEN_int = 1'bx;
      TWEN_int = 1'bx;
      TA_int = {11{1'bx}};
      TD_int = {32{1'bx}};
      TQ_int = {32{1'bx}};
      RET1N_int = 1'bx;
      STOV_int = 1'bx;
    end else begin
      Q_int = {32{1'bx}};
      Q_int_delayed = {32{1'bx}};
      CEN_int = 1'bx;
      WEN_int = 1'bx;
      A_int = {11{1'bx}};
      D_int = {32{1'bx}};
      EMA_int = {3{1'bx}};
      EMAW_int = {2{1'bx}};
      EMAS_int = 1'bx;
      TEN_int = 1'bx;
      BEN_int = 1'bx;
      TCEN_int = 1'bx;
      TWEN_int = 1'bx;
      TA_int = {11{1'bx}};
      TD_int = {32{1'bx}};
      TQ_int = {32{1'bx}};
      RET1N_int = 1'bx;
      STOV_int = 1'bx;
    end
    RET1N_int = RET1N_;
  end


  always @ CLK_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("ERROR: Illegal value for VDDCE %b", VDDCE);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("ERROR: Illegal value for VDDPE %b", VDDPE);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("ERROR: Illegal value for VSSE %b", VSSE);
`endif
  if (RET1N_ == 1'b0) begin
      // no cycle in retention mode
  end else begin
    if ((CLK_ === 1'bx || CLK_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (CLK_ === 1'b1 && LAST_CLK === 1'b0) begin
      CEN_int = TEN_ ? CEN_ : TCEN_;
      EMA_int = EMA_;
      EMAW_int = EMAW_;
      EMAS_int = EMAS_;
      TEN_int = TEN_;
      BEN_int = BEN_;
      TWEN_int = TWEN_;
      TQ_int = TQ_;
      RET1N_int = RET1N_;
      STOV_int = STOV_;
      if (CEN_int != 1'b1) begin
        WEN_int = TEN_ ? WEN_ : TWEN_;
        A_int = TEN_ ? A_ : TA_;
        D_int = TEN_ ? D_ : TD_;
        TCEN_int = TCEN_;
        TA_int = TA_;
        TD_int = TD_;
        if (WEN_int === 1'b1)
          read_mux_sel0 = (TEN_ ? A_[2] : TA_[2] );
      end
      clk0_int = 1'b0;
      if (CEN_int === 1'b0 && WEN_int === 1'b1) 
         Q_int_delayed = {32{1'bx}};
    readWrite;
    end else if (CLK_ === 1'b0 && LAST_CLK === 1'b1) begin
      Q_int_delayed = Q_int;
    end
    LAST_CLK = CLK_;
  end
  end

endmodule
`endcelldefine
`else
`celldefine
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
module sram_sp_hde (VDDCE, VDDPE, VSSE, CENY, WENY, AY, DY, Q, CLK, CEN, WEN, A, D,
    EMA, EMAW, EMAS, TEN, BEN, TCEN, TWEN, TA, TD, TQ, RET1N, STOV);
`else
module sram_sp_hde (CENY, WENY, AY, DY, Q, CLK, CEN, WEN, A, D, EMA, EMAW, EMAS, TEN,
    BEN, TCEN, TWEN, TA, TD, TQ, RET1N, STOV);
`endif

  parameter ASSERT_PREFIX = "";
  parameter BITS = 32;
  parameter WORDS = 1792;
  parameter MUX = 8;
  parameter MEM_WIDTH = 256; // redun block size 4, 128 on left, 128 on right
  parameter MEM_HEIGHT = 224;
  parameter WP_SIZE = 32 ;
  parameter UPM_WIDTH = 3;
  parameter UPMW_WIDTH = 2;
  parameter UPMS_WIDTH = 1;

  output  CENY;
  output  WENY;
  output [10:0] AY;
  output [31:0] DY;
  output [31:0] Q;
  input  CLK;
  input  CEN;
  input  WEN;
  input [10:0] A;
  input [31:0] D;
  input [2:0] EMA;
  input [1:0] EMAW;
  input  EMAS;
  input  TEN;
  input  BEN;
  input  TCEN;
  input  TWEN;
  input [10:0] TA;
  input [31:0] TD;
  input [31:0] TQ;
  input  RET1N;
  input  STOV;
`ifdef POWER_PINS
  inout VDDCE;
  inout VDDPE;
  inout VSSE;
`endif

  integer row_address;
  integer mux_address;
  reg [255:0] mem [0:223];
  reg [255:0] row;
  reg LAST_CLK;
  reg [255:0] row_mask;
  reg [255:0] new_data;
  reg [255:0] data_out;
  reg [63:0] readLatch0;
  reg [63:0] shifted_readLatch0;
  reg  read_mux_sel0;
  reg [31:0] Q_int;
  reg [31:0] Q_int_delayed;
  reg [31:0] writeEnable;

  reg NOT_CEN, NOT_WEN, NOT_A10, NOT_A9, NOT_A8, NOT_A7, NOT_A6, NOT_A5, NOT_A4, NOT_A3;
  reg NOT_A2, NOT_A1, NOT_A0, NOT_D31, NOT_D30, NOT_D29, NOT_D28, NOT_D27, NOT_D26;
  reg NOT_D25, NOT_D24, NOT_D23, NOT_D22, NOT_D21, NOT_D20, NOT_D19, NOT_D18, NOT_D17;
  reg NOT_D16, NOT_D15, NOT_D14, NOT_D13, NOT_D12, NOT_D11, NOT_D10, NOT_D9, NOT_D8;
  reg NOT_D7, NOT_D6, NOT_D5, NOT_D4, NOT_D3, NOT_D2, NOT_D1, NOT_D0, NOT_EMA2, NOT_EMA1;
  reg NOT_EMA0, NOT_EMAW1, NOT_EMAW0, NOT_EMAS, NOT_TEN, NOT_TCEN, NOT_TWEN, NOT_TA10;
  reg NOT_TA9, NOT_TA8, NOT_TA7, NOT_TA6, NOT_TA5, NOT_TA4, NOT_TA3, NOT_TA2, NOT_TA1;
  reg NOT_TA0, NOT_TD31, NOT_TD30, NOT_TD29, NOT_TD28, NOT_TD27, NOT_TD26, NOT_TD25;
  reg NOT_TD24, NOT_TD23, NOT_TD22, NOT_TD21, NOT_TD20, NOT_TD19, NOT_TD18, NOT_TD17;
  reg NOT_TD16, NOT_TD15, NOT_TD14, NOT_TD13, NOT_TD12, NOT_TD11, NOT_TD10, NOT_TD9;
  reg NOT_TD8, NOT_TD7, NOT_TD6, NOT_TD5, NOT_TD4, NOT_TD3, NOT_TD2, NOT_TD1, NOT_TD0;
  reg NOT_RET1N, NOT_STOV;
  reg NOT_CLK_PER, NOT_CLK_MINH, NOT_CLK_MINL;
  reg clk0_int;

  wire  CENY_;
  wire  WENY_;
  wire [10:0] AY_;
  wire [31:0] DY_;
  wire [31:0] Q_;
 wire  CLK_;
  wire  CEN_;
  reg  CEN_int;
  reg  CEN_p2;
  wire  WEN_;
  reg  WEN_int;
  wire [10:0] A_;
  reg [10:0] A_int;
  wire [31:0] D_;
  reg [31:0] D_int;
  wire [2:0] EMA_;
  reg [2:0] EMA_int;
  wire [1:0] EMAW_;
  reg [1:0] EMAW_int;
  wire  EMAS_;
  reg  EMAS_int;
  wire  TEN_;
  reg  TEN_int;
  wire  BEN_;
  reg  BEN_int;
  wire  TCEN_;
  reg  TCEN_int;
  reg  TCEN_p2;
  wire  TWEN_;
  reg  TWEN_int;
  wire [10:0] TA_;
  reg [10:0] TA_int;
  wire [31:0] TD_;
  reg [31:0] TD_int;
  wire [31:0] TQ_;
  reg [31:0] TQ_int;
  wire  RET1N_;
  reg  RET1N_int;
  wire  STOV_;
  reg  STOV_int;

  buf B0(CENY, CENY_);
  buf B1(WENY, WENY_);
  buf B2(AY[0], AY_[0]);
  buf B3(AY[1], AY_[1]);
  buf B4(AY[2], AY_[2]);
  buf B5(AY[3], AY_[3]);
  buf B6(AY[4], AY_[4]);
  buf B7(AY[5], AY_[5]);
  buf B8(AY[6], AY_[6]);
  buf B9(AY[7], AY_[7]);
  buf B10(AY[8], AY_[8]);
  buf B11(AY[9], AY_[9]);
  buf B12(AY[10], AY_[10]);
  buf B13(DY[0], DY_[0]);
  buf B14(DY[1], DY_[1]);
  buf B15(DY[2], DY_[2]);
  buf B16(DY[3], DY_[3]);
  buf B17(DY[4], DY_[4]);
  buf B18(DY[5], DY_[5]);
  buf B19(DY[6], DY_[6]);
  buf B20(DY[7], DY_[7]);
  buf B21(DY[8], DY_[8]);
  buf B22(DY[9], DY_[9]);
  buf B23(DY[10], DY_[10]);
  buf B24(DY[11], DY_[11]);
  buf B25(DY[12], DY_[12]);
  buf B26(DY[13], DY_[13]);
  buf B27(DY[14], DY_[14]);
  buf B28(DY[15], DY_[15]);
  buf B29(DY[16], DY_[16]);
  buf B30(DY[17], DY_[17]);
  buf B31(DY[18], DY_[18]);
  buf B32(DY[19], DY_[19]);
  buf B33(DY[20], DY_[20]);
  buf B34(DY[21], DY_[21]);
  buf B35(DY[22], DY_[22]);
  buf B36(DY[23], DY_[23]);
  buf B37(DY[24], DY_[24]);
  buf B38(DY[25], DY_[25]);
  buf B39(DY[26], DY_[26]);
  buf B40(DY[27], DY_[27]);
  buf B41(DY[28], DY_[28]);
  buf B42(DY[29], DY_[29]);
  buf B43(DY[30], DY_[30]);
  buf B44(DY[31], DY_[31]);
  buf B45(Q[0], Q_[0]);
  buf B46(Q[1], Q_[1]);
  buf B47(Q[2], Q_[2]);
  buf B48(Q[3], Q_[3]);
  buf B49(Q[4], Q_[4]);
  buf B50(Q[5], Q_[5]);
  buf B51(Q[6], Q_[6]);
  buf B52(Q[7], Q_[7]);
  buf B53(Q[8], Q_[8]);
  buf B54(Q[9], Q_[9]);
  buf B55(Q[10], Q_[10]);
  buf B56(Q[11], Q_[11]);
  buf B57(Q[12], Q_[12]);
  buf B58(Q[13], Q_[13]);
  buf B59(Q[14], Q_[14]);
  buf B60(Q[15], Q_[15]);
  buf B61(Q[16], Q_[16]);
  buf B62(Q[17], Q_[17]);
  buf B63(Q[18], Q_[18]);
  buf B64(Q[19], Q_[19]);
  buf B65(Q[20], Q_[20]);
  buf B66(Q[21], Q_[21]);
  buf B67(Q[22], Q_[22]);
  buf B68(Q[23], Q_[23]);
  buf B69(Q[24], Q_[24]);
  buf B70(Q[25], Q_[25]);
  buf B71(Q[26], Q_[26]);
  buf B72(Q[27], Q_[27]);
  buf B73(Q[28], Q_[28]);
  buf B74(Q[29], Q_[29]);
  buf B75(Q[30], Q_[30]);
  buf B76(Q[31], Q_[31]);
  buf B77(CLK_, CLK);
  buf B78(CEN_, CEN);
  buf B79(WEN_, WEN);
  buf B80(A_[0], A[0]);
  buf B81(A_[1], A[1]);
  buf B82(A_[2], A[2]);
  buf B83(A_[3], A[3]);
  buf B84(A_[4], A[4]);
  buf B85(A_[5], A[5]);
  buf B86(A_[6], A[6]);
  buf B87(A_[7], A[7]);
  buf B88(A_[8], A[8]);
  buf B89(A_[9], A[9]);
  buf B90(A_[10], A[10]);
  buf B91(D_[0], D[0]);
  buf B92(D_[1], D[1]);
  buf B93(D_[2], D[2]);
  buf B94(D_[3], D[3]);
  buf B95(D_[4], D[4]);
  buf B96(D_[5], D[5]);
  buf B97(D_[6], D[6]);
  buf B98(D_[7], D[7]);
  buf B99(D_[8], D[8]);
  buf B100(D_[9], D[9]);
  buf B101(D_[10], D[10]);
  buf B102(D_[11], D[11]);
  buf B103(D_[12], D[12]);
  buf B104(D_[13], D[13]);
  buf B105(D_[14], D[14]);
  buf B106(D_[15], D[15]);
  buf B107(D_[16], D[16]);
  buf B108(D_[17], D[17]);
  buf B109(D_[18], D[18]);
  buf B110(D_[19], D[19]);
  buf B111(D_[20], D[20]);
  buf B112(D_[21], D[21]);
  buf B113(D_[22], D[22]);
  buf B114(D_[23], D[23]);
  buf B115(D_[24], D[24]);
  buf B116(D_[25], D[25]);
  buf B117(D_[26], D[26]);
  buf B118(D_[27], D[27]);
  buf B119(D_[28], D[28]);
  buf B120(D_[29], D[29]);
  buf B121(D_[30], D[30]);
  buf B122(D_[31], D[31]);
  buf B123(EMA_[0], EMA[0]);
  buf B124(EMA_[1], EMA[1]);
  buf B125(EMA_[2], EMA[2]);
  buf B126(EMAW_[0], EMAW[0]);
  buf B127(EMAW_[1], EMAW[1]);
  buf B128(EMAS_, EMAS);
  buf B129(TEN_, TEN);
  buf B130(BEN_, BEN);
  buf B131(TCEN_, TCEN);
  buf B132(TWEN_, TWEN);
  buf B133(TA_[0], TA[0]);
  buf B134(TA_[1], TA[1]);
  buf B135(TA_[2], TA[2]);
  buf B136(TA_[3], TA[3]);
  buf B137(TA_[4], TA[4]);
  buf B138(TA_[5], TA[5]);
  buf B139(TA_[6], TA[6]);
  buf B140(TA_[7], TA[7]);
  buf B141(TA_[8], TA[8]);
  buf B142(TA_[9], TA[9]);
  buf B143(TA_[10], TA[10]);
  buf B144(TD_[0], TD[0]);
  buf B145(TD_[1], TD[1]);
  buf B146(TD_[2], TD[2]);
  buf B147(TD_[3], TD[3]);
  buf B148(TD_[4], TD[4]);
  buf B149(TD_[5], TD[5]);
  buf B150(TD_[6], TD[6]);
  buf B151(TD_[7], TD[7]);
  buf B152(TD_[8], TD[8]);
  buf B153(TD_[9], TD[9]);
  buf B154(TD_[10], TD[10]);
  buf B155(TD_[11], TD[11]);
  buf B156(TD_[12], TD[12]);
  buf B157(TD_[13], TD[13]);
  buf B158(TD_[14], TD[14]);
  buf B159(TD_[15], TD[15]);
  buf B160(TD_[16], TD[16]);
  buf B161(TD_[17], TD[17]);
  buf B162(TD_[18], TD[18]);
  buf B163(TD_[19], TD[19]);
  buf B164(TD_[20], TD[20]);
  buf B165(TD_[21], TD[21]);
  buf B166(TD_[22], TD[22]);
  buf B167(TD_[23], TD[23]);
  buf B168(TD_[24], TD[24]);
  buf B169(TD_[25], TD[25]);
  buf B170(TD_[26], TD[26]);
  buf B171(TD_[27], TD[27]);
  buf B172(TD_[28], TD[28]);
  buf B173(TD_[29], TD[29]);
  buf B174(TD_[30], TD[30]);
  buf B175(TD_[31], TD[31]);
  buf B176(TQ_[0], TQ[0]);
  buf B177(TQ_[1], TQ[1]);
  buf B178(TQ_[2], TQ[2]);
  buf B179(TQ_[3], TQ[3]);
  buf B180(TQ_[4], TQ[4]);
  buf B181(TQ_[5], TQ[5]);
  buf B182(TQ_[6], TQ[6]);
  buf B183(TQ_[7], TQ[7]);
  buf B184(TQ_[8], TQ[8]);
  buf B185(TQ_[9], TQ[9]);
  buf B186(TQ_[10], TQ[10]);
  buf B187(TQ_[11], TQ[11]);
  buf B188(TQ_[12], TQ[12]);
  buf B189(TQ_[13], TQ[13]);
  buf B190(TQ_[14], TQ[14]);
  buf B191(TQ_[15], TQ[15]);
  buf B192(TQ_[16], TQ[16]);
  buf B193(TQ_[17], TQ[17]);
  buf B194(TQ_[18], TQ[18]);
  buf B195(TQ_[19], TQ[19]);
  buf B196(TQ_[20], TQ[20]);
  buf B197(TQ_[21], TQ[21]);
  buf B198(TQ_[22], TQ[22]);
  buf B199(TQ_[23], TQ[23]);
  buf B200(TQ_[24], TQ[24]);
  buf B201(TQ_[25], TQ[25]);
  buf B202(TQ_[26], TQ[26]);
  buf B203(TQ_[27], TQ[27]);
  buf B204(TQ_[28], TQ[28]);
  buf B205(TQ_[29], TQ[29]);
  buf B206(TQ_[30], TQ[30]);
  buf B207(TQ_[31], TQ[31]);
  buf B208(RET1N_, RET1N);
  buf B209(STOV_, STOV);

  assign CENY_ = RET1N_ ? (TEN_ ? CEN_ : TCEN_) : 1'bx;
  assign WENY_ = RET1N_ ? (TEN_ ? WEN_ : TWEN_) : 1'bx;
  assign AY_ = RET1N_ ? (TEN_ ? A_ : TA_) : {11{1'bx}};
  assign DY_ = RET1N_ ? (TEN_ ? D_ : TD_) : {32{1'bx}};
   `ifdef ARM_FAULT_MODELING
     sram_sp_hde_error_injection u1(.CLK(CLK_), .Q_out(Q_), .A(A_int), .CEN(CEN_int), .TQ(TQ_), .BEN(BEN_), .WEN(WEN_int), .Q_in(Q_int));
  `else
  assign Q_ = RET1N_ ? (BEN_ ? ((STOV_ ? (Q_int_delayed) : (Q_int))) : TQ_) : {32{1'bx}};
  `endif

// If INITIALIZE_MEMORY is defined at Simulator Command Line, it Initializes the Memory with all ZEROS.
`ifdef INITIALIZE_MEMORY
  integer i;
  initial
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'b0}};
`endif

  task failedWrite;
  input port_f;
  integer i;
  begin
    for (i = 0; i < MEM_HEIGHT; i = i + 1)
      mem[i] = {MEM_WIDTH{1'bx}};
  end
  endtask

  function isBitX;
    input bitval;
    begin
      isBitX = ( bitval===1'bx || bitval==1'bz ) ? 1'b1 : 1'b0;
    end
  endfunction


task loadmem;
	input [1000*8-1:0] filename;
	reg [BITS-1:0] memld [0:WORDS-1];
	integer i;
	reg [BITS-1:0] wordtemp;
	reg [10:0] Atemp;
  begin
	$readmemb(filename, memld);
     if (CEN_ === 1'b1) begin
	  for (i=0;i<WORDS;i=i+1) begin
	  wordtemp = memld[i];
	  Atemp = i;
	  mux_address = (Atemp & 3'b111);
      row_address = (Atemp >> 3);
      row = mem[row_address];
        writeEnable = {32{1'b1}};
        row_mask =  ( {7'b0000000, writeEnable[31], 7'b0000000, writeEnable[30], 7'b0000000, writeEnable[29],
          7'b0000000, writeEnable[28], 7'b0000000, writeEnable[27], 7'b0000000, writeEnable[26],
          7'b0000000, writeEnable[25], 7'b0000000, writeEnable[24], 7'b0000000, writeEnable[23],
          7'b0000000, writeEnable[22], 7'b0000000, writeEnable[21], 7'b0000000, writeEnable[20],
          7'b0000000, writeEnable[19], 7'b0000000, writeEnable[18], 7'b0000000, writeEnable[17],
          7'b0000000, writeEnable[16], 7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14],
          7'b0000000, writeEnable[13], 7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11],
          7'b0000000, writeEnable[10], 7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8],
          7'b0000000, writeEnable[7], 7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5],
          7'b0000000, writeEnable[4], 7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2],
          7'b0000000, writeEnable[1], 7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, wordtemp[31], 7'b0000000, wordtemp[30], 7'b0000000, wordtemp[29],
          7'b0000000, wordtemp[28], 7'b0000000, wordtemp[27], 7'b0000000, wordtemp[26],
          7'b0000000, wordtemp[25], 7'b0000000, wordtemp[24], 7'b0000000, wordtemp[23],
          7'b0000000, wordtemp[22], 7'b0000000, wordtemp[21], 7'b0000000, wordtemp[20],
          7'b0000000, wordtemp[19], 7'b0000000, wordtemp[18], 7'b0000000, wordtemp[17],
          7'b0000000, wordtemp[16], 7'b0000000, wordtemp[15], 7'b0000000, wordtemp[14],
          7'b0000000, wordtemp[13], 7'b0000000, wordtemp[12], 7'b0000000, wordtemp[11],
          7'b0000000, wordtemp[10], 7'b0000000, wordtemp[9], 7'b0000000, wordtemp[8],
          7'b0000000, wordtemp[7], 7'b0000000, wordtemp[6], 7'b0000000, wordtemp[5],
          7'b0000000, wordtemp[4], 7'b0000000, wordtemp[3], 7'b0000000, wordtemp[2],
          7'b0000000, wordtemp[1], 7'b0000000, wordtemp[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        mem[row_address] = row;
  	end
  end
  end
  endtask

task dumpmem;
	input [1000*8-1:0] filename_dump;
	integer i, dump_file_desc;
	reg [BITS-1:0] wordtemp;
	reg [10:0] Atemp;
  begin
	dump_file_desc = $fopen(filename_dump);
     if (CEN_ === 1'b1) begin
	  for (i=0;i<WORDS;i=i+1) begin
	  Atemp = i;
	  mux_address = (Atemp & 3'b111);
      row_address = (Atemp >> 3);
      row = mem[row_address];
        writeEnable = {32{1'b1}};
        data_out = (row >> (mux_address));
        readLatch0 = {data_out[252], data_out[248], data_out[244], data_out[240], data_out[236],
          data_out[232], data_out[228], data_out[224], data_out[220], data_out[216],
          data_out[212], data_out[208], data_out[204], data_out[200], data_out[196],
          data_out[192], data_out[188], data_out[184], data_out[180], data_out[176],
          data_out[172], data_out[168], data_out[164], data_out[160], data_out[156],
          data_out[152], data_out[148], data_out[144], data_out[140], data_out[136],
          data_out[132], data_out[128], data_out[124], data_out[120], data_out[116],
          data_out[112], data_out[108], data_out[104], data_out[100], data_out[96],
          data_out[92], data_out[88], data_out[84], data_out[80], data_out[76], data_out[72],
          data_out[68], data_out[64], data_out[60], data_out[56], data_out[52], data_out[48],
          data_out[44], data_out[40], data_out[36], data_out[32], data_out[28], data_out[24],
          data_out[20], data_out[16], data_out[12], data_out[8], data_out[4], data_out[0]};
        shifted_readLatch0 = readLatch0;
        Q_int = {shifted_readLatch0[62], shifted_readLatch0[60], shifted_readLatch0[58],
          shifted_readLatch0[56], shifted_readLatch0[54], shifted_readLatch0[52], shifted_readLatch0[50],
          shifted_readLatch0[48], shifted_readLatch0[46], shifted_readLatch0[44], shifted_readLatch0[42],
          shifted_readLatch0[40], shifted_readLatch0[38], shifted_readLatch0[36], shifted_readLatch0[34],
          shifted_readLatch0[32], shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
   	$fdisplay(dump_file_desc, "%b", Q_int);
  end
  	end
//    $fclose(filename_dump);
  end
  endtask


  task readWrite;
  begin
    if (RET1N_int === 1'bx || RET1N_int === 1'bz) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_int === 1'b0 && CEN_int === 1'b0) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_int === 1'b0) begin
      // no cycle in retention mode
    end else if (^{CEN_int, EMA_int, EMAW_int, EMAS_int, RET1N_int, (STOV_int && !CEN_int)} 
     === 1'bx) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if ((A_int >= WORDS) && (CEN_int === 1'b0)) begin
      Q_int = WEN_int !== 1'b1 ? D_int : {32{1'bx}};
      Q_int_delayed = WEN_int !== 1'b1 ? D_int : {32{1'bx}};
    end else if (CEN_int === 1'b0 && (^A_int) === 1'bx) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (CEN_int === 1'b0) begin
      mux_address = (A_int & 3'b111);
      row_address = (A_int >> 3);
      if (row_address > 223)
        row = {256{1'bx}};
      else
        row = mem[row_address];
      writeEnable = ~{32{WEN_int}};
      if (WEN_int !== 1'b1) begin
        row_mask =  ( {7'b0000000, writeEnable[31], 7'b0000000, writeEnable[30], 7'b0000000, writeEnable[29],
          7'b0000000, writeEnable[28], 7'b0000000, writeEnable[27], 7'b0000000, writeEnable[26],
          7'b0000000, writeEnable[25], 7'b0000000, writeEnable[24], 7'b0000000, writeEnable[23],
          7'b0000000, writeEnable[22], 7'b0000000, writeEnable[21], 7'b0000000, writeEnable[20],
          7'b0000000, writeEnable[19], 7'b0000000, writeEnable[18], 7'b0000000, writeEnable[17],
          7'b0000000, writeEnable[16], 7'b0000000, writeEnable[15], 7'b0000000, writeEnable[14],
          7'b0000000, writeEnable[13], 7'b0000000, writeEnable[12], 7'b0000000, writeEnable[11],
          7'b0000000, writeEnable[10], 7'b0000000, writeEnable[9], 7'b0000000, writeEnable[8],
          7'b0000000, writeEnable[7], 7'b0000000, writeEnable[6], 7'b0000000, writeEnable[5],
          7'b0000000, writeEnable[4], 7'b0000000, writeEnable[3], 7'b0000000, writeEnable[2],
          7'b0000000, writeEnable[1], 7'b0000000, writeEnable[0]} << mux_address);
        new_data =  ( {7'b0000000, D_int[31], 7'b0000000, D_int[30], 7'b0000000, D_int[29],
          7'b0000000, D_int[28], 7'b0000000, D_int[27], 7'b0000000, D_int[26], 7'b0000000, D_int[25],
          7'b0000000, D_int[24], 7'b0000000, D_int[23], 7'b0000000, D_int[22], 7'b0000000, D_int[21],
          7'b0000000, D_int[20], 7'b0000000, D_int[19], 7'b0000000, D_int[18], 7'b0000000, D_int[17],
          7'b0000000, D_int[16], 7'b0000000, D_int[15], 7'b0000000, D_int[14], 7'b0000000, D_int[13],
          7'b0000000, D_int[12], 7'b0000000, D_int[11], 7'b0000000, D_int[10], 7'b0000000, D_int[9],
          7'b0000000, D_int[8], 7'b0000000, D_int[7], 7'b0000000, D_int[6], 7'b0000000, D_int[5],
          7'b0000000, D_int[4], 7'b0000000, D_int[3], 7'b0000000, D_int[2], 7'b0000000, D_int[1],
          7'b0000000, D_int[0]} << mux_address);
        row = (row & ~row_mask) | (row_mask & (~row_mask | new_data));
        mem[row_address] = row;
      end else begin
        data_out = (row >> (mux_address%4));
        readLatch0 = {data_out[252], data_out[248], data_out[244], data_out[240], data_out[236],
          data_out[232], data_out[228], data_out[224], data_out[220], data_out[216],
          data_out[212], data_out[208], data_out[204], data_out[200], data_out[196],
          data_out[192], data_out[188], data_out[184], data_out[180], data_out[176],
          data_out[172], data_out[168], data_out[164], data_out[160], data_out[156],
          data_out[152], data_out[148], data_out[144], data_out[140], data_out[136],
          data_out[132], data_out[128], data_out[124], data_out[120], data_out[116],
          data_out[112], data_out[108], data_out[104], data_out[100], data_out[96],
          data_out[92], data_out[88], data_out[84], data_out[80], data_out[76], data_out[72],
          data_out[68], data_out[64], data_out[60], data_out[56], data_out[52], data_out[48],
          data_out[44], data_out[40], data_out[36], data_out[32], data_out[28], data_out[24],
          data_out[20], data_out[16], data_out[12], data_out[8], data_out[4], data_out[0]};
      end
      if (WEN_int !== 1'b1) begin
        Q_int = D_int;
        Q_int_delayed = D_int;
      end else begin
        shifted_readLatch0 = (readLatch0 >> A_int[2]);
        Q_int = {shifted_readLatch0[62], shifted_readLatch0[60], shifted_readLatch0[58],
          shifted_readLatch0[56], shifted_readLatch0[54], shifted_readLatch0[52], shifted_readLatch0[50],
          shifted_readLatch0[48], shifted_readLatch0[46], shifted_readLatch0[44], shifted_readLatch0[42],
          shifted_readLatch0[40], shifted_readLatch0[38], shifted_readLatch0[36], shifted_readLatch0[34],
          shifted_readLatch0[32], shifted_readLatch0[30], shifted_readLatch0[28], shifted_readLatch0[26],
          shifted_readLatch0[24], shifted_readLatch0[22], shifted_readLatch0[20], shifted_readLatch0[18],
          shifted_readLatch0[16], shifted_readLatch0[14], shifted_readLatch0[12], shifted_readLatch0[10],
          shifted_readLatch0[8], shifted_readLatch0[6], shifted_readLatch0[4], shifted_readLatch0[2],
          shifted_readLatch0[0]};
      end
    end
  end
  endtask
  always @ (CEN_ or TCEN_ or TEN_ or CLK_) begin
  	if(CLK_ == 1'b0) begin
  		CEN_p2 = CEN_;
  		TCEN_p2 = TCEN_;
  	end
  end

  always @ RET1N_ begin
    if (CLK_ == 1'b1) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end
    if (RET1N_ === 1'bx || RET1N_ === 1'bz) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_ === 1'b0 && RET1N_int === 1'b1 && (CEN_p2 === 1'b0 || TCEN_p2 === 1'b0) ) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (RET1N_ === 1'b1 && RET1N_int === 1'b0 && (CEN_p2 === 1'b0 || TCEN_p2 === 1'b0) ) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end
    if (RET1N_ == 1'b0) begin
      Q_int = {32{1'bx}};
      Q_int_delayed = {32{1'bx}};
      CEN_int = 1'bx;
      WEN_int = 1'bx;
      A_int = {11{1'bx}};
      D_int = {32{1'bx}};
      EMA_int = {3{1'bx}};
      EMAW_int = {2{1'bx}};
      EMAS_int = 1'bx;
      TEN_int = 1'bx;
      BEN_int = 1'bx;
      TCEN_int = 1'bx;
      TWEN_int = 1'bx;
      TA_int = {11{1'bx}};
      TD_int = {32{1'bx}};
      TQ_int = {32{1'bx}};
      RET1N_int = 1'bx;
      STOV_int = 1'bx;
    end else begin
      Q_int = {32{1'bx}};
      Q_int_delayed = {32{1'bx}};
      CEN_int = 1'bx;
      WEN_int = 1'bx;
      A_int = {11{1'bx}};
      D_int = {32{1'bx}};
      EMA_int = {3{1'bx}};
      EMAW_int = {2{1'bx}};
      EMAS_int = 1'bx;
      TEN_int = 1'bx;
      BEN_int = 1'bx;
      TCEN_int = 1'bx;
      TWEN_int = 1'bx;
      TA_int = {11{1'bx}};
      TD_int = {32{1'bx}};
      TQ_int = {32{1'bx}};
      RET1N_int = 1'bx;
      STOV_int = 1'bx;
    end
    RET1N_int = RET1N_;
  end


  always @ CLK_ begin
// If POWER_PINS is defined at Simulator Command Line, it selects the module definition with Power Ports
`ifdef POWER_PINS
    if (VDDCE === 1'bx || VDDCE === 1'bz)
      $display("ERROR: Illegal value for VDDCE %b", VDDCE);
    if (VDDPE === 1'bx || VDDPE === 1'bz)
      $display("ERROR: Illegal value for VDDPE %b", VDDPE);
    if (VSSE === 1'bx || VSSE === 1'bz)
      $display("ERROR: Illegal value for VSSE %b", VSSE);
`endif
  if (RET1N_ == 1'b0) begin
      // no cycle in retention mode
  end else begin
    if ((CLK_ === 1'bx || CLK_ === 1'bz) && RET1N_ !== 1'b0) begin
      failedWrite(0);
      Q_int = {32{1'bx}};
    end else if (CLK_ === 1'b1 && LAST_CLK === 1'b0) begin
      CEN_int = TEN_ ? CEN_ : TCEN_;
      EMA_int = EMA_;
      EMAW_int = EMAW_;
      EMAS_int = EMAS_;
      TEN_int = TEN_;
      BEN_int = BEN_;
      TWEN_int = TWEN_;
      TQ_int = TQ_;
      RET1N_int = RET1N_;
      STOV_int = STOV_;
      if (CEN_int != 1'b1) begin
        WEN_int = TEN_ ? WEN_ : TWEN_;
        A_int = TEN_ ? A_ : TA_;
        D_int = TEN_ ? D_ : TD_;
        TCEN_int = TCEN_;
        TA_int = TA_;
        TD_int = TD_;
        if (WEN_int === 1'b1)
          read_mux_sel0 = (TEN_ ? A_[2] : TA_[2] );
      end
      clk0_int = 1'b0;
      if (CEN_int === 1'b0 && WEN_int === 1'b1) 
         Q_int_delayed = {32{1'bx}};
    readWrite;
    end else if (CLK_ === 1'b0 && LAST_CLK === 1'b1) begin
      Q_int_delayed = Q_int;
    end
    LAST_CLK = CLK_;
  end
  end

  reg globalNotifier0;
  initial globalNotifier0 = 1'b0;

  always @ globalNotifier0 begin
    if ($realtime == 0) begin
    end else if (CEN_int === 1'bx || EMAS_int === 1'bx || EMAW_int[0] === 1'bx || 
      EMAW_int[1] === 1'bx || EMA_int[0] === 1'bx || EMA_int[1] === 1'bx || EMA_int[2] === 1'bx || 
      RET1N_int === 1'bx || (STOV_int && !CEN_int) === 1'bx || TEN_int === 1'bx || 
      clk0_int === 1'bx) begin
      Q_int = {32{1'bx}};
    if (clk0_int === 1'bx || CEN_int === 1'bx) begin
      D_int = {32{1'bx}};
    end
      failedWrite(0);
    end else begin
      readWrite;
   end
    globalNotifier0 = 1'b0;
  end

  always @ NOT_CEN begin
    CEN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_WEN begin
    WEN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A10 begin
    A_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A9 begin
    A_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A8 begin
    A_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A7 begin
    A_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A6 begin
    A_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A5 begin
    A_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A4 begin
    A_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A3 begin
    A_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A2 begin
    A_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A1 begin
    A_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_A0 begin
    A_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D31 begin
    D_int[31] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D30 begin
    D_int[30] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D29 begin
    D_int[29] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D28 begin
    D_int[28] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D27 begin
    D_int[27] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D26 begin
    D_int[26] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D25 begin
    D_int[25] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D24 begin
    D_int[24] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D23 begin
    D_int[23] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D22 begin
    D_int[22] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D21 begin
    D_int[21] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D20 begin
    D_int[20] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D19 begin
    D_int[19] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D18 begin
    D_int[18] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D17 begin
    D_int[17] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D16 begin
    D_int[16] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D15 begin
    D_int[15] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D14 begin
    D_int[14] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D13 begin
    D_int[13] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D12 begin
    D_int[12] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D11 begin
    D_int[11] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D10 begin
    D_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D9 begin
    D_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D8 begin
    D_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D7 begin
    D_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D6 begin
    D_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D5 begin
    D_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D4 begin
    D_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D3 begin
    D_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D2 begin
    D_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D1 begin
    D_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_D0 begin
    D_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMA2 begin
    EMA_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMA1 begin
    EMA_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMA0 begin
    EMA_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAW1 begin
    EMAW_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAW0 begin
    EMAW_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_EMAS begin
    EMAS_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TEN begin
    TEN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TCEN begin
    CEN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TWEN begin
    WEN_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA10 begin
    A_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA9 begin
    A_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA8 begin
    A_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA7 begin
    A_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA6 begin
    A_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA5 begin
    A_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA4 begin
    A_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA3 begin
    A_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA2 begin
    A_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA1 begin
    A_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TA0 begin
    A_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD31 begin
    D_int[31] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD30 begin
    D_int[30] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD29 begin
    D_int[29] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD28 begin
    D_int[28] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD27 begin
    D_int[27] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD26 begin
    D_int[26] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD25 begin
    D_int[25] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD24 begin
    D_int[24] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD23 begin
    D_int[23] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD22 begin
    D_int[22] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD21 begin
    D_int[21] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD20 begin
    D_int[20] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD19 begin
    D_int[19] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD18 begin
    D_int[18] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD17 begin
    D_int[17] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD16 begin
    D_int[16] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD15 begin
    D_int[15] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD14 begin
    D_int[14] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD13 begin
    D_int[13] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD12 begin
    D_int[12] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD11 begin
    D_int[11] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD10 begin
    D_int[10] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD9 begin
    D_int[9] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD8 begin
    D_int[8] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD7 begin
    D_int[7] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD6 begin
    D_int[6] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD5 begin
    D_int[5] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD4 begin
    D_int[4] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD3 begin
    D_int[3] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD2 begin
    D_int[2] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD1 begin
    D_int[1] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_TD0 begin
    D_int[0] = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_RET1N begin
    RET1N_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_STOV begin
    STOV_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end

  always @ NOT_CLK_PER begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLK_MINH begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end
  always @ NOT_CLK_MINL begin
    clk0_int = 1'bx;
    if ( globalNotifier0 === 1'b0 ) globalNotifier0 = 1'bx;
  end


  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire STOVeq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp;
  wire opopTENeq1andCENeq0cporopTENeq0andTCENeq0cpcp;
  wire opTENeq1andCENeq0cporopTENeq0andTCENeq0cp;

  wire STOVeq0, STOVeq1andEMASeq0, STOVeq1andEMASeq1, TENeq1andCENeq0, TENeq1andCENeq0andWENeq0;
  wire TENeq0andTCENeq0, TENeq0andTCENeq0andTWENeq0, TENeq1, TENeq0;

  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (!EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (!EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (!EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (!EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (!EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (!EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (!EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (!EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (EMA[0]) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (EMA[0]) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (STOV) && (!EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp = 
         (STOV) && (EMAS) && ((TEN && WEN) || (!TEN && TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (!EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (!EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (!EMA[1]) && (EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (!EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (!EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (!EMA[2]) && (EMA[1]) && (EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (!EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (!EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (!EMA[1]) && (EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (!EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (!EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (!EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (EMA[0]) && (!EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (EMA[0]) && (!EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (EMA[0]) && (EMAW[1]) && (!EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (!STOV) && (EMA[2]) && (EMA[1]) && (EMA[0]) && (EMAW[1]) && (EMAW[0]) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp = 
         (STOV) && ((TEN && !WEN) || (!TEN && !TWEN)) && !(TEN ? CEN : TCEN);
  assign STOVeq1andEMASeq0 = 
         (STOV) && (!EMAS) && !(TEN ? CEN : TCEN);
  assign STOVeq1andEMASeq1 = 
         (STOV) && (EMAS) && !(TEN ? CEN : TCEN);
  assign TENeq1andCENeq0 = 
         !(!TEN || CEN);
  assign TENeq1andCENeq0andWENeq0 = 
         !(!TEN ||  CEN || WEN);
  assign TENeq0andTCENeq0 = 
         !(TEN || TCEN);
  assign TENeq0andTCENeq0andTWENeq0 = 
         !(TEN ||  TCEN || TWEN);
  assign opopTENeq1andCENeq0cporopTENeq0andTCENeq0cpcp = 
         ((TEN ? CEN : TCEN));
  assign opTENeq1andCENeq0cporopTENeq0andTCENeq0cp = 
         !(TEN ? CEN : TCEN);

  assign STOVeq0 = (!STOV) && !(TEN ? CEN : TCEN);
  assign TENeq1 = TEN;
  assign TENeq0 = !TEN;

  specify
    if (CEN == 1'b0 && TCEN == 1'b1)
       (TEN => CENY) = (1.000, 1.000);
    if (CEN == 1'b1 && TCEN == 1'b0)
       (TEN => CENY) = (1.000, 1.000);
    if (TEN == 1'b1)
       (CEN => CENY) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TCEN => CENY) = (1.000, 1.000);
    if (WEN == 1'b0 && TWEN == 1'b1)
       (TEN => WENY) = (1.000, 1.000);
    if (WEN == 1'b1 && TWEN == 1'b0)
       (TEN => WENY) = (1.000, 1.000);
    if (TEN == 1'b1)
       (WEN => WENY) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TWEN => WENY) = (1.000, 1.000);
    if (A[10] == 1'b0 && TA[10] == 1'b1)
       (TEN => AY[10]) = (1.000, 1.000);
    if (A[10] == 1'b1 && TA[10] == 1'b0)
       (TEN => AY[10]) = (1.000, 1.000);
    if (A[9] == 1'b0 && TA[9] == 1'b1)
       (TEN => AY[9]) = (1.000, 1.000);
    if (A[9] == 1'b1 && TA[9] == 1'b0)
       (TEN => AY[9]) = (1.000, 1.000);
    if (A[8] == 1'b0 && TA[8] == 1'b1)
       (TEN => AY[8]) = (1.000, 1.000);
    if (A[8] == 1'b1 && TA[8] == 1'b0)
       (TEN => AY[8]) = (1.000, 1.000);
    if (A[7] == 1'b0 && TA[7] == 1'b1)
       (TEN => AY[7]) = (1.000, 1.000);
    if (A[7] == 1'b1 && TA[7] == 1'b0)
       (TEN => AY[7]) = (1.000, 1.000);
    if (A[6] == 1'b0 && TA[6] == 1'b1)
       (TEN => AY[6]) = (1.000, 1.000);
    if (A[6] == 1'b1 && TA[6] == 1'b0)
       (TEN => AY[6]) = (1.000, 1.000);
    if (A[5] == 1'b0 && TA[5] == 1'b1)
       (TEN => AY[5]) = (1.000, 1.000);
    if (A[5] == 1'b1 && TA[5] == 1'b0)
       (TEN => AY[5]) = (1.000, 1.000);
    if (A[4] == 1'b0 && TA[4] == 1'b1)
       (TEN => AY[4]) = (1.000, 1.000);
    if (A[4] == 1'b1 && TA[4] == 1'b0)
       (TEN => AY[4]) = (1.000, 1.000);
    if (A[3] == 1'b0 && TA[3] == 1'b1)
       (TEN => AY[3]) = (1.000, 1.000);
    if (A[3] == 1'b1 && TA[3] == 1'b0)
       (TEN => AY[3]) = (1.000, 1.000);
    if (A[2] == 1'b0 && TA[2] == 1'b1)
       (TEN => AY[2]) = (1.000, 1.000);
    if (A[2] == 1'b1 && TA[2] == 1'b0)
       (TEN => AY[2]) = (1.000, 1.000);
    if (A[1] == 1'b0 && TA[1] == 1'b1)
       (TEN => AY[1]) = (1.000, 1.000);
    if (A[1] == 1'b1 && TA[1] == 1'b0)
       (TEN => AY[1]) = (1.000, 1.000);
    if (A[0] == 1'b0 && TA[0] == 1'b1)
       (TEN => AY[0]) = (1.000, 1.000);
    if (A[0] == 1'b1 && TA[0] == 1'b0)
       (TEN => AY[0]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[10] => AY[10]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[9] => AY[9]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[8] => AY[8]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[7] => AY[7]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[6] => AY[6]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[5] => AY[5]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[4] => AY[4]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[3] => AY[3]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[2] => AY[2]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[1] => AY[1]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (A[0] => AY[0]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[10] => AY[10]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[9] => AY[9]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[8] => AY[8]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[7] => AY[7]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[6] => AY[6]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[5] => AY[5]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[4] => AY[4]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[3] => AY[3]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[2] => AY[2]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[1] => AY[1]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TA[0] => AY[0]) = (1.000, 1.000);
    if (D[31] == 1'b0 && TD[31] == 1'b1)
       (TEN => DY[31]) = (1.000, 1.000);
    if (D[31] == 1'b1 && TD[31] == 1'b0)
       (TEN => DY[31]) = (1.000, 1.000);
    if (D[30] == 1'b0 && TD[30] == 1'b1)
       (TEN => DY[30]) = (1.000, 1.000);
    if (D[30] == 1'b1 && TD[30] == 1'b0)
       (TEN => DY[30]) = (1.000, 1.000);
    if (D[29] == 1'b0 && TD[29] == 1'b1)
       (TEN => DY[29]) = (1.000, 1.000);
    if (D[29] == 1'b1 && TD[29] == 1'b0)
       (TEN => DY[29]) = (1.000, 1.000);
    if (D[28] == 1'b0 && TD[28] == 1'b1)
       (TEN => DY[28]) = (1.000, 1.000);
    if (D[28] == 1'b1 && TD[28] == 1'b0)
       (TEN => DY[28]) = (1.000, 1.000);
    if (D[27] == 1'b0 && TD[27] == 1'b1)
       (TEN => DY[27]) = (1.000, 1.000);
    if (D[27] == 1'b1 && TD[27] == 1'b0)
       (TEN => DY[27]) = (1.000, 1.000);
    if (D[26] == 1'b0 && TD[26] == 1'b1)
       (TEN => DY[26]) = (1.000, 1.000);
    if (D[26] == 1'b1 && TD[26] == 1'b0)
       (TEN => DY[26]) = (1.000, 1.000);
    if (D[25] == 1'b0 && TD[25] == 1'b1)
       (TEN => DY[25]) = (1.000, 1.000);
    if (D[25] == 1'b1 && TD[25] == 1'b0)
       (TEN => DY[25]) = (1.000, 1.000);
    if (D[24] == 1'b0 && TD[24] == 1'b1)
       (TEN => DY[24]) = (1.000, 1.000);
    if (D[24] == 1'b1 && TD[24] == 1'b0)
       (TEN => DY[24]) = (1.000, 1.000);
    if (D[23] == 1'b0 && TD[23] == 1'b1)
       (TEN => DY[23]) = (1.000, 1.000);
    if (D[23] == 1'b1 && TD[23] == 1'b0)
       (TEN => DY[23]) = (1.000, 1.000);
    if (D[22] == 1'b0 && TD[22] == 1'b1)
       (TEN => DY[22]) = (1.000, 1.000);
    if (D[22] == 1'b1 && TD[22] == 1'b0)
       (TEN => DY[22]) = (1.000, 1.000);
    if (D[21] == 1'b0 && TD[21] == 1'b1)
       (TEN => DY[21]) = (1.000, 1.000);
    if (D[21] == 1'b1 && TD[21] == 1'b0)
       (TEN => DY[21]) = (1.000, 1.000);
    if (D[20] == 1'b0 && TD[20] == 1'b1)
       (TEN => DY[20]) = (1.000, 1.000);
    if (D[20] == 1'b1 && TD[20] == 1'b0)
       (TEN => DY[20]) = (1.000, 1.000);
    if (D[19] == 1'b0 && TD[19] == 1'b1)
       (TEN => DY[19]) = (1.000, 1.000);
    if (D[19] == 1'b1 && TD[19] == 1'b0)
       (TEN => DY[19]) = (1.000, 1.000);
    if (D[18] == 1'b0 && TD[18] == 1'b1)
       (TEN => DY[18]) = (1.000, 1.000);
    if (D[18] == 1'b1 && TD[18] == 1'b0)
       (TEN => DY[18]) = (1.000, 1.000);
    if (D[17] == 1'b0 && TD[17] == 1'b1)
       (TEN => DY[17]) = (1.000, 1.000);
    if (D[17] == 1'b1 && TD[17] == 1'b0)
       (TEN => DY[17]) = (1.000, 1.000);
    if (D[16] == 1'b0 && TD[16] == 1'b1)
       (TEN => DY[16]) = (1.000, 1.000);
    if (D[16] == 1'b1 && TD[16] == 1'b0)
       (TEN => DY[16]) = (1.000, 1.000);
    if (D[15] == 1'b0 && TD[15] == 1'b1)
       (TEN => DY[15]) = (1.000, 1.000);
    if (D[15] == 1'b1 && TD[15] == 1'b0)
       (TEN => DY[15]) = (1.000, 1.000);
    if (D[14] == 1'b0 && TD[14] == 1'b1)
       (TEN => DY[14]) = (1.000, 1.000);
    if (D[14] == 1'b1 && TD[14] == 1'b0)
       (TEN => DY[14]) = (1.000, 1.000);
    if (D[13] == 1'b0 && TD[13] == 1'b1)
       (TEN => DY[13]) = (1.000, 1.000);
    if (D[13] == 1'b1 && TD[13] == 1'b0)
       (TEN => DY[13]) = (1.000, 1.000);
    if (D[12] == 1'b0 && TD[12] == 1'b1)
       (TEN => DY[12]) = (1.000, 1.000);
    if (D[12] == 1'b1 && TD[12] == 1'b0)
       (TEN => DY[12]) = (1.000, 1.000);
    if (D[11] == 1'b0 && TD[11] == 1'b1)
       (TEN => DY[11]) = (1.000, 1.000);
    if (D[11] == 1'b1 && TD[11] == 1'b0)
       (TEN => DY[11]) = (1.000, 1.000);
    if (D[10] == 1'b0 && TD[10] == 1'b1)
       (TEN => DY[10]) = (1.000, 1.000);
    if (D[10] == 1'b1 && TD[10] == 1'b0)
       (TEN => DY[10]) = (1.000, 1.000);
    if (D[9] == 1'b0 && TD[9] == 1'b1)
       (TEN => DY[9]) = (1.000, 1.000);
    if (D[9] == 1'b1 && TD[9] == 1'b0)
       (TEN => DY[9]) = (1.000, 1.000);
    if (D[8] == 1'b0 && TD[8] == 1'b1)
       (TEN => DY[8]) = (1.000, 1.000);
    if (D[8] == 1'b1 && TD[8] == 1'b0)
       (TEN => DY[8]) = (1.000, 1.000);
    if (D[7] == 1'b0 && TD[7] == 1'b1)
       (TEN => DY[7]) = (1.000, 1.000);
    if (D[7] == 1'b1 && TD[7] == 1'b0)
       (TEN => DY[7]) = (1.000, 1.000);
    if (D[6] == 1'b0 && TD[6] == 1'b1)
       (TEN => DY[6]) = (1.000, 1.000);
    if (D[6] == 1'b1 && TD[6] == 1'b0)
       (TEN => DY[6]) = (1.000, 1.000);
    if (D[5] == 1'b0 && TD[5] == 1'b1)
       (TEN => DY[5]) = (1.000, 1.000);
    if (D[5] == 1'b1 && TD[5] == 1'b0)
       (TEN => DY[5]) = (1.000, 1.000);
    if (D[4] == 1'b0 && TD[4] == 1'b1)
       (TEN => DY[4]) = (1.000, 1.000);
    if (D[4] == 1'b1 && TD[4] == 1'b0)
       (TEN => DY[4]) = (1.000, 1.000);
    if (D[3] == 1'b0 && TD[3] == 1'b1)
       (TEN => DY[3]) = (1.000, 1.000);
    if (D[3] == 1'b1 && TD[3] == 1'b0)
       (TEN => DY[3]) = (1.000, 1.000);
    if (D[2] == 1'b0 && TD[2] == 1'b1)
       (TEN => DY[2]) = (1.000, 1.000);
    if (D[2] == 1'b1 && TD[2] == 1'b0)
       (TEN => DY[2]) = (1.000, 1.000);
    if (D[1] == 1'b0 && TD[1] == 1'b1)
       (TEN => DY[1]) = (1.000, 1.000);
    if (D[1] == 1'b1 && TD[1] == 1'b0)
       (TEN => DY[1]) = (1.000, 1.000);
    if (D[0] == 1'b0 && TD[0] == 1'b1)
       (TEN => DY[0]) = (1.000, 1.000);
    if (D[0] == 1'b1 && TD[0] == 1'b0)
       (TEN => DY[0]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[31] => DY[31]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[30] => DY[30]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[29] => DY[29]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[28] => DY[28]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[27] => DY[27]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[26] => DY[26]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[25] => DY[25]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[24] => DY[24]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[23] => DY[23]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[22] => DY[22]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[21] => DY[21]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[20] => DY[20]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[19] => DY[19]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[18] => DY[18]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[17] => DY[17]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[16] => DY[16]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[15] => DY[15]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[14] => DY[14]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[13] => DY[13]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[12] => DY[12]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[11] => DY[11]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[10] => DY[10]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[9] => DY[9]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[8] => DY[8]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[7] => DY[7]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[6] => DY[6]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[5] => DY[5]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[4] => DY[4]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[3] => DY[3]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[2] => DY[2]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[1] => DY[1]) = (1.000, 1.000);
    if (TEN == 1'b1)
       (D[0] => DY[0]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[31] => DY[31]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[30] => DY[30]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[29] => DY[29]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[28] => DY[28]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[27] => DY[27]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[26] => DY[26]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[25] => DY[25]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[24] => DY[24]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[23] => DY[23]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[22] => DY[22]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[21] => DY[21]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[20] => DY[20]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[19] => DY[19]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[18] => DY[18]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[17] => DY[17]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[16] => DY[16]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[15] => DY[15]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[14] => DY[14]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[13] => DY[13]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[12] => DY[12]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[11] => DY[11]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[10] => DY[10]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[9] => DY[9]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[8] => DY[8]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[7] => DY[7]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[6] => DY[6]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[5] => DY[5]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[4] => DY[4]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[3] => DY[3]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[2] => DY[2]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[1] => DY[1]) = (1.000, 1.000);
    if (TEN == 1'b0)
       (TD[0] => DY[0]) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b0 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b0 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b0 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && EMA[2] == 1'b1 && EMA[1] == 1'b1 && EMA[0] == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b1) || (TEN == 1'b0 && TWEN == 1'b1)))
       (negedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b0 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[31] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[30] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[29] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[28] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[27] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[26] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[25] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[24] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[23] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[22] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[21] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[20] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[19] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[18] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[17] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[16] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[15] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[14] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[13] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[12] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[11] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[10] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[9] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[8] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[7] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[6] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[5] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[4] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[3] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[2] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[1] : 1'b0)) = (1.000, 1.000);
    if (RET1N == 1'b1 && BEN == 1'b1 && STOV == 1'b1 && ((TEN == 1'b1 && WEN == 1'b0) || (TEN == 1'b0 && TWEN == 1'b0)))
       (posedge CLK => (Q[0] : 1'b0)) = (1.000, 1.000);
    if (TQ[31] == 1'b1)
       (BEN => Q[31]) = (1.000, 1.000);
    if (TQ[31] == 1'b0)
       (BEN => Q[31]) = (1.000, 1.000);
    if (TQ[30] == 1'b1)
       (BEN => Q[30]) = (1.000, 1.000);
    if (TQ[30] == 1'b0)
       (BEN => Q[30]) = (1.000, 1.000);
    if (TQ[29] == 1'b1)
       (BEN => Q[29]) = (1.000, 1.000);
    if (TQ[29] == 1'b0)
       (BEN => Q[29]) = (1.000, 1.000);
    if (TQ[28] == 1'b1)
       (BEN => Q[28]) = (1.000, 1.000);
    if (TQ[28] == 1'b0)
       (BEN => Q[28]) = (1.000, 1.000);
    if (TQ[27] == 1'b1)
       (BEN => Q[27]) = (1.000, 1.000);
    if (TQ[27] == 1'b0)
       (BEN => Q[27]) = (1.000, 1.000);
    if (TQ[26] == 1'b1)
       (BEN => Q[26]) = (1.000, 1.000);
    if (TQ[26] == 1'b0)
       (BEN => Q[26]) = (1.000, 1.000);
    if (TQ[25] == 1'b1)
       (BEN => Q[25]) = (1.000, 1.000);
    if (TQ[25] == 1'b0)
       (BEN => Q[25]) = (1.000, 1.000);
    if (TQ[24] == 1'b1)
       (BEN => Q[24]) = (1.000, 1.000);
    if (TQ[24] == 1'b0)
       (BEN => Q[24]) = (1.000, 1.000);
    if (TQ[23] == 1'b1)
       (BEN => Q[23]) = (1.000, 1.000);
    if (TQ[23] == 1'b0)
       (BEN => Q[23]) = (1.000, 1.000);
    if (TQ[22] == 1'b1)
       (BEN => Q[22]) = (1.000, 1.000);
    if (TQ[22] == 1'b0)
       (BEN => Q[22]) = (1.000, 1.000);
    if (TQ[21] == 1'b1)
       (BEN => Q[21]) = (1.000, 1.000);
    if (TQ[21] == 1'b0)
       (BEN => Q[21]) = (1.000, 1.000);
    if (TQ[20] == 1'b1)
       (BEN => Q[20]) = (1.000, 1.000);
    if (TQ[20] == 1'b0)
       (BEN => Q[20]) = (1.000, 1.000);
    if (TQ[19] == 1'b1)
       (BEN => Q[19]) = (1.000, 1.000);
    if (TQ[19] == 1'b0)
       (BEN => Q[19]) = (1.000, 1.000);
    if (TQ[18] == 1'b1)
       (BEN => Q[18]) = (1.000, 1.000);
    if (TQ[18] == 1'b0)
       (BEN => Q[18]) = (1.000, 1.000);
    if (TQ[17] == 1'b1)
       (BEN => Q[17]) = (1.000, 1.000);
    if (TQ[17] == 1'b0)
       (BEN => Q[17]) = (1.000, 1.000);
    if (TQ[16] == 1'b1)
       (BEN => Q[16]) = (1.000, 1.000);
    if (TQ[16] == 1'b0)
       (BEN => Q[16]) = (1.000, 1.000);
    if (TQ[15] == 1'b1)
       (BEN => Q[15]) = (1.000, 1.000);
    if (TQ[15] == 1'b0)
       (BEN => Q[15]) = (1.000, 1.000);
    if (TQ[14] == 1'b1)
       (BEN => Q[14]) = (1.000, 1.000);
    if (TQ[14] == 1'b0)
       (BEN => Q[14]) = (1.000, 1.000);
    if (TQ[13] == 1'b1)
       (BEN => Q[13]) = (1.000, 1.000);
    if (TQ[13] == 1'b0)
       (BEN => Q[13]) = (1.000, 1.000);
    if (TQ[12] == 1'b1)
       (BEN => Q[12]) = (1.000, 1.000);
    if (TQ[12] == 1'b0)
       (BEN => Q[12]) = (1.000, 1.000);
    if (TQ[11] == 1'b1)
       (BEN => Q[11]) = (1.000, 1.000);
    if (TQ[11] == 1'b0)
       (BEN => Q[11]) = (1.000, 1.000);
    if (TQ[10] == 1'b1)
       (BEN => Q[10]) = (1.000, 1.000);
    if (TQ[10] == 1'b0)
       (BEN => Q[10]) = (1.000, 1.000);
    if (TQ[9] == 1'b1)
       (BEN => Q[9]) = (1.000, 1.000);
    if (TQ[9] == 1'b0)
       (BEN => Q[9]) = (1.000, 1.000);
    if (TQ[8] == 1'b1)
       (BEN => Q[8]) = (1.000, 1.000);
    if (TQ[8] == 1'b0)
       (BEN => Q[8]) = (1.000, 1.000);
    if (TQ[7] == 1'b1)
       (BEN => Q[7]) = (1.000, 1.000);
    if (TQ[7] == 1'b0)
       (BEN => Q[7]) = (1.000, 1.000);
    if (TQ[6] == 1'b1)
       (BEN => Q[6]) = (1.000, 1.000);
    if (TQ[6] == 1'b0)
       (BEN => Q[6]) = (1.000, 1.000);
    if (TQ[5] == 1'b1)
       (BEN => Q[5]) = (1.000, 1.000);
    if (TQ[5] == 1'b0)
       (BEN => Q[5]) = (1.000, 1.000);
    if (TQ[4] == 1'b1)
       (BEN => Q[4]) = (1.000, 1.000);
    if (TQ[4] == 1'b0)
       (BEN => Q[4]) = (1.000, 1.000);
    if (TQ[3] == 1'b1)
       (BEN => Q[3]) = (1.000, 1.000);
    if (TQ[3] == 1'b0)
       (BEN => Q[3]) = (1.000, 1.000);
    if (TQ[2] == 1'b1)
       (BEN => Q[2]) = (1.000, 1.000);
    if (TQ[2] == 1'b0)
       (BEN => Q[2]) = (1.000, 1.000);
    if (TQ[1] == 1'b1)
       (BEN => Q[1]) = (1.000, 1.000);
    if (TQ[1] == 1'b0)
       (BEN => Q[1]) = (1.000, 1.000);
    if (TQ[0] == 1'b1)
       (BEN => Q[0]) = (1.000, 1.000);
    if (TQ[0] == 1'b0)
       (BEN => Q[0]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[31] => Q[31]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[30] => Q[30]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[29] => Q[29]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[28] => Q[28]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[27] => Q[27]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[26] => Q[26]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[25] => Q[25]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[24] => Q[24]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[23] => Q[23]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[22] => Q[22]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[21] => Q[21]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[20] => Q[20]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[19] => Q[19]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[18] => Q[18]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[17] => Q[17]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[16] => Q[16]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[15] => Q[15]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[14] => Q[14]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[13] => Q[13]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[12] => Q[12]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[11] => Q[11]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[10] => Q[10]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[9] => Q[9]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[8] => Q[8]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[7] => Q[7]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[6] => Q[6]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[5] => Q[5]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[4] => Q[4]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[3] => Q[3]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[2] => Q[2]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[1] => Q[1]) = (1.000, 1.000);
    if (BEN == 1'b0)
       (TQ[0] => Q[0]) = (1.000, 1.000);

// Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $period(posedge CLK, 3.000, NOT_CLK_PER);
   `else
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(negedge CLK &&& STOVeq1andEMASeq0andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(negedge CLK &&& STOVeq1andEMASeq1andopopTENeq1andWENeq1cporopTENeq0andTWENeq1cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq0andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq0andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq0andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq0andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq0andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq0andEMA2eq1andEMA1eq1andEMA0eq1andEMAW1eq1andEMAW0eq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
       $period(posedge CLK &&& STOVeq1andopopTENeq1andWENeq0cporopTENeq0andTWENeq0cpcp, 3.000, NOT_CLK_PER);
   `endif

// Define SDTC only if back-annotating SDF file generated by Design Compiler
   `ifdef NO_SDTC
       $width(posedge CLK, 1.000, 0, NOT_CLK_MINH);
       $width(negedge CLK, 1.000, 0, NOT_CLK_MINL);
   `else
       $width(posedge CLK &&& STOVeq0, 1.000, 0, NOT_CLK_MINH);
       $width(negedge CLK &&& STOVeq0, 1.000, 0, NOT_CLK_MINL);
       $width(posedge CLK &&& STOVeq1andEMASeq0, 1.000, 0, NOT_CLK_MINH);
       $width(negedge CLK &&& STOVeq1andEMASeq0, 1.000, 0, NOT_CLK_MINL);
       $width(posedge CLK &&& STOVeq1andEMASeq1, 1.000, 0, NOT_CLK_MINH);
       $width(negedge CLK &&& STOVeq1andEMASeq1, 1.000, 0, NOT_CLK_MINL);
   `endif

    $setuphold(posedge CLK &&& TENeq1, posedge CEN, 1.000, 0.500, NOT_CEN);
    $setuphold(posedge CLK &&& TENeq1, negedge CEN, 1.000, 0.500, NOT_CEN);
    $setuphold(posedge RET1N &&& TENeq1, negedge CEN, 0.000, 0.500, NOT_RET1N);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge WEN, 1.000, 0.500, NOT_WEN);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge WEN, 1.000, 0.500, NOT_WEN);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[10], 1.000, 0.500, NOT_A10);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[9], 1.000, 0.500, NOT_A9);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[8], 1.000, 0.500, NOT_A8);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[7], 1.000, 0.500, NOT_A7);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[6], 1.000, 0.500, NOT_A6);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[5], 1.000, 0.500, NOT_A5);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[4], 1.000, 0.500, NOT_A4);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[3], 1.000, 0.500, NOT_A3);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[2], 1.000, 0.500, NOT_A2);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[1], 1.000, 0.500, NOT_A1);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, posedge A[0], 1.000, 0.500, NOT_A0);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[10], 1.000, 0.500, NOT_A10);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[9], 1.000, 0.500, NOT_A9);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[8], 1.000, 0.500, NOT_A8);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[7], 1.000, 0.500, NOT_A7);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[6], 1.000, 0.500, NOT_A6);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[5], 1.000, 0.500, NOT_A5);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[4], 1.000, 0.500, NOT_A4);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[3], 1.000, 0.500, NOT_A3);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[2], 1.000, 0.500, NOT_A2);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[1], 1.000, 0.500, NOT_A1);
    $setuphold(posedge CLK &&& TENeq1andCENeq0, negedge A[0], 1.000, 0.500, NOT_A0);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[31], 1.000, 0.500, NOT_D31);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[30], 1.000, 0.500, NOT_D30);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[29], 1.000, 0.500, NOT_D29);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[28], 1.000, 0.500, NOT_D28);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[27], 1.000, 0.500, NOT_D27);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[26], 1.000, 0.500, NOT_D26);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[25], 1.000, 0.500, NOT_D25);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[24], 1.000, 0.500, NOT_D24);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[23], 1.000, 0.500, NOT_D23);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[22], 1.000, 0.500, NOT_D22);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[21], 1.000, 0.500, NOT_D21);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[20], 1.000, 0.500, NOT_D20);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[19], 1.000, 0.500, NOT_D19);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[18], 1.000, 0.500, NOT_D18);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[17], 1.000, 0.500, NOT_D17);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[16], 1.000, 0.500, NOT_D16);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[15], 1.000, 0.500, NOT_D15);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[14], 1.000, 0.500, NOT_D14);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[13], 1.000, 0.500, NOT_D13);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[12], 1.000, 0.500, NOT_D12);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[11], 1.000, 0.500, NOT_D11);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[10], 1.000, 0.500, NOT_D10);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[9], 1.000, 0.500, NOT_D9);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[8], 1.000, 0.500, NOT_D8);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[7], 1.000, 0.500, NOT_D7);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[6], 1.000, 0.500, NOT_D6);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[5], 1.000, 0.500, NOT_D5);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[4], 1.000, 0.500, NOT_D4);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[3], 1.000, 0.500, NOT_D3);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[2], 1.000, 0.500, NOT_D2);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[1], 1.000, 0.500, NOT_D1);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, posedge D[0], 1.000, 0.500, NOT_D0);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[31], 1.000, 0.500, NOT_D31);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[30], 1.000, 0.500, NOT_D30);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[29], 1.000, 0.500, NOT_D29);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[28], 1.000, 0.500, NOT_D28);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[27], 1.000, 0.500, NOT_D27);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[26], 1.000, 0.500, NOT_D26);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[25], 1.000, 0.500, NOT_D25);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[24], 1.000, 0.500, NOT_D24);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[23], 1.000, 0.500, NOT_D23);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[22], 1.000, 0.500, NOT_D22);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[21], 1.000, 0.500, NOT_D21);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[20], 1.000, 0.500, NOT_D20);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[19], 1.000, 0.500, NOT_D19);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[18], 1.000, 0.500, NOT_D18);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[17], 1.000, 0.500, NOT_D17);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[16], 1.000, 0.500, NOT_D16);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[15], 1.000, 0.500, NOT_D15);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[14], 1.000, 0.500, NOT_D14);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[13], 1.000, 0.500, NOT_D13);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[12], 1.000, 0.500, NOT_D12);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[11], 1.000, 0.500, NOT_D11);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[10], 1.000, 0.500, NOT_D10);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[9], 1.000, 0.500, NOT_D9);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[8], 1.000, 0.500, NOT_D8);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[7], 1.000, 0.500, NOT_D7);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[6], 1.000, 0.500, NOT_D6);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[5], 1.000, 0.500, NOT_D5);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[4], 1.000, 0.500, NOT_D4);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[3], 1.000, 0.500, NOT_D3);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[2], 1.000, 0.500, NOT_D2);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[1], 1.000, 0.500, NOT_D1);
    $setuphold(posedge CLK &&& TENeq1andCENeq0andWENeq0, negedge D[0], 1.000, 0.500, NOT_D0);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge EMA[2], 1.000, 0.500, NOT_EMA2);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge EMA[1], 1.000, 0.500, NOT_EMA1);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge EMA[0], 1.000, 0.500, NOT_EMA0);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge EMA[2], 1.000, 0.500, NOT_EMA2);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge EMA[1], 1.000, 0.500, NOT_EMA1);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge EMA[0], 1.000, 0.500, NOT_EMA0);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge EMAW[1], 1.000, 0.500, NOT_EMAW1);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge EMAW[0], 1.000, 0.500, NOT_EMAW0);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge EMAW[1], 1.000, 0.500, NOT_EMAW1);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge EMAW[0], 1.000, 0.500, NOT_EMAW0);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge EMAS, 1.000, 0.500, NOT_EMAS);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge EMAS, 1.000, 0.500, NOT_EMAS);
    $setuphold(posedge CLK, posedge TEN, 1.000, 0.500, NOT_TEN);
    $setuphold(posedge CLK, negedge TEN, 1.000, 0.500, NOT_TEN);
    $setuphold(posedge CLK &&& TENeq0, posedge TCEN, 1.000, 0.500, NOT_TCEN);
    $setuphold(posedge CLK &&& TENeq0, negedge TCEN, 1.000, 0.500, NOT_TCEN);
    $setuphold(posedge RET1N &&& TENeq0, negedge TCEN, 0.000, 0.500, NOT_RET1N);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TWEN, 1.000, 0.500, NOT_TWEN);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TWEN, 1.000, 0.500, NOT_TWEN);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[10], 1.000, 0.500, NOT_TA10);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[9], 1.000, 0.500, NOT_TA9);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[8], 1.000, 0.500, NOT_TA8);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[7], 1.000, 0.500, NOT_TA7);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[6], 1.000, 0.500, NOT_TA6);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[5], 1.000, 0.500, NOT_TA5);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[4], 1.000, 0.500, NOT_TA4);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[3], 1.000, 0.500, NOT_TA3);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[2], 1.000, 0.500, NOT_TA2);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[1], 1.000, 0.500, NOT_TA1);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, posedge TA[0], 1.000, 0.500, NOT_TA0);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[10], 1.000, 0.500, NOT_TA10);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[9], 1.000, 0.500, NOT_TA9);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[8], 1.000, 0.500, NOT_TA8);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[7], 1.000, 0.500, NOT_TA7);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[6], 1.000, 0.500, NOT_TA6);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[5], 1.000, 0.500, NOT_TA5);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[4], 1.000, 0.500, NOT_TA4);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[3], 1.000, 0.500, NOT_TA3);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[2], 1.000, 0.500, NOT_TA2);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[1], 1.000, 0.500, NOT_TA1);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0, negedge TA[0], 1.000, 0.500, NOT_TA0);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[31], 1.000, 0.500, NOT_TD31);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[30], 1.000, 0.500, NOT_TD30);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[29], 1.000, 0.500, NOT_TD29);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[28], 1.000, 0.500, NOT_TD28);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[27], 1.000, 0.500, NOT_TD27);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[26], 1.000, 0.500, NOT_TD26);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[25], 1.000, 0.500, NOT_TD25);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[24], 1.000, 0.500, NOT_TD24);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[23], 1.000, 0.500, NOT_TD23);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[22], 1.000, 0.500, NOT_TD22);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[21], 1.000, 0.500, NOT_TD21);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[20], 1.000, 0.500, NOT_TD20);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[19], 1.000, 0.500, NOT_TD19);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[18], 1.000, 0.500, NOT_TD18);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[17], 1.000, 0.500, NOT_TD17);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[16], 1.000, 0.500, NOT_TD16);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[15], 1.000, 0.500, NOT_TD15);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[14], 1.000, 0.500, NOT_TD14);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[13], 1.000, 0.500, NOT_TD13);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[12], 1.000, 0.500, NOT_TD12);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[11], 1.000, 0.500, NOT_TD11);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[10], 1.000, 0.500, NOT_TD10);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[9], 1.000, 0.500, NOT_TD9);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[8], 1.000, 0.500, NOT_TD8);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[7], 1.000, 0.500, NOT_TD7);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[6], 1.000, 0.500, NOT_TD6);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[5], 1.000, 0.500, NOT_TD5);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[4], 1.000, 0.500, NOT_TD4);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[3], 1.000, 0.500, NOT_TD3);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[2], 1.000, 0.500, NOT_TD2);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[1], 1.000, 0.500, NOT_TD1);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, posedge TD[0], 1.000, 0.500, NOT_TD0);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[31], 1.000, 0.500, NOT_TD31);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[30], 1.000, 0.500, NOT_TD30);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[29], 1.000, 0.500, NOT_TD29);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[28], 1.000, 0.500, NOT_TD28);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[27], 1.000, 0.500, NOT_TD27);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[26], 1.000, 0.500, NOT_TD26);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[25], 1.000, 0.500, NOT_TD25);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[24], 1.000, 0.500, NOT_TD24);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[23], 1.000, 0.500, NOT_TD23);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[22], 1.000, 0.500, NOT_TD22);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[21], 1.000, 0.500, NOT_TD21);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[20], 1.000, 0.500, NOT_TD20);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[19], 1.000, 0.500, NOT_TD19);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[18], 1.000, 0.500, NOT_TD18);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[17], 1.000, 0.500, NOT_TD17);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[16], 1.000, 0.500, NOT_TD16);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[15], 1.000, 0.500, NOT_TD15);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[14], 1.000, 0.500, NOT_TD14);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[13], 1.000, 0.500, NOT_TD13);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[12], 1.000, 0.500, NOT_TD12);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[11], 1.000, 0.500, NOT_TD11);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[10], 1.000, 0.500, NOT_TD10);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[9], 1.000, 0.500, NOT_TD9);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[8], 1.000, 0.500, NOT_TD8);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[7], 1.000, 0.500, NOT_TD7);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[6], 1.000, 0.500, NOT_TD6);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[5], 1.000, 0.500, NOT_TD5);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[4], 1.000, 0.500, NOT_TD4);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[3], 1.000, 0.500, NOT_TD3);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[2], 1.000, 0.500, NOT_TD2);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[1], 1.000, 0.500, NOT_TD1);
    $setuphold(posedge CLK &&& TENeq0andTCENeq0andTWENeq0, negedge TD[0], 1.000, 0.500, NOT_TD0);
    $setuphold(posedge CLK &&& opopTENeq1andCENeq0cporopTENeq0andTCENeq0cpcp, posedge RET1N, 1.000, 0.500, NOT_RET1N);
    $setuphold(posedge CLK &&& opopTENeq1andCENeq0cporopTENeq0andTCENeq0cpcp, negedge RET1N, 1.000, 0.500, NOT_RET1N);
    $setuphold(posedge CEN &&& TENeq1, negedge RET1N, 0.000, 0.500, NOT_RET1N);
    $setuphold(posedge TCEN &&& TENeq0, negedge RET1N, 0.000, 0.500, NOT_RET1N);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, posedge STOV, 1.000, 0.500, NOT_STOV);
    $setuphold(posedge CLK &&& opTENeq1andCENeq0cporopTENeq0andTCENeq0cp, negedge STOV, 1.000, 0.500, NOT_STOV);
  endspecify


endmodule
`endcelldefine
`endif
`timescale 1ns/1ps
module sram_sp_hde_error_injection (Q_out, Q_in, CLK, A, CEN, WEN, BEN, TQ);
   output [31:0] Q_out;
   input [31:0] Q_in;
   input CLK;
   input [10:0] A;
   input CEN;
   input WEN;
   input BEN;
   input [31:0] TQ;
   parameter LEFT_RED_COLUMN_FAULT = 2'd1;
   parameter RIGHT_RED_COLUMN_FAULT = 2'd2;
   parameter NO_RED_FAULT = 2'd0;
   reg [31:0] Q_out;
   reg entry_found;
   reg list_complete;
   reg [20:0] fault_table [223:0];
   reg [20:0] fault_entry;
initial
begin
   `ifdef DUT
      `define pre_pend_path TB.DUT_inst.CHIP
   `else
       `define pre_pend_path TB.CHIP
   `endif
   `ifdef ARM_NONREPAIRABLE_FAULT
      `pre_pend_path.SMARCHCHKBVCD_LVISION_MBISTPG_ASSEMBLY_UNDER_TEST_INST.MEM0_MEM_INST.u1.add_fault(11'd163,5'd6,2'd1,2'd0);
   `endif
end
   task add_fault;
   //This task injects fault in memory
   //In order to inject fault in redundant column for Bit 0 to 15, column address
   //should have value in range of 4 to 7
   //In order to inject fault in redundant column for Bit 16 to 31, column address
   //should have value in range of 0 to 3
      input [10:0] address;
      input [4:0] bitPlace;
      input [1:0] fault_type;
      input [1:0] red_fault;
 
      integer i;
      reg done;
   begin
      done = 1'b0;
      i = 0;
      while ((!done) && i < 223)
      begin
         fault_entry = fault_table[i];
         if (fault_entry[0] === 1'b0 || fault_entry[0] === 1'bx)
         begin
            fault_entry[0] = 1'b1;
            fault_entry[2:1] = red_fault;
            fault_entry[4:3] = fault_type;
            fault_entry[9:5] = bitPlace;
            fault_entry[20:10] = address;
            fault_table[i] = fault_entry;
            done = 1'b1;
         end
         i = i+1;
      end
   end
   endtask
//This task removes all fault entries injected by user
task remove_all_faults;
   integer i;
begin
   for (i = 0; i < 224; i=i+1)
   begin
      fault_entry = fault_table[i];
      fault_entry[0] = 1'b0;
      fault_table[i] = fault_entry;
   end
end
endtask
task bit_error;
// This task is used to inject error in memory and should be called
// only from current module.
//
// This task injects error depending upon fault type to particular bit
// of the output
   inout [31:0] q_int;
   input [1:0] fault_type;
   input [4:0] bitLoc;
begin
   if (fault_type === 2'd0)
      q_int[bitLoc] = 1'b0;
   else if (fault_type === 2'd1)
      q_int[bitLoc] = 1'b1;
   else
      q_int[bitLoc] = ~q_int[bitLoc];
end
endtask
task error_injection_on_output;
// This function goes through error injection table for every
// read cycle and corrupts Q output if fault for the particular
// address is present in fault table
//
// If fault is redundant column is detected, this task corrupts
// Q output in read cycle
//
// If fault is repaired using repair bus, this task does not
// courrpt Q output in read cycle
//
   output [31:0] Q_output;
   reg list_complete;
   integer i;
   reg [7:0] row_address;
   reg [2:0] column_address;
   reg [4:0] bitPlace;
   reg [1:0] fault_type;
   reg [1:0] red_fault;
   reg valid;
begin
   entry_found = 1'b0;
   list_complete = 1'b0;
   i = 0;
   Q_output = Q_in;
   while(!list_complete)
   begin
      fault_entry = fault_table[i];
      {row_address, column_address, bitPlace, fault_type, red_fault, valid} = fault_entry;
      i = i + 1;
      if (valid == 1'b1)
      begin
         if (red_fault === NO_RED_FAULT)
         begin
            if (row_address == A[10:3] && column_address == A[2:0])
            begin
               if (bitPlace < 16)
                  bit_error(Q_output,fault_type, bitPlace);
               else if (bitPlace >= 16 )
                  bit_error(Q_output,fault_type, bitPlace);
            end
         end
      end
      else
         list_complete = 1'b1;
      end
   end
   endtask
   always @ (Q_in or CLK or A or CEN or WEN or BEN or TQ)
   begin
   if (CEN === 1'b0 && &WEN === 1'b1 && BEN === 1'b1)
      error_injection_on_output(Q_out);
   else if (BEN === 1'b0)
      Q_out = TQ;
   else
      Q_out = Q_in;
   end
endmodule
