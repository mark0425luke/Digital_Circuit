/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Tue Dec 19 18:25:20 2023
/////////////////////////////////////////////////////////////


module Activation ( clk, rst_n, in_valid, OFM, out_valid, Activation );
  input [28:0] OFM;
  output [7:0] Activation;
  input clk, rst_n, in_valid;
  output out_valid;
  wire   cur_state, N4, N36, N37, N38, N39, N40, N41, N42, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n60, n61, n62;
  wire   [27:21] ofm;

  DFFRPQ_X1M_A9TR Activation_reg_6_ ( .D(N42), .CK(clk), .R(n58), .Q(
        Activation[6]) );
  DFFRPQ_X1M_A9TR Activation_reg_5_ ( .D(N41), .CK(clk), .R(n58), .Q(
        Activation[5]) );
  DFFRPQ_X1M_A9TR Activation_reg_4_ ( .D(N40), .CK(clk), .R(n58), .Q(
        Activation[4]) );
  DFFRPQ_X1M_A9TR Activation_reg_3_ ( .D(N39), .CK(clk), .R(n58), .Q(
        Activation[3]) );
  DFFRPQ_X1M_A9TR Activation_reg_2_ ( .D(N38), .CK(clk), .R(n58), .Q(
        Activation[2]) );
  DFFRPQ_X1M_A9TR Activation_reg_1_ ( .D(N37), .CK(clk), .R(n58), .Q(
        Activation[1]) );
  DFFRPQ_X1M_A9TR Activation_reg_0_ ( .D(N36), .CK(clk), .R(n58), .Q(
        Activation[0]) );
  DFFRPQ_X1M_A9TR out_valid_reg ( .D(cur_state), .CK(clk), .R(n58), .Q(
        out_valid) );
  DFFRPQ_X0P5M_A9TR cur_state_reg ( .D(in_valid), .CK(clk), .R(n58), .Q(
        cur_state) );
  DFFRPQ_X0P5M_A9TR ofm_reg_28_ ( .D(n57), .CK(clk), .R(n58), .Q(N4) );
  DFFRPQ_X0P5M_A9TR ofm_reg_27_ ( .D(n56), .CK(clk), .R(n58), .Q(ofm[27]) );
  DFFRPQ_X0P5M_A9TR ofm_reg_26_ ( .D(n55), .CK(clk), .R(n58), .Q(ofm[26]) );
  DFFRPQ_X0P5M_A9TR ofm_reg_25_ ( .D(n54), .CK(clk), .R(n58), .Q(ofm[25]) );
  DFFRPQ_X0P5M_A9TR ofm_reg_24_ ( .D(n53), .CK(clk), .R(n58), .Q(ofm[24]) );
  DFFRPQ_X0P5M_A9TR ofm_reg_23_ ( .D(n52), .CK(clk), .R(n58), .Q(ofm[23]) );
  DFFRPQ_X0P5M_A9TR ofm_reg_22_ ( .D(n51), .CK(clk), .R(n58), .Q(ofm[22]) );
  DFFRPQ_X0P5M_A9TR ofm_reg_21_ ( .D(n50), .CK(clk), .R(n58), .Q(ofm[21]) );
  TIEHI_X1M_A9TR U69 ( .Y(n60) );
  INV_X2M_A9TR U70 ( .A(n60), .Y(Activation[7]) );
  INV_X1B_A9TR U71 ( .A(rst_n), .Y(n58) );
  NOR2XB_X0P5M_A9TR U72 ( .BN(cur_state), .A(N4), .Y(n61) );
  AND2_X0P5B_A9TR U73 ( .A(ofm[21]), .B(n61), .Y(N36) );
  AND2_X0P5B_A9TR U74 ( .A(n61), .B(ofm[26]), .Y(N41) );
  AND2_X0P5B_A9TR U75 ( .A(n61), .B(ofm[24]), .Y(N39) );
  AND2_X0P5B_A9TR U76 ( .A(n61), .B(ofm[22]), .Y(N37) );
  AND2_X0P5B_A9TR U77 ( .A(n61), .B(ofm[23]), .Y(N38) );
  AND2_X0P5B_A9TR U78 ( .A(n61), .B(ofm[25]), .Y(N40) );
  AND2_X0P5B_A9TR U79 ( .A(n61), .B(ofm[27]), .Y(N42) );
  INV_X0P5B_A9TR U80 ( .A(in_valid), .Y(n62) );
  AO22_X0P5M_A9TR U81 ( .A0(in_valid), .A1(OFM[25]), .B0(ofm[25]), .B1(n62), 
        .Y(n54) );
  AO22_X0P5M_A9TR U82 ( .A0(in_valid), .A1(OFM[21]), .B0(ofm[21]), .B1(n62), 
        .Y(n50) );
  AO22_X0P5M_A9TR U83 ( .A0(in_valid), .A1(OFM[26]), .B0(ofm[26]), .B1(n62), 
        .Y(n55) );
  AO22_X0P5M_A9TR U84 ( .A0(in_valid), .A1(OFM[22]), .B0(ofm[22]), .B1(n62), 
        .Y(n51) );
  AO22_X0P5M_A9TR U85 ( .A0(in_valid), .A1(OFM[27]), .B0(ofm[27]), .B1(n62), 
        .Y(n56) );
  AO22_X0P5M_A9TR U86 ( .A0(in_valid), .A1(OFM[23]), .B0(ofm[23]), .B1(n62), 
        .Y(n52) );
  AO22_X0P5M_A9TR U87 ( .A0(in_valid), .A1(OFM[28]), .B0(N4), .B1(n62), .Y(n57) );
  AO22_X0P5M_A9TR U88 ( .A0(in_valid), .A1(OFM[24]), .B0(ofm[24]), .B1(n62), 
        .Y(n53) );
endmodule

