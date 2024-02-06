/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Wed Dec 20 01:09:01 2023
/////////////////////////////////////////////////////////////


module Shift_and_Add ( clk, rst_n, in_valid, ADC_RESULT, WEIGHT_BIT_POSITION, 
        ONES_COUNTER, INPUT_BIT_POSITION, out_valid, Shift_and_Add );
  input [5:0] ADC_RESULT;
  input [7:0] WEIGHT_BIT_POSITION;
  input [4:0] ONES_COUNTER;
  input [2:0] INPUT_BIT_POSITION;
  output [20:0] Shift_and_Add;
  input clk, rst_n, in_valid;
  output out_valid;
  wire   N15, genblk1_0__U0_N31, genblk1_0__U0_N30, genblk1_0__U0_N29,
         genblk1_0__U0_N28, genblk1_0__U0_N27, genblk1_0__U0_N26,
         genblk1_0__U0_N25, genblk1_0__U0_N24, genblk1_0__U0_N23,
         genblk1_0__U0_N22, genblk1_0__U0_N21, genblk1_0__U0_N20,
         genblk1_0__U0_N19, genblk1_0__U0_N18, genblk1_0__U0_N17,
         genblk1_0__U0_N16, genblk1_0__U0_N15, genblk1_0__U0_N14,
         genblk1_0__U0_N13, genblk1_0__U0_N12, genblk1_0__U0_N11,
         genblk1_0__U0_N10, genblk1_0__U0_N9, genblk1_0__U0_N8,
         genblk1_0__U0_N7, genblk1_0__U0_N6, genblk1_0__U0_N5,
         genblk1_0__U0_N4, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         intadd_0_A_8_, intadd_0_A_7_, intadd_0_A_6_, intadd_0_A_5_,
         intadd_0_A_4_, intadd_0_A_3_, intadd_0_A_2_, intadd_0_A_1_,
         intadd_0_A_0_, intadd_0_B_5_, intadd_0_B_4_, intadd_0_B_3_,
         intadd_0_B_2_, intadd_0_B_1_, intadd_0_B_0_, intadd_0_CI, intadd_0_n9,
         intadd_0_n8, intadd_0_n7, intadd_0_n6, intadd_0_n5, intadd_0_n4,
         intadd_0_n3, intadd_0_n2, intadd_0_n1, intadd_1_B_3_, intadd_1_B_2_,
         intadd_1_B_1_, intadd_1_B_0_, intadd_1_CI, intadd_1_n4, intadd_1_n3,
         intadd_1_n2, intadd_1_n1, intadd_2_A_2_, intadd_2_A_1_, intadd_2_A_0_,
         intadd_2_B_2_, intadd_2_B_1_, intadd_2_B_0_, intadd_2_CI,
         intadd_2_SUM_1_, intadd_2_SUM_0_, intadd_2_n3, intadd_2_n2,
         intadd_2_n1, intadd_3_A_1_, intadd_3_A_0_, intadd_3_B_2_,
         intadd_3_B_1_, intadd_3_B_0_, intadd_3_CI, intadd_3_SUM_1_,
         intadd_3_SUM_0_, intadd_3_n3, intadd_3_n2, intadd_3_n1, intadd_4_A_1_,
         intadd_4_A_0_, intadd_4_B_1_, intadd_4_B_0_, intadd_4_CI,
         intadd_4_SUM_1_, intadd_4_SUM_0_, intadd_4_n3, intadd_4_n2,
         intadd_4_n1, intadd_5_A_2_, intadd_5_A_1_, intadd_5_A_0_,
         intadd_5_B_2_, intadd_5_B_1_, intadd_5_B_0_, intadd_5_CI, intadd_5_n3,
         intadd_5_n2, intadd_5_n1, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211;
  wire   [1:0] cur_state;
  wire   [1:0] next_state;
  wire   [5:0] adc_result;
  wire   [7:0] weight_bit_position;
  wire   [4:0] ones_counter;
  wire   [2:0] input_bit_position;
  wire   [20:0] genblk1_0__U0_tmp_input_shift;
  wire   [12:0] genblk1_0__U0_weight_subtract;
  wire   [11:7] genblk1_0__U0_multiple;
  wire   [13:7] genblk1_0__U0_weight_shift;
  wire   [2:0] genblk1_0__U0_input_bit_position_2t;
  wire   [2:0] genblk1_0__U0_input_bit_position_1t;

  ADDF_X1M_A9TR intadd_0_U10 ( .A(intadd_0_B_0_), .B(intadd_0_A_0_), .CI(
        intadd_0_CI), .CO(intadd_0_n9), .S(genblk1_0__U0_N6) );
  ADDF_X1M_A9TR intadd_0_U9 ( .A(intadd_0_B_1_), .B(intadd_0_A_1_), .CI(
        intadd_0_n9), .CO(intadd_0_n8), .S(genblk1_0__U0_N7) );
  ADDF_X1M_A9TR intadd_0_U8 ( .A(intadd_0_B_2_), .B(intadd_0_A_2_), .CI(
        intadd_0_n8), .CO(intadd_0_n7), .S(genblk1_0__U0_N8) );
  ADDF_X1M_A9TR intadd_0_U7 ( .A(intadd_0_B_3_), .B(intadd_0_A_3_), .CI(
        intadd_0_n7), .CO(intadd_0_n6), .S(genblk1_0__U0_N9) );
  ADDF_X1M_A9TR intadd_0_U6 ( .A(intadd_0_B_4_), .B(intadd_0_A_4_), .CI(
        intadd_0_n6), .CO(intadd_0_n5), .S(genblk1_0__U0_N10) );
  ADDF_X1M_A9TR intadd_0_U5 ( .A(intadd_0_B_5_), .B(intadd_0_A_5_), .CI(
        intadd_0_n5), .CO(intadd_0_n4), .S(genblk1_0__U0_N11) );
  ADDF_X1M_A9TR intadd_0_U4 ( .A(intadd_4_n1), .B(intadd_0_A_6_), .CI(
        intadd_0_n4), .CO(intadd_0_n3), .S(genblk1_0__U0_N12) );
  ADDF_X1M_A9TR intadd_0_U3 ( .A(intadd_3_n1), .B(intadd_0_A_7_), .CI(
        intadd_0_n3), .CO(intadd_0_n2), .S(genblk1_0__U0_N13) );
  ADDF_X1M_A9TR intadd_0_U2 ( .A(intadd_2_n1), .B(intadd_0_A_8_), .CI(
        intadd_0_n2), .CO(intadd_0_n1), .S(genblk1_0__U0_N14) );
  ADDF_X1M_A9TR intadd_1_U5 ( .A(intadd_1_B_0_), .B(
        genblk1_0__U0_weight_shift[8]), .CI(intadd_1_CI), .CO(intadd_1_n4), 
        .S(genblk1_0__U0_N26) );
  ADDF_X1M_A9TR intadd_1_U4 ( .A(intadd_1_B_1_), .B(
        genblk1_0__U0_weight_shift[9]), .CI(intadd_1_n4), .CO(intadd_1_n3), 
        .S(genblk1_0__U0_N27) );
  ADDF_X1M_A9TR intadd_1_U3 ( .A(intadd_1_B_2_), .B(
        genblk1_0__U0_weight_shift[10]), .CI(intadd_1_n3), .CO(intadd_1_n2), 
        .S(genblk1_0__U0_N28) );
  ADDF_X1M_A9TR intadd_1_U2 ( .A(intadd_1_B_3_), .B(
        genblk1_0__U0_weight_shift[11]), .CI(intadd_1_n2), .CO(intadd_1_n1), 
        .S(genblk1_0__U0_N29) );
  ADDF_X1M_A9TR intadd_2_U4 ( .A(intadd_2_B_0_), .B(intadd_2_A_0_), .CI(
        intadd_2_CI), .CO(intadd_2_n3), .S(intadd_2_SUM_0_) );
  ADDF_X1M_A9TR intadd_2_U3 ( .A(intadd_2_B_1_), .B(intadd_2_A_1_), .CI(
        intadd_2_n3), .CO(intadd_2_n2), .S(intadd_2_SUM_1_) );
  ADDF_X1M_A9TR intadd_2_U2 ( .A(intadd_2_B_2_), .B(intadd_2_A_2_), .CI(
        intadd_2_n2), .CO(intadd_2_n1), .S(intadd_0_A_7_) );
  ADDF_X1M_A9TR intadd_3_U4 ( .A(intadd_3_B_0_), .B(intadd_3_A_0_), .CI(
        intadd_3_CI), .CO(intadd_3_n3), .S(intadd_3_SUM_0_) );
  ADDF_X1M_A9TR intadd_3_U3 ( .A(intadd_3_B_1_), .B(intadd_3_A_1_), .CI(
        intadd_3_n3), .CO(intadd_3_n2), .S(intadd_3_SUM_1_) );
  ADDF_X1M_A9TR intadd_3_U2 ( .A(intadd_3_B_2_), .B(intadd_2_SUM_1_), .CI(
        intadd_3_n2), .CO(intadd_3_n1), .S(intadd_0_A_6_) );
  ADDF_X1M_A9TR intadd_4_U4 ( .A(intadd_4_B_0_), .B(intadd_4_A_0_), .CI(
        intadd_4_CI), .CO(intadd_4_n3), .S(intadd_4_SUM_0_) );
  ADDF_X1M_A9TR intadd_4_U3 ( .A(intadd_4_B_1_), .B(intadd_4_A_1_), .CI(
        intadd_4_n3), .CO(intadd_4_n2), .S(intadd_4_SUM_1_) );
  ADDF_X1M_A9TR intadd_4_U2 ( .A(intadd_2_SUM_0_), .B(intadd_3_SUM_1_), .CI(
        intadd_4_n2), .CO(intadd_4_n1), .S(intadd_0_A_5_) );
  ADDF_X1M_A9TR intadd_5_U4 ( .A(intadd_5_B_0_), .B(intadd_5_A_0_), .CI(
        intadd_5_CI), .CO(intadd_5_n3), .S(intadd_3_B_2_) );
  ADDF_X1M_A9TR intadd_5_U3 ( .A(intadd_5_B_1_), .B(intadd_5_A_1_), .CI(
        intadd_5_n3), .CO(intadd_5_n2), .S(intadd_2_A_2_) );
  ADDF_X1M_A9TR intadd_5_U2 ( .A(intadd_5_B_2_), .B(intadd_5_A_2_), .CI(
        intadd_5_n2), .CO(intadd_5_n1), .S(intadd_0_A_8_) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_12_ ( .D(
        genblk1_0__U0_N30), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_weight_subtract[12]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_13_ ( .D(genblk1_0__U0_N17), 
        .CK(clk), .R(n208), .Q(genblk1_0__U0_weight_shift[13]) );
  DFFRPQ_X0P5M_A9TR ones_counter_reg_0_ ( .D(n76), .CK(clk), .R(n209), .Q(
        ones_counter[0]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__2_ ( .D(n61), .CK(clk), .R(n208), .Q(weight_bit_position[2]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_19_ ( .D(
        genblk1_0__U0_tmp_input_shift[19]), .CK(clk), .R(n210), .Q(
        Shift_and_Add[19]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_0_ ( .D(
        genblk1_0__U0_tmp_input_shift[0]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[0]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_bit_position_2t_reg_2_ ( .D(
        genblk1_0__U0_input_bit_position_1t[2]), .CK(clk), .R(n81), .Q(
        genblk1_0__U0_input_bit_position_2t[2]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_input_bit_position_1t_reg_2_ ( .D(
        input_bit_position[2]), .CK(clk), .R(n208), .Q(
        genblk1_0__U0_input_bit_position_1t[2]) );
  DFFRPQ_X0P5M_A9TR cur_state_reg_0_ ( .D(next_state[0]), .CK(clk), .R(n211), 
        .Q(cur_state[0]) );
  DFFRPQ_X0P5M_A9TR cur_state_reg_1_ ( .D(next_state[1]), .CK(clk), .R(n211), 
        .Q(cur_state[1]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_0_ ( .D(
        genblk1_0__U0_N18), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[0]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_1_ ( .D(
        genblk1_0__U0_N19), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[1]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_2_ ( .D(
        genblk1_0__U0_N20), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[2]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_3_ ( .D(
        genblk1_0__U0_N21), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[3]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_4_ ( .D(
        genblk1_0__U0_N22), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[4]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_5_ ( .D(
        genblk1_0__U0_N23), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[5]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_6_ ( .D(
        genblk1_0__U0_N24), .CK(clk), .R(n211), .Q(
        genblk1_0__U0_weight_subtract[6]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_7_ ( .D(
        genblk1_0__U0_N25), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_weight_subtract[7]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_8_ ( .D(
        genblk1_0__U0_N26), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_weight_subtract[8]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_9_ ( .D(
        genblk1_0__U0_N27), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_weight_subtract[9]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_10_ ( .D(
        genblk1_0__U0_N28), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_weight_subtract[10]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_11_ ( .D(
        genblk1_0__U0_N29), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_weight_subtract[11]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_subtract_reg_13_ ( .D(
        genblk1_0__U0_N31), .CK(clk), .R(n210), .Q(
        genblk1_0__U0_tmp_input_shift[20]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_0_ ( .D(genblk1_0__U0_N4), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N18) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_1_ ( .D(genblk1_0__U0_N5), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N19) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_2_ ( .D(genblk1_0__U0_N6), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N20) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_3_ ( .D(genblk1_0__U0_N7), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N21) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_4_ ( .D(genblk1_0__U0_N8), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N22) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_5_ ( .D(genblk1_0__U0_N9), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N23) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_6_ ( .D(genblk1_0__U0_N10), 
        .CK(clk), .R(n210), .Q(genblk1_0__U0_N24) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_7_ ( .D(genblk1_0__U0_N11), 
        .CK(clk), .R(n208), .Q(genblk1_0__U0_weight_shift[7]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_8_ ( .D(genblk1_0__U0_N12), 
        .CK(clk), .R(n209), .Q(genblk1_0__U0_weight_shift[8]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_9_ ( .D(genblk1_0__U0_N13), 
        .CK(clk), .R(n81), .Q(genblk1_0__U0_weight_shift[9]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_10_ ( .D(genblk1_0__U0_N14), 
        .CK(clk), .R(n208), .Q(genblk1_0__U0_weight_shift[10]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_11_ ( .D(genblk1_0__U0_N15), 
        .CK(clk), .R(n209), .Q(genblk1_0__U0_weight_shift[11]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_weight_shift_reg_12_ ( .D(genblk1_0__U0_N16), 
        .CK(clk), .R(n81), .Q(genblk1_0__U0_weight_shift[12]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_input_bit_position_1t_reg_0_ ( .D(
        input_bit_position[0]), .CK(clk), .R(n209), .Q(
        genblk1_0__U0_input_bit_position_1t[0]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_input_bit_position_1t_reg_1_ ( .D(
        input_bit_position[1]), .CK(clk), .R(n81), .Q(
        genblk1_0__U0_input_bit_position_1t[1]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_ones_counter_1t_reg_0_ ( .D(ones_counter[0]), 
        .CK(clk), .R(n209), .Q(genblk1_0__U0_multiple[7]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_ones_counter_1t_reg_1_ ( .D(ones_counter[1]), 
        .CK(clk), .R(n81), .Q(genblk1_0__U0_multiple[8]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_ones_counter_1t_reg_2_ ( .D(ones_counter[2]), 
        .CK(clk), .R(n208), .Q(genblk1_0__U0_multiple[9]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_ones_counter_1t_reg_3_ ( .D(ones_counter[3]), 
        .CK(clk), .R(n209), .Q(genblk1_0__U0_multiple[10]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_ones_counter_1t_reg_4_ ( .D(ones_counter[4]), 
        .CK(clk), .R(n81), .Q(genblk1_0__U0_multiple[11]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_input_bit_position_2t_reg_0_ ( .D(
        genblk1_0__U0_input_bit_position_1t[0]), .CK(clk), .R(n81), .Q(
        genblk1_0__U0_input_bit_position_2t[0]) );
  DFFRPQ_X0P5M_A9TR genblk1_0__U0_input_bit_position_2t_reg_1_ ( .D(
        genblk1_0__U0_input_bit_position_1t[1]), .CK(clk), .R(n81), .Q(
        genblk1_0__U0_input_bit_position_2t[1]) );
  DFFRPQ_X0P5M_A9TR ones_counter_reg_4_ ( .D(n80), .CK(clk), .R(n209), .Q(
        ones_counter[4]) );
  DFFRPQ_X0P5M_A9TR ones_counter_reg_3_ ( .D(n79), .CK(clk), .R(n209), .Q(
        ones_counter[3]) );
  DFFRPQ_X0P5M_A9TR ones_counter_reg_2_ ( .D(n78), .CK(clk), .R(n209), .Q(
        ones_counter[2]) );
  DFFRPQ_X0P5M_A9TR ones_counter_reg_1_ ( .D(n77), .CK(clk), .R(n209), .Q(
        ones_counter[1]) );
  DFFRPQ_X0P5M_A9TR adc_result_reg_5_ ( .D(n75), .CK(clk), .R(n209), .Q(
        adc_result[5]) );
  DFFRPQ_X0P5M_A9TR adc_result_reg_4_ ( .D(n74), .CK(clk), .R(n209), .Q(
        adc_result[4]) );
  DFFRPQ_X0P5M_A9TR adc_result_reg_3_ ( .D(n73), .CK(clk), .R(n208), .Q(
        adc_result[3]) );
  DFFRPQ_X0P5M_A9TR adc_result_reg_2_ ( .D(n72), .CK(clk), .R(n208), .Q(
        adc_result[2]) );
  DFFRPQ_X0P5M_A9TR adc_result_reg_1_ ( .D(n71), .CK(clk), .R(n208), .Q(
        adc_result[1]) );
  DFFRPQ_X0P5M_A9TR adc_result_reg_0_ ( .D(n70), .CK(clk), .R(n208), .Q(
        adc_result[0]) );
  DFFRPQ_X0P5M_A9TR input_bit_position_reg_2_ ( .D(n69), .CK(clk), .R(n208), 
        .Q(input_bit_position[2]) );
  DFFRPQ_X0P5M_A9TR input_bit_position_reg_1_ ( .D(n68), .CK(clk), .R(n208), 
        .Q(input_bit_position[1]) );
  DFFRPQ_X0P5M_A9TR input_bit_position_reg_0_ ( .D(n67), .CK(clk), .R(n208), 
        .Q(input_bit_position[0]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__7_ ( .D(n66), .CK(clk), .R(n208), .Q(weight_bit_position[7]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__6_ ( .D(n65), .CK(clk), .R(n208), .Q(weight_bit_position[6]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__5_ ( .D(n64), .CK(clk), .R(n208), .Q(weight_bit_position[5]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__4_ ( .D(n63), .CK(clk), .R(n208), .Q(weight_bit_position[4]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__3_ ( .D(n62), .CK(clk), .R(n208), .Q(weight_bit_position[3]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__1_ ( .D(n60), .CK(clk), .R(n208), .Q(weight_bit_position[1]) );
  DFFRPQ_X0P5M_A9TR weight_bit_position_reg_0__0_ ( .D(n59), .CK(clk), .R(n208), .Q(weight_bit_position[0]) );
  DFFRPQ_X1M_A9TR out_valid_reg ( .D(N15), .CK(clk), .R(n211), .Q(out_valid)
         );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_20_ ( .D(
        genblk1_0__U0_tmp_input_shift[20]), .CK(clk), .R(n210), .Q(
        Shift_and_Add[20]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_3_ ( .D(
        genblk1_0__U0_tmp_input_shift[3]), .CK(clk), .R(n208), .Q(
        Shift_and_Add[3]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_2_ ( .D(
        genblk1_0__U0_tmp_input_shift[2]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[2]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_1_ ( .D(
        genblk1_0__U0_tmp_input_shift[1]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[1]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_9_ ( .D(
        genblk1_0__U0_tmp_input_shift[9]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[9]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_8_ ( .D(
        genblk1_0__U0_tmp_input_shift[8]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[8]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_7_ ( .D(
        genblk1_0__U0_tmp_input_shift[7]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[7]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_6_ ( .D(
        genblk1_0__U0_tmp_input_shift[6]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[6]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_5_ ( .D(
        genblk1_0__U0_tmp_input_shift[5]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[5]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_4_ ( .D(
        genblk1_0__U0_tmp_input_shift[4]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[4]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_18_ ( .D(
        genblk1_0__U0_tmp_input_shift[18]), .CK(clk), .R(n211), .Q(
        Shift_and_Add[18]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_17_ ( .D(
        genblk1_0__U0_tmp_input_shift[17]), .CK(clk), .R(n210), .Q(
        Shift_and_Add[17]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_16_ ( .D(
        genblk1_0__U0_tmp_input_shift[16]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[16]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_15_ ( .D(
        genblk1_0__U0_tmp_input_shift[15]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[15]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_14_ ( .D(
        genblk1_0__U0_tmp_input_shift[14]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[14]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_13_ ( .D(
        genblk1_0__U0_tmp_input_shift[13]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[13]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_12_ ( .D(
        genblk1_0__U0_tmp_input_shift[12]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[12]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_11_ ( .D(
        genblk1_0__U0_tmp_input_shift[11]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[11]) );
  DFFRPQ_X1M_A9TR genblk1_0__U0_input_shift_reg_10_ ( .D(
        genblk1_0__U0_tmp_input_shift[10]), .CK(clk), .R(n209), .Q(
        Shift_and_Add[10]) );
  INV_X0P5B_A9TR U110 ( .A(in_valid), .Y(n169) );
  INV_X0P5B_A9TR U111 ( .A(adc_result[3]), .Y(n162) );
  INV_X0P5B_A9TR U112 ( .A(rst_n), .Y(n81) );
  BUF_X1M_A9TR U113 ( .A(n81), .Y(n208) );
  BUF_X0P7M_A9TR U114 ( .A(n81), .Y(n210) );
  BUF_X1M_A9TR U115 ( .A(n81), .Y(n211) );
  BUF_X1M_A9TR U116 ( .A(n81), .Y(n209) );
  INV_X0P5B_A9TR U117 ( .A(adc_result[1]), .Y(n191) );
  INV_X0P5B_A9TR U118 ( .A(weight_bit_position[0]), .Y(n204) );
  NAND2_X0P5A_A9TR U119 ( .A(weight_bit_position[1]), .B(adc_result[0]), .Y(
        n82) );
  NOR3_X0P5A_A9TR U120 ( .A(n191), .B(n204), .C(n82), .Y(intadd_0_CI) );
  OA21A1OI2_X0P5M_A9TR U121 ( .A0(n204), .A1(n191), .B0(n82), .C0(intadd_0_CI), 
        .Y(genblk1_0__U0_N5) );
  NOR2_X0P5A_A9TR U122 ( .A(intadd_1_n1), .B(genblk1_0__U0_weight_shift[12]), 
        .Y(n93) );
  XOR2_X0P5M_A9TR U123 ( .A(n93), .B(genblk1_0__U0_weight_shift[13]), .Y(
        genblk1_0__U0_N31) );
  INV_X0P5B_A9TR U124 ( .A(genblk1_0__U0_multiple[8]), .Y(intadd_1_B_0_) );
  INV_X0P5B_A9TR U125 ( .A(genblk1_0__U0_multiple[9]), .Y(intadd_1_B_1_) );
  INV_X0P5B_A9TR U126 ( .A(genblk1_0__U0_multiple[10]), .Y(intadd_1_B_2_) );
  INV_X0P5B_A9TR U127 ( .A(genblk1_0__U0_multiple[11]), .Y(intadd_1_B_3_) );
  INV_X0P5B_A9TR U128 ( .A(genblk1_0__U0_input_bit_position_2t[0]), .Y(n97) );
  INV_X0P5B_A9TR U129 ( .A(genblk1_0__U0_input_bit_position_2t[1]), .Y(n105)
         );
  AOI221_X0P5M_A9TR U130 ( .A0(genblk1_0__U0_weight_subtract[2]), .A1(
        genblk1_0__U0_input_bit_position_2t[0]), .B0(
        genblk1_0__U0_weight_subtract[3]), .B1(n97), .C0(n105), .Y(n124) );
  NOR2_X0P5A_A9TR U131 ( .A(n97), .B(genblk1_0__U0_input_bit_position_2t[1]), 
        .Y(n111) );
  NAND2_X0P5A_A9TR U132 ( .A(n105), .B(n97), .Y(n134) );
  INV_X0P5B_A9TR U133 ( .A(n134), .Y(n121) );
  AOI22_X0P5M_A9TR U134 ( .A0(n111), .A1(genblk1_0__U0_weight_subtract[0]), 
        .B0(n121), .B1(genblk1_0__U0_weight_subtract[1]), .Y(n94) );
  AOI22_X0P5M_A9TR U135 ( .A0(genblk1_0__U0_input_bit_position_2t[0]), .A1(
        genblk1_0__U0_weight_subtract[4]), .B0(
        genblk1_0__U0_weight_subtract[5]), .B1(n97), .Y(n104) );
  NAND2_X0P5A_A9TR U136 ( .A(n104), .B(n105), .Y(n123) );
  NOR2_X0P5A_A9TR U137 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .B(n123), 
        .Y(n83) );
  OA21A1OI2_X0P5M_A9TR U138 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), 
        .A1(n124), .B0(n94), .C0(n83), .Y(genblk1_0__U0_tmp_input_shift[5]) );
  INV_X0P5B_A9TR U139 ( .A(weight_bit_position[2]), .Y(n195) );
  INV_X0P5B_A9TR U140 ( .A(adc_result[0]), .Y(n193) );
  NAND2_X0P5A_A9TR U141 ( .A(weight_bit_position[1]), .B(adc_result[1]), .Y(
        n84) );
  NAND4_X0P5M_A9TR U142 ( .A(weight_bit_position[1]), .B(adc_result[1]), .C(
        weight_bit_position[2]), .D(adc_result[0]), .Y(n158) );
  INV_X0P5B_A9TR U143 ( .A(n158), .Y(n87) );
  OA21A1OI2_X0P5M_A9TR U144 ( .A0(n195), .A1(n193), .B0(n84), .C0(n87), .Y(
        intadd_0_A_0_) );
  INV_X0P5B_A9TR U145 ( .A(weight_bit_position[3]), .Y(n190) );
  NOR2_X0P5A_A9TR U146 ( .A(n193), .B(n190), .Y(n85) );
  NAND4_X0P5M_A9TR U147 ( .A(adc_result[1]), .B(weight_bit_position[2]), .C(
        adc_result[0]), .D(weight_bit_position[3]), .Y(n157) );
  AO21A1AI2_X0P5M_A9TR U148 ( .A0(weight_bit_position[2]), .A1(adc_result[1]), 
        .B0(n85), .C0(n157), .Y(n86) );
  XNOR2_X0P5M_A9TR U149 ( .A(n87), .B(n86), .Y(intadd_0_A_1_) );
  NAND2_X0P5A_A9TR U150 ( .A(weight_bit_position[1]), .B(adc_result[2]), .Y(
        n88) );
  NOR3_X0P5A_A9TR U151 ( .A(n204), .B(n162), .C(n88), .Y(n206) );
  OA21A1OI2_X0P5M_A9TR U152 ( .A0(n162), .A1(n204), .B0(n88), .C0(n206), .Y(
        intadd_0_B_1_) );
  INV_X0P5B_A9TR U153 ( .A(adc_result[5]), .Y(n186) );
  NAND2_X0P5A_A9TR U154 ( .A(weight_bit_position[1]), .B(adc_result[4]), .Y(
        n185) );
  NOR3_X0P5A_A9TR U155 ( .A(n186), .B(n204), .C(n185), .Y(intadd_4_B_1_) );
  NAND2_X0P5A_A9TR U156 ( .A(weight_bit_position[4]), .B(adc_result[4]), .Y(
        n89) );
  NOR3_X0P5A_A9TR U157 ( .A(n186), .B(n190), .C(n89), .Y(intadd_5_B_1_) );
  OA21A1OI2_X0P5M_A9TR U158 ( .A0(n190), .A1(n186), .B0(n89), .C0(
        intadd_5_B_1_), .Y(intadd_2_A_1_) );
  INV_X0P5B_A9TR U159 ( .A(genblk1_0__U0_weight_shift[7]), .Y(n90) );
  NAND2_X0P5A_A9TR U160 ( .A(n90), .B(genblk1_0__U0_multiple[7]), .Y(
        intadd_1_CI) );
  OAI21_X0P5M_A9TR U161 ( .A0(genblk1_0__U0_multiple[7]), .A1(n90), .B0(
        intadd_1_CI), .Y(genblk1_0__U0_N25) );
  INV_X0P5B_A9TR U162 ( .A(cur_state[0]), .Y(n91) );
  INV_X0P5B_A9TR U163 ( .A(cur_state[1]), .Y(n168) );
  NOR2_X0P5A_A9TR U164 ( .A(n91), .B(n168), .Y(N15) );
  AOI21_X0P5M_A9TR U165 ( .A0(n91), .A1(n168), .B0(N15), .Y(next_state[1]) );
  NOR2_X0P5A_A9TR U166 ( .A(n193), .B(n204), .Y(genblk1_0__U0_N4) );
  OA22_X0P5M_A9TR U167 ( .A0(n105), .A1(genblk1_0__U0_weight_subtract[0]), 
        .B0(n134), .B1(genblk1_0__U0_weight_subtract[2]), .Y(n92) );
  AO21A1AI2_X0P5M_A9TR U168 ( .A0(genblk1_0__U0_weight_subtract[1]), .A1(n105), 
        .B0(n97), .C0(n92), .Y(n130) );
  NOR2_X0P5A_A9TR U169 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .B(n130), 
        .Y(genblk1_0__U0_tmp_input_shift[2]) );
  AO21_X0P7M_A9TR U170 ( .A0(genblk1_0__U0_weight_shift[12]), .A1(intadd_1_n1), 
        .B0(n93), .Y(genblk1_0__U0_N30) );
  NAND2_X0P5A_A9TR U171 ( .A(n121), .B(genblk1_0__U0_weight_subtract[0]), .Y(
        n118) );
  NOR2_X0P5A_A9TR U172 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .B(n118), 
        .Y(genblk1_0__U0_tmp_input_shift[0]) );
  NOR2_X0P5A_A9TR U173 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .B(n94), 
        .Y(genblk1_0__U0_tmp_input_shift[1]) );
  INV_X0P5B_A9TR U174 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .Y(n144)
         );
  INV_X0P5B_A9TR U175 ( .A(genblk1_0__U0_weight_subtract[10]), .Y(n108) );
  INV_X0P5B_A9TR U176 ( .A(genblk1_0__U0_weight_subtract[11]), .Y(n99) );
  AOI22_X0P5M_A9TR U177 ( .A0(genblk1_0__U0_input_bit_position_2t[0]), .A1(
        n108), .B0(n99), .B1(n97), .Y(n96) );
  OA22_X0P5M_A9TR U178 ( .A0(n97), .A1(genblk1_0__U0_weight_subtract[12]), 
        .B0(genblk1_0__U0_tmp_input_shift[20]), .B1(
        genblk1_0__U0_input_bit_position_2t[0]), .Y(n95) );
  AOI22_X0P5M_A9TR U179 ( .A0(genblk1_0__U0_input_bit_position_2t[1]), .A1(n96), .B0(n95), .B1(n105), .Y(n142) );
  NAND2_X0P5A_A9TR U180 ( .A(genblk1_0__U0_tmp_input_shift[20]), .B(n144), .Y(
        n101) );
  OAI21_X0P5M_A9TR U181 ( .A0(n144), .A1(n142), .B0(n101), .Y(
        genblk1_0__U0_tmp_input_shift[17]) );
  NOR2_X0P5A_A9TR U182 ( .A(n105), .B(n97), .Y(n128) );
  INV_X0P5B_A9TR U183 ( .A(n128), .Y(n131) );
  AOI22_X0P5M_A9TR U184 ( .A0(n128), .A1(genblk1_0__U0_weight_subtract[12]), 
        .B0(genblk1_0__U0_tmp_input_shift[20]), .B1(n131), .Y(n114) );
  OAI21_X0P5M_A9TR U185 ( .A0(n114), .A1(n144), .B0(n101), .Y(
        genblk1_0__U0_tmp_input_shift[19]) );
  NAND2_X0P5A_A9TR U186 ( .A(genblk1_0__U0_input_bit_position_2t[1]), .B(n97), 
        .Y(n136) );
  OAI222_X0P5M_A9TR U187 ( .A0(n131), .A1(genblk1_0__U0_weight_subtract[11]), 
        .B0(n136), .B1(genblk1_0__U0_weight_subtract[12]), .C0(
        genblk1_0__U0_tmp_input_shift[20]), .C1(
        genblk1_0__U0_input_bit_position_2t[1]), .Y(n113) );
  OAI21_X0P5M_A9TR U188 ( .A0(n144), .A1(n113), .B0(n101), .Y(
        genblk1_0__U0_tmp_input_shift[18]) );
  OAI22_X0P5M_A9TR U189 ( .A0(genblk1_0__U0_weight_subtract[9]), .A1(n131), 
        .B0(genblk1_0__U0_weight_subtract[12]), .B1(n134), .Y(n98) );
  AOI21_X0P5M_A9TR U190 ( .A0(n111), .A1(n99), .B0(n98), .Y(n100) );
  OAI21_X0P5M_A9TR U191 ( .A0(genblk1_0__U0_weight_subtract[10]), .A1(n136), 
        .B0(n100), .Y(n137) );
  OAI21_X0P5M_A9TR U192 ( .A0(n144), .A1(n137), .B0(n101), .Y(
        genblk1_0__U0_tmp_input_shift[16]) );
  INV_X0P5B_A9TR U193 ( .A(genblk1_0__U0_weight_subtract[3]), .Y(n127) );
  INV_X0P5B_A9TR U194 ( .A(n111), .Y(n132) );
  OAI22_X0P5M_A9TR U195 ( .A0(genblk1_0__U0_weight_subtract[2]), .A1(n132), 
        .B0(genblk1_0__U0_weight_subtract[0]), .B1(n131), .Y(n102) );
  AOI21_X0P5M_A9TR U196 ( .A0(n121), .A1(n127), .B0(n102), .Y(n103) );
  OAI21_X0P5M_A9TR U197 ( .A0(genblk1_0__U0_weight_subtract[1]), .A1(n136), 
        .B0(n103), .Y(n146) );
  NOR2_X0P5A_A9TR U198 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .B(n146), 
        .Y(genblk1_0__U0_tmp_input_shift[3]) );
  INV_X0P5B_A9TR U199 ( .A(n104), .Y(n106) );
  OAI222_X0P5M_A9TR U200 ( .A0(n106), .A1(n105), .B0(n134), .B1(
        genblk1_0__U0_weight_subtract[7]), .C0(n132), .C1(
        genblk1_0__U0_weight_subtract[6]), .Y(n145) );
  OAI22_X0P5M_A9TR U201 ( .A0(genblk1_0__U0_weight_subtract[8]), .A1(n131), 
        .B0(genblk1_0__U0_weight_subtract[11]), .B1(n134), .Y(n107) );
  AOI21_X0P5M_A9TR U202 ( .A0(n111), .A1(n108), .B0(n107), .Y(n109) );
  OAI21_X0P5M_A9TR U203 ( .A0(genblk1_0__U0_weight_subtract[9]), .A1(n136), 
        .B0(n109), .Y(n115) );
  AOI22_X0P5M_A9TR U204 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n145), .B0(n115), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[11]) );
  INV_X0P5B_A9TR U205 ( .A(genblk1_0__U0_weight_subtract[9]), .Y(n120) );
  OAI22_X0P5M_A9TR U206 ( .A0(genblk1_0__U0_weight_subtract[7]), .A1(n131), 
        .B0(genblk1_0__U0_weight_subtract[10]), .B1(n134), .Y(n110) );
  AOI21_X0P5M_A9TR U207 ( .A0(n111), .A1(n120), .B0(n110), .Y(n112) );
  OAI21_X0P5M_A9TR U208 ( .A0(genblk1_0__U0_weight_subtract[8]), .A1(n136), 
        .B0(n112), .Y(n140) );
  AOI22_X0P5M_A9TR U209 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n140), .B0(n113), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[14]) );
  AOI22_X0P5M_A9TR U210 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n115), .B0(n114), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[15]) );
  OAI22_X0P5M_A9TR U211 ( .A0(genblk1_0__U0_weight_subtract[3]), .A1(n132), 
        .B0(genblk1_0__U0_weight_subtract[1]), .B1(n131), .Y(n116) );
  OA1B2_X0P5M_A9TR U212 ( .B0(n134), .B1(genblk1_0__U0_weight_subtract[4]), 
        .A0N(n116), .Y(n117) );
  OAI21_X0P5M_A9TR U213 ( .A0(genblk1_0__U0_weight_subtract[2]), .A1(n136), 
        .B0(n117), .Y(n139) );
  AOI22_X0P5M_A9TR U214 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n118), .B0(n139), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[4]) );
  OAI22_X0P5M_A9TR U215 ( .A0(genblk1_0__U0_weight_subtract[8]), .A1(n132), 
        .B0(genblk1_0__U0_weight_subtract[6]), .B1(n131), .Y(n119) );
  AOI21_X0P5M_A9TR U216 ( .A0(n121), .A1(n120), .B0(n119), .Y(n122) );
  OAI21_X0P5M_A9TR U217 ( .A0(genblk1_0__U0_weight_subtract[7]), .A1(n136), 
        .B0(n122), .Y(n143) );
  NAND2_X0P5A_A9TR U218 ( .A(genblk1_0__U0_input_bit_position_2t[2]), .B(n123), 
        .Y(n125) );
  OAI22_X0P5M_A9TR U219 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n143), .B0(n125), .B1(n124), .Y(genblk1_0__U0_tmp_input_shift[9]) );
  OAI22_X0P5M_A9TR U220 ( .A0(genblk1_0__U0_weight_subtract[6]), .A1(n134), 
        .B0(genblk1_0__U0_weight_subtract[5]), .B1(n132), .Y(n126) );
  AOI21_X0P5M_A9TR U221 ( .A0(n128), .A1(n127), .B0(n126), .Y(n129) );
  OAI21_X0P5M_A9TR U222 ( .A0(genblk1_0__U0_weight_subtract[4]), .A1(n136), 
        .B0(n129), .Y(n141) );
  AOI22_X0P5M_A9TR U223 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n130), .B0(n141), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[6]) );
  OAI22_X0P5M_A9TR U224 ( .A0(genblk1_0__U0_weight_subtract[7]), .A1(n132), 
        .B0(genblk1_0__U0_weight_subtract[5]), .B1(n131), .Y(n133) );
  OA1B2_X0P5M_A9TR U225 ( .B0(n134), .B1(genblk1_0__U0_weight_subtract[8]), 
        .A0N(n133), .Y(n135) );
  OAI21_X0P5M_A9TR U226 ( .A0(genblk1_0__U0_weight_subtract[6]), .A1(n136), 
        .B0(n135), .Y(n138) );
  AOI22_X0P5M_A9TR U227 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n138), .B0(n137), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[12]) );
  AOI22_X0P5M_A9TR U228 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n139), .B0(n138), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[8]) );
  AOI22_X0P5M_A9TR U229 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n141), .B0(n140), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[10]) );
  AOI22_X0P5M_A9TR U230 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n143), .B0(n142), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[13]) );
  AOI22_X0P5M_A9TR U231 ( .A0(genblk1_0__U0_input_bit_position_2t[2]), .A1(
        n146), .B0(n145), .B1(n144), .Y(genblk1_0__U0_tmp_input_shift[7]) );
  INV_X0P5B_A9TR U232 ( .A(adc_result[4]), .Y(n203) );
  INV_X0P5B_A9TR U233 ( .A(weight_bit_position[6]), .Y(n181) );
  NOR2_X0P5A_A9TR U234 ( .A(n203), .B(n181), .Y(n172) );
  INV_X0P5B_A9TR U235 ( .A(weight_bit_position[7]), .Y(n176) );
  NOR2_X0P5A_A9TR U236 ( .A(n176), .B(n162), .Y(n171) );
  INV_X0P5B_A9TR U237 ( .A(weight_bit_position[5]), .Y(n180) );
  NOR2_X0P5A_A9TR U238 ( .A(n186), .B(n180), .Y(n170) );
  NOR2_X0P5A_A9TR U239 ( .A(n176), .B(n203), .Y(n148) );
  NOR2_X0P5A_A9TR U240 ( .A(n186), .B(n181), .Y(n147) );
  ADDF_X1M_A9TR U241 ( .A(n149), .B(n148), .CI(n147), .CO(n151), .S(n155) );
  OAI21_X0P5M_A9TR U242 ( .A0(intadd_5_n1), .A1(intadd_0_n1), .B0(n155), .Y(
        n152) );
  NAND2_X0P5A_A9TR U243 ( .A(weight_bit_position[7]), .B(adc_result[5]), .Y(
        n150) );
  AOI2XB1_X0P5M_A9TR U244 ( .A1N(n151), .A0(n152), .B0(n150), .Y(
        genblk1_0__U0_N17) );
  XOR2_X0P5M_A9TR U245 ( .A(n151), .B(n150), .Y(n153) );
  XOR2_X0P5M_A9TR U246 ( .A(n153), .B(n152), .Y(genblk1_0__U0_N16) );
  NOR2_X0P5A_A9TR U247 ( .A(intadd_5_n1), .B(intadd_0_n1), .Y(n154) );
  AOI21_X0P5M_A9TR U248 ( .A0(intadd_5_n1), .A1(intadd_0_n1), .B0(n154), .Y(
        n156) );
  XOR2_X0P5M_A9TR U249 ( .A(n156), .B(n155), .Y(genblk1_0__U0_N15) );
  INV_X0P5B_A9TR U250 ( .A(adc_result[2]), .Y(n194) );
  NOR2_X0P5A_A9TR U251 ( .A(n204), .B(n194), .Y(intadd_0_B_0_) );
  NAND2_X0P5A_A9TR U252 ( .A(n158), .B(n157), .Y(intadd_0_B_2_) );
  NOR2_X0P5A_A9TR U253 ( .A(n195), .B(n162), .Y(intadd_4_CI) );
  NOR2_X0P5A_A9TR U254 ( .A(n190), .B(n194), .Y(intadd_4_A_0_) );
  NOR2_X0P5A_A9TR U255 ( .A(n193), .B(n180), .Y(intadd_4_B_0_) );
  NOR2XB_X0P5M_A9TR U256 ( .BN(weight_bit_position[1]), .A(n186), .Y(
        intadd_3_CI) );
  NOR2_X0P5A_A9TR U257 ( .A(n190), .B(n162), .Y(intadd_3_A_0_) );
  NOR2_X0P5A_A9TR U258 ( .A(n195), .B(n203), .Y(intadd_3_B_0_) );
  NOR2_X0P5A_A9TR U259 ( .A(n186), .B(n195), .Y(intadd_2_CI) );
  INV_X0P5B_A9TR U260 ( .A(weight_bit_position[4]), .Y(n192) );
  NOR2_X0P5A_A9TR U261 ( .A(n192), .B(n162), .Y(intadd_2_A_0_) );
  NOR2_X0P5A_A9TR U262 ( .A(n190), .B(n203), .Y(intadd_2_B_0_) );
  NOR2_X0P5A_A9TR U263 ( .A(n162), .B(n180), .Y(intadd_5_CI) );
  NOR2_X0P5A_A9TR U264 ( .A(n176), .B(n191), .Y(intadd_5_A_0_) );
  NOR2_X0P5A_A9TR U265 ( .A(n194), .B(n181), .Y(intadd_5_B_0_) );
  NOR2_X0P5A_A9TR U266 ( .A(n162), .B(n181), .Y(intadd_5_A_1_) );
  NAND2_X0P5A_A9TR U267 ( .A(in_valid), .B(ADC_RESULT[5]), .Y(n159) );
  OAI21_X0P5M_A9TR U268 ( .A0(in_valid), .A1(n186), .B0(n159), .Y(n75) );
  NAND2_X0P5A_A9TR U269 ( .A(in_valid), .B(WEIGHT_BIT_POSITION[0]), .Y(n160)
         );
  OAI21_X0P5M_A9TR U270 ( .A0(in_valid), .A1(n204), .B0(n160), .Y(n59) );
  NAND2_X0P5A_A9TR U271 ( .A(in_valid), .B(ADC_RESULT[3]), .Y(n161) );
  OAI21_X0P5M_A9TR U272 ( .A0(in_valid), .A1(n162), .B0(n161), .Y(n73) );
  NAND2_X0P5A_A9TR U273 ( .A(in_valid), .B(WEIGHT_BIT_POSITION[2]), .Y(n163)
         );
  OAI21_X0P5M_A9TR U274 ( .A0(in_valid), .A1(n195), .B0(n163), .Y(n61) );
  NAND2_X0P5A_A9TR U275 ( .A(in_valid), .B(ADC_RESULT[4]), .Y(n164) );
  OAI21_X0P5M_A9TR U276 ( .A0(in_valid), .A1(n203), .B0(n164), .Y(n74) );
  NAND2_X0P5A_A9TR U277 ( .A(in_valid), .B(ADC_RESULT[1]), .Y(n165) );
  OAI21_X0P5M_A9TR U278 ( .A0(in_valid), .A1(n191), .B0(n165), .Y(n71) );
  NAND2_X0P5A_A9TR U279 ( .A(in_valid), .B(WEIGHT_BIT_POSITION[3]), .Y(n166)
         );
  OAI21_X0P5M_A9TR U280 ( .A0(in_valid), .A1(n190), .B0(n166), .Y(n62) );
  NAND2_X0P5A_A9TR U281 ( .A(in_valid), .B(ADC_RESULT[0]), .Y(n167) );
  OAI21_X0P5M_A9TR U282 ( .A0(in_valid), .A1(n193), .B0(n167), .Y(n70) );
  AO22_X0P5M_A9TR U283 ( .A0(in_valid), .A1(ONES_COUNTER[4]), .B0(
        ones_counter[4]), .B1(n169), .Y(n80) );
  AO22_X0P5M_A9TR U284 ( .A0(in_valid), .A1(WEIGHT_BIT_POSITION[1]), .B0(
        weight_bit_position[1]), .B1(n169), .Y(n60) );
  AO22_X0P5M_A9TR U285 ( .A0(in_valid), .A1(ONES_COUNTER[2]), .B0(
        ones_counter[2]), .B1(n169), .Y(n78) );
  AO22_X0P5M_A9TR U286 ( .A0(in_valid), .A1(ONES_COUNTER[1]), .B0(
        ones_counter[1]), .B1(n169), .Y(n77) );
  AO22_X0P5M_A9TR U287 ( .A0(in_valid), .A1(ONES_COUNTER[0]), .B0(
        ones_counter[0]), .B1(n169), .Y(n76) );
  AO22_X0P5M_A9TR U288 ( .A0(in_valid), .A1(ONES_COUNTER[3]), .B0(
        ones_counter[3]), .B1(n169), .Y(n79) );
  AO22_X0P5M_A9TR U289 ( .A0(in_valid), .A1(INPUT_BIT_POSITION[2]), .B0(
        input_bit_position[2]), .B1(n169), .Y(n69) );
  AO22_X0P5M_A9TR U290 ( .A0(in_valid), .A1(INPUT_BIT_POSITION[1]), .B0(
        input_bit_position[1]), .B1(n169), .Y(n68) );
  AO22_X0P5M_A9TR U291 ( .A0(in_valid), .A1(INPUT_BIT_POSITION[0]), .B0(
        input_bit_position[0]), .B1(n169), .Y(n67) );
  AO22_X0P5M_A9TR U292 ( .A0(weight_bit_position[7]), .A1(n169), .B0(in_valid), 
        .B1(WEIGHT_BIT_POSITION[7]), .Y(n66) );
  AO22_X0P5M_A9TR U293 ( .A0(weight_bit_position[4]), .A1(n169), .B0(in_valid), 
        .B1(WEIGHT_BIT_POSITION[4]), .Y(n63) );
  AO22_X0P5M_A9TR U294 ( .A0(weight_bit_position[6]), .A1(n169), .B0(in_valid), 
        .B1(WEIGHT_BIT_POSITION[6]), .Y(n65) );
  AO22_X0P5M_A9TR U295 ( .A0(adc_result[2]), .A1(n169), .B0(in_valid), .B1(
        ADC_RESULT[2]), .Y(n72) );
  AO22_X0P5M_A9TR U296 ( .A0(weight_bit_position[5]), .A1(n169), .B0(in_valid), 
        .B1(WEIGHT_BIT_POSITION[5]), .Y(n64) );
  AOI21_X0P5M_A9TR U297 ( .A0(n169), .A1(n168), .B0(cur_state[0]), .Y(
        next_state[0]) );
  ADDF_X1M_A9TR U298 ( .A(n172), .B(n171), .CI(n170), .CO(n149), .S(
        intadd_5_A_2_) );
  NOR2_X0P5A_A9TR U299 ( .A(n203), .B(n180), .Y(n175) );
  NOR2_X0P5A_A9TR U300 ( .A(n176), .B(n194), .Y(n174) );
  NOR2_X0P5A_A9TR U301 ( .A(n186), .B(n192), .Y(n173) );
  ADDF_X1M_A9TR U302 ( .A(n175), .B(n174), .CI(n173), .CO(intadd_5_B_2_), .S(
        intadd_2_B_2_) );
  NOR2_X0P5A_A9TR U303 ( .A(n191), .B(n181), .Y(n179) );
  NOR2_X0P5A_A9TR U304 ( .A(n176), .B(n193), .Y(n178) );
  NOR2_X0P5A_A9TR U305 ( .A(n194), .B(n180), .Y(n177) );
  ADDF_X1M_A9TR U306 ( .A(n179), .B(n178), .CI(n177), .CO(intadd_2_B_1_), .S(
        intadd_3_A_1_) );
  NOR2_X0P5A_A9TR U307 ( .A(n191), .B(n180), .Y(n184) );
  NOR2_X0P5A_A9TR U308 ( .A(n193), .B(n181), .Y(n183) );
  NOR2_X0P5A_A9TR U309 ( .A(n192), .B(n194), .Y(n182) );
  ADDF_X1M_A9TR U310 ( .A(n184), .B(n183), .CI(n182), .CO(intadd_3_B_1_), .S(
        intadd_4_A_1_) );
  OA21A1OI2_X0P5M_A9TR U311 ( .A0(n204), .A1(n186), .B0(n185), .C0(
        intadd_4_B_1_), .Y(n189) );
  NOR2_X0P5A_A9TR U312 ( .A(n191), .B(n192), .Y(n188) );
  NAND2_X0P5A_A9TR U313 ( .A(weight_bit_position[1]), .B(adc_result[3]), .Y(
        n202) );
  NOR3_X0P5A_A9TR U314 ( .A(n203), .B(n204), .C(n202), .Y(n201) );
  ADDF_X1M_A9TR U315 ( .A(intadd_4_SUM_1_), .B(n187), .CI(intadd_3_SUM_0_), 
        .CO(intadd_0_B_5_), .S(intadd_0_A_4_) );
  ADDF_X1M_A9TR U316 ( .A(n189), .B(n188), .CI(n201), .CO(n187), .S(n197) );
  NOR2_X0P5A_A9TR U317 ( .A(n191), .B(n190), .Y(n200) );
  NOR2_X0P5A_A9TR U318 ( .A(n193), .B(n192), .Y(n199) );
  NOR2_X0P5A_A9TR U319 ( .A(n195), .B(n194), .Y(n198) );
  ADDF_X1M_A9TR U320 ( .A(n197), .B(n196), .CI(intadd_4_SUM_0_), .CO(
        intadd_0_B_4_), .S(intadd_0_A_3_) );
  ADDF_X1M_A9TR U321 ( .A(n200), .B(n199), .CI(n198), .CO(n196), .S(n207) );
  OA21A1OI2_X0P5M_A9TR U322 ( .A0(n204), .A1(n203), .B0(n202), .C0(n201), .Y(
        n205) );
  ADDF_X1M_A9TR U323 ( .A(n207), .B(n206), .CI(n205), .CO(intadd_0_B_3_), .S(
        intadd_0_A_2_) );
endmodule

