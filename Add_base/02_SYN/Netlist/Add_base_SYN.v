/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Mon Jan 15 15:11:14 2024
/////////////////////////////////////////////////////////////


module Add_base ( clk, rst_n, in, out );
  input [41:0] in;
  output [27:0] out;
  input clk, rst_n;
  wire   n1, intadd_0_CI, intadd_0_n20, intadd_0_n19, intadd_0_n18,
         intadd_0_n17, intadd_0_n16, intadd_0_n15, intadd_0_n14, intadd_0_n13,
         intadd_0_n12, intadd_0_n11, intadd_0_n10, intadd_0_n9, intadd_0_n8,
         intadd_0_n7, intadd_0_n6, intadd_0_n5, intadd_0_n4, intadd_0_n3,
         intadd_0_n2, intadd_0_n1, n8;
  wire   [20:0] out_next;

  ADDF_X1M_A9TR intadd_0_U21 ( .A(in[22]), .B(in[1]), .CI(intadd_0_CI), .CO(
        intadd_0_n20), .S(out_next[1]) );
  ADDF_X1M_A9TR intadd_0_U20 ( .A(in[23]), .B(in[2]), .CI(intadd_0_n20), .CO(
        intadd_0_n19), .S(out_next[2]) );
  ADDF_X1M_A9TR intadd_0_U19 ( .A(in[24]), .B(in[3]), .CI(intadd_0_n19), .CO(
        intadd_0_n18), .S(out_next[3]) );
  ADDF_X1M_A9TR intadd_0_U18 ( .A(in[25]), .B(in[4]), .CI(intadd_0_n18), .CO(
        intadd_0_n17), .S(out_next[4]) );
  ADDF_X1M_A9TR intadd_0_U17 ( .A(in[26]), .B(in[5]), .CI(intadd_0_n17), .CO(
        intadd_0_n16), .S(out_next[5]) );
  ADDF_X1M_A9TR intadd_0_U16 ( .A(in[27]), .B(in[6]), .CI(intadd_0_n16), .CO(
        intadd_0_n15), .S(out_next[6]) );
  ADDF_X1M_A9TR intadd_0_U15 ( .A(in[28]), .B(in[7]), .CI(intadd_0_n15), .CO(
        intadd_0_n14), .S(out_next[7]) );
  ADDF_X1M_A9TR intadd_0_U14 ( .A(in[29]), .B(in[8]), .CI(intadd_0_n14), .CO(
        intadd_0_n13), .S(out_next[8]) );
  ADDF_X1M_A9TR intadd_0_U13 ( .A(in[30]), .B(in[9]), .CI(intadd_0_n13), .CO(
        intadd_0_n12), .S(out_next[9]) );
  ADDF_X1M_A9TR intadd_0_U12 ( .A(in[31]), .B(in[10]), .CI(intadd_0_n12), .CO(
        intadd_0_n11), .S(out_next[10]) );
  ADDF_X1M_A9TR intadd_0_U11 ( .A(in[32]), .B(in[11]), .CI(intadd_0_n11), .CO(
        intadd_0_n10), .S(out_next[11]) );
  ADDF_X1M_A9TR intadd_0_U10 ( .A(in[33]), .B(in[12]), .CI(intadd_0_n10), .CO(
        intadd_0_n9), .S(out_next[12]) );
  ADDF_X1M_A9TR intadd_0_U9 ( .A(in[34]), .B(in[13]), .CI(intadd_0_n9), .CO(
        intadd_0_n8), .S(out_next[13]) );
  ADDF_X1M_A9TR intadd_0_U8 ( .A(in[35]), .B(in[14]), .CI(intadd_0_n8), .CO(
        intadd_0_n7), .S(out_next[14]) );
  ADDF_X1M_A9TR intadd_0_U7 ( .A(in[36]), .B(in[15]), .CI(intadd_0_n7), .CO(
        intadd_0_n6), .S(out_next[15]) );
  ADDF_X1M_A9TR intadd_0_U6 ( .A(in[37]), .B(in[16]), .CI(intadd_0_n6), .CO(
        intadd_0_n5), .S(out_next[16]) );
  ADDF_X1M_A9TR intadd_0_U5 ( .A(in[38]), .B(in[17]), .CI(intadd_0_n5), .CO(
        intadd_0_n4), .S(out_next[17]) );
  ADDF_X1M_A9TR intadd_0_U4 ( .A(in[39]), .B(in[18]), .CI(intadd_0_n4), .CO(
        intadd_0_n3), .S(out_next[18]) );
  ADDF_X1M_A9TR intadd_0_U3 ( .A(in[40]), .B(in[19]), .CI(intadd_0_n3), .CO(
        intadd_0_n2), .S(out_next[19]) );
  ADDF_X1M_A9TR intadd_0_U2 ( .A(in[41]), .B(in[20]), .CI(intadd_0_n2), .CO(
        intadd_0_n1), .S(out_next[20]) );
  DFFRPQ_X1M_A9TR out_reg_21_ ( .D(intadd_0_n1), .CK(clk), .R(n1), .Q(out[21])
         );
  DFFRPQ_X1M_A9TR out_reg_20_ ( .D(out_next[20]), .CK(clk), .R(n1), .Q(out[20]) );
  DFFRPQ_X1M_A9TR out_reg_19_ ( .D(out_next[19]), .CK(clk), .R(n1), .Q(out[19]) );
  DFFRPQ_X1M_A9TR out_reg_18_ ( .D(out_next[18]), .CK(clk), .R(n1), .Q(out[18]) );
  DFFRPQ_X1M_A9TR out_reg_17_ ( .D(out_next[17]), .CK(clk), .R(n1), .Q(out[17]) );
  DFFRPQ_X1M_A9TR out_reg_16_ ( .D(out_next[16]), .CK(clk), .R(n1), .Q(out[16]) );
  DFFRPQ_X1M_A9TR out_reg_15_ ( .D(out_next[15]), .CK(clk), .R(n1), .Q(out[15]) );
  DFFRPQ_X1M_A9TR out_reg_14_ ( .D(out_next[14]), .CK(clk), .R(n1), .Q(out[14]) );
  DFFRPQ_X1M_A9TR out_reg_13_ ( .D(out_next[13]), .CK(clk), .R(n1), .Q(out[13]) );
  DFFRPQ_X1M_A9TR out_reg_12_ ( .D(out_next[12]), .CK(clk), .R(n1), .Q(out[12]) );
  DFFRPQ_X1M_A9TR out_reg_11_ ( .D(out_next[11]), .CK(clk), .R(n1), .Q(out[11]) );
  DFFRPQ_X1M_A9TR out_reg_10_ ( .D(out_next[10]), .CK(clk), .R(n1), .Q(out[10]) );
  DFFRPQ_X1M_A9TR out_reg_9_ ( .D(out_next[9]), .CK(clk), .R(n1), .Q(out[9])
         );
  DFFRPQ_X1M_A9TR out_reg_8_ ( .D(out_next[8]), .CK(clk), .R(n1), .Q(out[8])
         );
  DFFRPQ_X1M_A9TR out_reg_7_ ( .D(out_next[7]), .CK(clk), .R(n1), .Q(out[7])
         );
  DFFRPQ_X1M_A9TR out_reg_6_ ( .D(out_next[6]), .CK(clk), .R(n1), .Q(out[6])
         );
  DFFRPQ_X1M_A9TR out_reg_5_ ( .D(out_next[5]), .CK(clk), .R(n1), .Q(out[5])
         );
  DFFRPQ_X1M_A9TR out_reg_4_ ( .D(out_next[4]), .CK(clk), .R(n1), .Q(out[4])
         );
  DFFRPQ_X1M_A9TR out_reg_3_ ( .D(out_next[3]), .CK(clk), .R(n1), .Q(out[3])
         );
  DFFRPQ_X1M_A9TR out_reg_2_ ( .D(out_next[2]), .CK(clk), .R(n1), .Q(out[2])
         );
  DFFRPQ_X1M_A9TR out_reg_1_ ( .D(out_next[1]), .CK(clk), .R(n1), .Q(out[1])
         );
  DFFRPQ_X1M_A9TR out_reg_0_ ( .D(out_next[0]), .CK(clk), .R(n1), .Q(out[0])
         );
  OA1B2_X0P5M_A9TR U5 ( .B0(in[0]), .B1(in[21]), .A0N(intadd_0_CI), .Y(
        out_next[0]) );
  TIEHI_X1M_A9TR U6 ( .Y(n8) );
  INV_X1B_A9TR U7 ( .A(n8), .Y(out[27]) );
  INV_X1B_A9TR U8 ( .A(n8), .Y(out[26]) );
  INV_X1B_A9TR U9 ( .A(n8), .Y(out[25]) );
  INV_X1B_A9TR U10 ( .A(n8), .Y(out[24]) );
  INV_X1B_A9TR U11 ( .A(n8), .Y(out[23]) );
  INV_X1B_A9TR U12 ( .A(n8), .Y(out[22]) );
  INV_X1P2M_A9TR U13 ( .A(rst_n), .Y(n1) );
  AND2_X0P5B_A9TR U14 ( .A(in[0]), .B(in[21]), .Y(intadd_0_CI) );
endmodule

