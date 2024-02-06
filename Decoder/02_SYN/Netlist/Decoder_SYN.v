/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Wed Jan 31 18:19:45 2024
/////////////////////////////////////////////////////////////


module Decoder ( clk, rst_n, in_valid, WHICH_FILTER, out_valid, demux );
  input [5:0] WHICH_FILTER;
  output [63:0] demux;
  input clk, rst_n, in_valid;
  output out_valid;
  wire   cur_state_0_, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16,
         N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30,
         N31, N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44,
         N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58,
         N59, N60, N61, N62, N63, N64, N65, N66, N67, N68, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88;
  wire   [5:0] which_filter;

  DFFRPQ_X1M_A9TR demux_reg_56_ ( .D(N61), .CK(clk), .R(n48), .Q(demux[56]) );
  DFFRPQ_X1M_A9TR demux_reg_41_ ( .D(N46), .CK(clk), .R(n48), .Q(demux[41]) );
  DFFRPQ_X1M_A9TR demux_reg_26_ ( .D(N31), .CK(clk), .R(n48), .Q(demux[26]) );
  DFFRPQ_X1M_A9TR demux_reg_11_ ( .D(N16), .CK(clk), .R(n48), .Q(demux[11]) );
  DFFRPQ_X1M_A9TR out_valid_reg ( .D(cur_state_0_), .CK(clk), .R(n48), .Q(
        out_valid) );
  DFFRPQ_X0P5M_A9TR cur_state_reg_0_ ( .D(n47), .CK(clk), .R(n48), .Q(
        cur_state_0_) );
  DFFRPQ_X0P5M_A9TR which_filter_reg_0__0__5_ ( .D(n46), .CK(clk), .R(n48), 
        .Q(which_filter[5]) );
  DFFRPQ_X0P5M_A9TR which_filter_reg_0__0__4_ ( .D(n45), .CK(clk), .R(n48), 
        .Q(which_filter[4]) );
  DFFRPQ_X0P5M_A9TR which_filter_reg_0__0__3_ ( .D(n44), .CK(clk), .R(n48), 
        .Q(which_filter[3]) );
  DFFRPQ_X0P5M_A9TR which_filter_reg_0__0__2_ ( .D(n43), .CK(clk), .R(n48), 
        .Q(which_filter[2]) );
  DFFRPQ_X0P5M_A9TR which_filter_reg_0__0__1_ ( .D(n42), .CK(clk), .R(n48), 
        .Q(which_filter[1]) );
  DFFRPQ_X0P5M_A9TR which_filter_reg_0__0__0_ ( .D(n41), .CK(clk), .R(n48), 
        .Q(which_filter[0]) );
  DFFRPQ_X1M_A9TR demux_reg_63_ ( .D(N68), .CK(clk), .R(n48), .Q(demux[63]) );
  DFFRPQ_X1M_A9TR demux_reg_62_ ( .D(N67), .CK(clk), .R(n48), .Q(demux[62]) );
  DFFRPQ_X1M_A9TR demux_reg_61_ ( .D(N66), .CK(clk), .R(n48), .Q(demux[61]) );
  DFFRPQ_X1M_A9TR demux_reg_60_ ( .D(N65), .CK(clk), .R(n48), .Q(demux[60]) );
  DFFRPQ_X1M_A9TR demux_reg_59_ ( .D(N64), .CK(clk), .R(n48), .Q(demux[59]) );
  DFFRPQ_X1M_A9TR demux_reg_58_ ( .D(N63), .CK(clk), .R(n48), .Q(demux[58]) );
  DFFRPQ_X1M_A9TR demux_reg_57_ ( .D(N62), .CK(clk), .R(n48), .Q(demux[57]) );
  DFFRPQ_X1M_A9TR demux_reg_55_ ( .D(N60), .CK(clk), .R(n48), .Q(demux[55]) );
  DFFRPQ_X1M_A9TR demux_reg_54_ ( .D(N59), .CK(clk), .R(n48), .Q(demux[54]) );
  DFFRPQ_X1M_A9TR demux_reg_53_ ( .D(N58), .CK(clk), .R(n48), .Q(demux[53]) );
  DFFRPQ_X1M_A9TR demux_reg_52_ ( .D(N57), .CK(clk), .R(n48), .Q(demux[52]) );
  DFFRPQ_X1M_A9TR demux_reg_51_ ( .D(N56), .CK(clk), .R(n48), .Q(demux[51]) );
  DFFRPQ_X1M_A9TR demux_reg_50_ ( .D(N55), .CK(clk), .R(n48), .Q(demux[50]) );
  DFFRPQ_X1M_A9TR demux_reg_49_ ( .D(N54), .CK(clk), .R(n48), .Q(demux[49]) );
  DFFRPQ_X1M_A9TR demux_reg_48_ ( .D(N53), .CK(clk), .R(n48), .Q(demux[48]) );
  DFFRPQ_X1M_A9TR demux_reg_47_ ( .D(N52), .CK(clk), .R(n48), .Q(demux[47]) );
  DFFRPQ_X1M_A9TR demux_reg_46_ ( .D(N51), .CK(clk), .R(n48), .Q(demux[46]) );
  DFFRPQ_X1M_A9TR demux_reg_45_ ( .D(N50), .CK(clk), .R(n48), .Q(demux[45]) );
  DFFRPQ_X1M_A9TR demux_reg_44_ ( .D(N49), .CK(clk), .R(n48), .Q(demux[44]) );
  DFFRPQ_X1M_A9TR demux_reg_43_ ( .D(N48), .CK(clk), .R(n48), .Q(demux[43]) );
  DFFRPQ_X1M_A9TR demux_reg_42_ ( .D(N47), .CK(clk), .R(n48), .Q(demux[42]) );
  DFFRPQ_X1M_A9TR demux_reg_40_ ( .D(N45), .CK(clk), .R(n48), .Q(demux[40]) );
  DFFRPQ_X1M_A9TR demux_reg_39_ ( .D(N44), .CK(clk), .R(n48), .Q(demux[39]) );
  DFFRPQ_X1M_A9TR demux_reg_38_ ( .D(N43), .CK(clk), .R(n48), .Q(demux[38]) );
  DFFRPQ_X1M_A9TR demux_reg_37_ ( .D(N42), .CK(clk), .R(n48), .Q(demux[37]) );
  DFFRPQ_X1M_A9TR demux_reg_36_ ( .D(N41), .CK(clk), .R(n48), .Q(demux[36]) );
  DFFRPQ_X1M_A9TR demux_reg_35_ ( .D(N40), .CK(clk), .R(n48), .Q(demux[35]) );
  DFFRPQ_X1M_A9TR demux_reg_34_ ( .D(N39), .CK(clk), .R(n48), .Q(demux[34]) );
  DFFRPQ_X1M_A9TR demux_reg_33_ ( .D(N38), .CK(clk), .R(n48), .Q(demux[33]) );
  DFFRPQ_X1M_A9TR demux_reg_32_ ( .D(N37), .CK(clk), .R(n48), .Q(demux[32]) );
  DFFRPQ_X1M_A9TR demux_reg_31_ ( .D(N36), .CK(clk), .R(n48), .Q(demux[31]) );
  DFFRPQ_X1M_A9TR demux_reg_30_ ( .D(N35), .CK(clk), .R(n48), .Q(demux[30]) );
  DFFRPQ_X1M_A9TR demux_reg_29_ ( .D(N34), .CK(clk), .R(n48), .Q(demux[29]) );
  DFFRPQ_X1M_A9TR demux_reg_28_ ( .D(N33), .CK(clk), .R(n48), .Q(demux[28]) );
  DFFRPQ_X1M_A9TR demux_reg_27_ ( .D(N32), .CK(clk), .R(n48), .Q(demux[27]) );
  DFFRPQ_X1M_A9TR demux_reg_25_ ( .D(N30), .CK(clk), .R(n48), .Q(demux[25]) );
  DFFRPQ_X1M_A9TR demux_reg_24_ ( .D(N29), .CK(clk), .R(n48), .Q(demux[24]) );
  DFFRPQ_X1M_A9TR demux_reg_23_ ( .D(N28), .CK(clk), .R(n48), .Q(demux[23]) );
  DFFRPQ_X1M_A9TR demux_reg_22_ ( .D(N27), .CK(clk), .R(n48), .Q(demux[22]) );
  DFFRPQ_X1M_A9TR demux_reg_21_ ( .D(N26), .CK(clk), .R(n48), .Q(demux[21]) );
  DFFRPQ_X1M_A9TR demux_reg_20_ ( .D(N25), .CK(clk), .R(n48), .Q(demux[20]) );
  DFFRPQ_X1M_A9TR demux_reg_19_ ( .D(N24), .CK(clk), .R(n48), .Q(demux[19]) );
  DFFRPQ_X1M_A9TR demux_reg_18_ ( .D(N23), .CK(clk), .R(n48), .Q(demux[18]) );
  DFFRPQ_X1M_A9TR demux_reg_17_ ( .D(N22), .CK(clk), .R(n48), .Q(demux[17]) );
  DFFRPQ_X1M_A9TR demux_reg_16_ ( .D(N21), .CK(clk), .R(n48), .Q(demux[16]) );
  DFFRPQ_X1M_A9TR demux_reg_15_ ( .D(N20), .CK(clk), .R(n48), .Q(demux[15]) );
  DFFRPQ_X1M_A9TR demux_reg_14_ ( .D(N19), .CK(clk), .R(n48), .Q(demux[14]) );
  DFFRPQ_X1M_A9TR demux_reg_13_ ( .D(N18), .CK(clk), .R(n48), .Q(demux[13]) );
  DFFRPQ_X1M_A9TR demux_reg_12_ ( .D(N17), .CK(clk), .R(n48), .Q(demux[12]) );
  DFFRPQ_X1M_A9TR demux_reg_10_ ( .D(N15), .CK(clk), .R(n48), .Q(demux[10]) );
  DFFRPQ_X1M_A9TR demux_reg_9_ ( .D(N14), .CK(clk), .R(n48), .Q(demux[9]) );
  DFFRPQ_X1M_A9TR demux_reg_8_ ( .D(N13), .CK(clk), .R(n48), .Q(demux[8]) );
  DFFRPQ_X1M_A9TR demux_reg_7_ ( .D(N12), .CK(clk), .R(n48), .Q(demux[7]) );
  DFFRPQ_X1M_A9TR demux_reg_6_ ( .D(N11), .CK(clk), .R(n48), .Q(demux[6]) );
  DFFRPQ_X1M_A9TR demux_reg_5_ ( .D(N10), .CK(clk), .R(n48), .Q(demux[5]) );
  DFFRPQ_X1M_A9TR demux_reg_4_ ( .D(N9), .CK(clk), .R(n48), .Q(demux[4]) );
  DFFRPQ_X1M_A9TR demux_reg_3_ ( .D(N8), .CK(clk), .R(n48), .Q(demux[3]) );
  DFFRPQ_X1M_A9TR demux_reg_2_ ( .D(N7), .CK(clk), .R(n48), .Q(demux[2]) );
  DFFRPQ_X1M_A9TR demux_reg_1_ ( .D(N6), .CK(clk), .R(n48), .Q(demux[1]) );
  DFFRPQ_X1M_A9TR demux_reg_0_ ( .D(N5), .CK(clk), .R(n48), .Q(demux[0]) );
  INV_X0P5B_A9TR U115 ( .A(which_filter[3]), .Y(n78) );
  NOR2_X0P7M_A9TR U116 ( .A(n76), .B(n69), .Y(N26) );
  NOR2_X0P7M_A9TR U117 ( .A(n76), .B(n68), .Y(N18) );
  NOR2_X0P7M_A9TR U118 ( .A(n76), .B(n67), .Y(N34) );
  NOR2_X0P7M_A9TR U119 ( .A(n73), .B(n68), .Y(N17) );
  NOR2_X0P7M_A9TR U120 ( .A(n73), .B(n71), .Y(N27) );
  NOR2_X0P7M_A9TR U121 ( .A(n76), .B(n63), .Y(N12) );
  NOR2_X0P7M_A9TR U122 ( .A(n76), .B(n64), .Y(N10) );
  NOR2_X0P7M_A9TR U123 ( .A(n73), .B(n66), .Y(N35) );
  NOR2_X0P7M_A9TR U124 ( .A(n76), .B(n66), .Y(N36) );
  NOR2_X0P7M_A9TR U125 ( .A(n73), .B(n69), .Y(N25) );
  NOR2_X0P7M_A9TR U126 ( .A(n73), .B(n67), .Y(N33) );
  NOR2_X0P7M_A9TR U127 ( .A(n76), .B(n65), .Y(N8) );
  NOR2_X0P7M_A9TR U128 ( .A(n73), .B(n65), .Y(N7) );
  NOR2_X0P7M_A9TR U129 ( .A(n73), .B(n61), .Y(N29) );
  NOR2_X0P7M_A9TR U130 ( .A(n76), .B(n60), .Y(N22) );
  NOR2_X0P7M_A9TR U131 ( .A(n73), .B(n60), .Y(N21) );
  NOR2_X0P7M_A9TR U132 ( .A(n76), .B(n61), .Y(N30) );
  NOR2_X0P7M_A9TR U133 ( .A(n73), .B(n64), .Y(N9) );
  NOR2_X0P7M_A9TR U134 ( .A(n76), .B(n62), .Y(N14) );
  NOR2_X0P7M_A9TR U135 ( .A(n73), .B(n62), .Y(N13) );
  NOR2_X0P7M_A9TR U136 ( .A(n73), .B(n63), .Y(N11) );
  NOR2_X0P7M_A9TR U137 ( .A(n73), .B(n72), .Y(N31) );
  NOR2_X0P7M_A9TR U138 ( .A(n76), .B(n70), .Y(N20) );
  NOR2_X0P7M_A9TR U139 ( .A(n76), .B(n71), .Y(N28) );
  NOR2_X0P7M_A9TR U140 ( .A(n76), .B(n74), .Y(N16) );
  NOR2_X0P7M_A9TR U141 ( .A(n73), .B(n70), .Y(N19) );
  NOR2_X0P7M_A9TR U142 ( .A(n73), .B(n75), .Y(N23) );
  NOR2_X0P7M_A9TR U143 ( .A(n76), .B(n75), .Y(N24) );
  NOR2_X0P7M_A9TR U144 ( .A(n76), .B(n72), .Y(N32) );
  NOR2_X0P7M_A9TR U145 ( .A(n73), .B(n74), .Y(N15) );
  INV_X1M_A9TR U146 ( .A(which_filter[2]), .Y(n80) );
  INV_X1M_A9TR U147 ( .A(which_filter[1]), .Y(n82) );
  INV_X1B_A9TR U148 ( .A(which_filter[0]), .Y(n88) );
  INV_X1M_A9TR U149 ( .A(which_filter[4]), .Y(n84) );
  INV_X1B_A9TR U150 ( .A(which_filter[5]), .Y(n86) );
  NOR2_X0P7M_A9TR U151 ( .A(n72), .B(n59), .Y(N63) );
  NOR2_X0P7M_A9TR U152 ( .A(n60), .B(n58), .Y(N54) );
  NOR2_X0P7M_A9TR U153 ( .A(n60), .B(n59), .Y(N53) );
  NOR2_X0P7M_A9TR U154 ( .A(n63), .B(n59), .Y(N43) );
  NOR2_X0P7M_A9TR U155 ( .A(n62), .B(n59), .Y(N45) );
  NOR2_X0P7M_A9TR U156 ( .A(n61), .B(n58), .Y(N62) );
  NOR2_X0P7M_A9TR U157 ( .A(n64), .B(n58), .Y(N42) );
  NOR2_X0P7M_A9TR U158 ( .A(n61), .B(n59), .Y(N61) );
  NOR2_X0P7M_A9TR U159 ( .A(n65), .B(n58), .Y(N40) );
  NOR2_X0P7M_A9TR U160 ( .A(n65), .B(n59), .Y(N39) );
  NOR2_X0P7M_A9TR U161 ( .A(n66), .B(n58), .Y(N68) );
  NOR2_X0P7M_A9TR U162 ( .A(n63), .B(n58), .Y(N44) );
  NOR2_X0P7M_A9TR U163 ( .A(n64), .B(n59), .Y(N41) );
  NOR2_X0P7M_A9TR U164 ( .A(n67), .B(n59), .Y(N65) );
  NOR2_X0P7M_A9TR U165 ( .A(n62), .B(n58), .Y(N46) );
  NOR2_X0P7M_A9TR U166 ( .A(n69), .B(n59), .Y(N57) );
  NOR2_X0P7M_A9TR U167 ( .A(n67), .B(n58), .Y(N66) );
  NOR2_X0P7M_A9TR U168 ( .A(n72), .B(n58), .Y(N64) );
  NOR2_X0P7M_A9TR U169 ( .A(n71), .B(n58), .Y(N60) );
  NOR2_X0P7M_A9TR U170 ( .A(n66), .B(n59), .Y(N67) );
  NOR2_X0P7M_A9TR U171 ( .A(n71), .B(n59), .Y(N59) );
  NOR2_X0P7M_A9TR U172 ( .A(n69), .B(n58), .Y(N58) );
  NOR2_X0P7M_A9TR U173 ( .A(n70), .B(n59), .Y(N51) );
  NOR2_X0P7M_A9TR U174 ( .A(n70), .B(n58), .Y(N52) );
  NOR2_X0P7M_A9TR U175 ( .A(n74), .B(n58), .Y(N48) );
  NOR2_X0P7M_A9TR U176 ( .A(n74), .B(n59), .Y(N47) );
  NOR2_X0P7M_A9TR U177 ( .A(n75), .B(n58), .Y(N56) );
  NOR2_X0P7M_A9TR U178 ( .A(n68), .B(n58), .Y(N50) );
  NOR2_X0P7M_A9TR U179 ( .A(n75), .B(n59), .Y(N55) );
  NOR2_X0P7M_A9TR U180 ( .A(n68), .B(n59), .Y(N49) );
  NOR2_X0P7M_A9TR U181 ( .A(n49), .B(n58), .Y(N38) );
  NOR2_X0P7M_A9TR U182 ( .A(n49), .B(n73), .Y(N5) );
  NOR2_X0P7M_A9TR U183 ( .A(n49), .B(n59), .Y(N37) );
  NOR2_X0P7M_A9TR U184 ( .A(n49), .B(n76), .Y(N6) );
  OAI21_X0P5M_A9TR U185 ( .A0(in_valid), .A1(n88), .B0(n87), .Y(n41) );
  OAI21_X0P5M_A9TR U186 ( .A0(in_valid), .A1(n86), .B0(n85), .Y(n46) );
  OAI21_X0P5M_A9TR U187 ( .A0(in_valid), .A1(n80), .B0(n79), .Y(n43) );
  OAI21_X0P5M_A9TR U188 ( .A0(in_valid), .A1(n84), .B0(n83), .Y(n45) );
  OAI21_X0P5M_A9TR U189 ( .A0(in_valid), .A1(n78), .B0(n77), .Y(n44) );
  OAI21_X0P5M_A9TR U190 ( .A0(in_valid), .A1(n82), .B0(n81), .Y(n42) );
  NOR2XB_X0P5M_A9TR U191 ( .BN(in_valid), .A(cur_state_0_), .Y(n47) );
  INV_X3M_A9TR U192 ( .A(rst_n), .Y(n48) );
  NAND2_X0P5A_A9TR U193 ( .A(in_valid), .B(WHICH_FILTER[3]), .Y(n77) );
  NAND2_X0P5A_A9TR U194 ( .A(in_valid), .B(WHICH_FILTER[2]), .Y(n79) );
  NAND2_X0P5A_A9TR U195 ( .A(in_valid), .B(WHICH_FILTER[1]), .Y(n81) );
  NAND2_X0P5A_A9TR U196 ( .A(in_valid), .B(WHICH_FILTER[5]), .Y(n85) );
  NAND2_X0P5A_A9TR U197 ( .A(in_valid), .B(WHICH_FILTER[4]), .Y(n83) );
  NAND2_X0P5A_A9TR U198 ( .A(in_valid), .B(WHICH_FILTER[0]), .Y(n87) );
  NOR2_X1A_A9TR U199 ( .A(which_filter[1]), .B(which_filter[2]), .Y(n50) );
  NOR2_X1A_A9TR U200 ( .A(which_filter[3]), .B(which_filter[4]), .Y(n51) );
  NAND2_X1A_A9TR U201 ( .A(n50), .B(n51), .Y(n49) );
  NAND3_X1A_A9TR U202 ( .A(which_filter[0]), .B(cur_state_0_), .C(n86), .Y(n76) );
  NAND3_X1A_A9TR U203 ( .A(which_filter[5]), .B(which_filter[0]), .C(
        cur_state_0_), .Y(n58) );
  NAND3_X1A_A9TR U204 ( .A(which_filter[5]), .B(cur_state_0_), .C(n88), .Y(n59) );
  NAND3_X1A_A9TR U205 ( .A(n86), .B(n88), .C(cur_state_0_), .Y(n73) );
  NOR2_X1A_A9TR U206 ( .A(which_filter[3]), .B(n84), .Y(n55) );
  NAND2_X1A_A9TR U207 ( .A(n50), .B(n55), .Y(n60) );
  NOR2_X1A_A9TR U208 ( .A(n78), .B(n84), .Y(n56) );
  NAND2_X1A_A9TR U209 ( .A(n50), .B(n56), .Y(n61) );
  NOR2_X1A_A9TR U210 ( .A(which_filter[4]), .B(n78), .Y(n54) );
  NAND2_X1A_A9TR U211 ( .A(n50), .B(n54), .Y(n62) );
  NOR2_X1A_A9TR U212 ( .A(n82), .B(n80), .Y(n52) );
  NAND2_X1A_A9TR U213 ( .A(n51), .B(n52), .Y(n63) );
  NOR2_X1A_A9TR U214 ( .A(which_filter[1]), .B(n80), .Y(n53) );
  NAND2_X1A_A9TR U215 ( .A(n51), .B(n53), .Y(n64) );
  NOR2_X1A_A9TR U216 ( .A(which_filter[2]), .B(n82), .Y(n57) );
  NAND2_X1A_A9TR U217 ( .A(n51), .B(n57), .Y(n65) );
  NAND2_X1A_A9TR U218 ( .A(n52), .B(n56), .Y(n66) );
  NAND2_X1A_A9TR U219 ( .A(n53), .B(n56), .Y(n67) );
  NAND2_X1A_A9TR U220 ( .A(n52), .B(n55), .Y(n71) );
  NAND2_X1A_A9TR U221 ( .A(n53), .B(n55), .Y(n69) );
  NAND2_X1A_A9TR U222 ( .A(n52), .B(n54), .Y(n70) );
  NAND2_X1A_A9TR U223 ( .A(n53), .B(n54), .Y(n68) );
  NAND2_X1A_A9TR U224 ( .A(n57), .B(n54), .Y(n74) );
  NAND2_X1A_A9TR U225 ( .A(n57), .B(n55), .Y(n75) );
  NAND2_X1A_A9TR U226 ( .A(n57), .B(n56), .Y(n72) );
endmodule

