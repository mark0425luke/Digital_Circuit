###################################################################

# Created by write_sdc on Thu Dec 21 02:51:56 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name Small -library                                       \
sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c
set_load -pin_load 0.05 [get_ports {output_branch_1[28]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[27]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[26]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[25]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[24]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[23]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[22]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[21]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[20]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[19]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[18]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[17]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[16]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[15]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[14]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[13]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[12]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[11]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[10]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[9]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[8]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[7]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[6]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[5]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[4]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[3]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[2]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[1]}]
set_load -pin_load 0.05 [get_ports {output_branch_1[0]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[28]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[27]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[26]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[25]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[24]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[23]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[22]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[21]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[20]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[19]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[18]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[17]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[16]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[15]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[14]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[13]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[12]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[11]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[10]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[9]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[8]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[7]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[6]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[5]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[4]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[3]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[2]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[1]}]
set_load -pin_load 0.05 [get_ports {output_branch_2[0]}]
set_load -pin_load 0.05 [get_ports {output_trunk[57]}]
set_load -pin_load 0.05 [get_ports {output_trunk[56]}]
set_load -pin_load 0.05 [get_ports {output_trunk[55]}]
set_load -pin_load 0.05 [get_ports {output_trunk[54]}]
set_load -pin_load 0.05 [get_ports {output_trunk[53]}]
set_load -pin_load 0.05 [get_ports {output_trunk[52]}]
set_load -pin_load 0.05 [get_ports {output_trunk[51]}]
set_load -pin_load 0.05 [get_ports {output_trunk[50]}]
set_load -pin_load 0.05 [get_ports {output_trunk[49]}]
set_load -pin_load 0.05 [get_ports {output_trunk[48]}]
set_load -pin_load 0.05 [get_ports {output_trunk[47]}]
set_load -pin_load 0.05 [get_ports {output_trunk[46]}]
set_load -pin_load 0.05 [get_ports {output_trunk[45]}]
set_load -pin_load 0.05 [get_ports {output_trunk[44]}]
set_load -pin_load 0.05 [get_ports {output_trunk[43]}]
set_load -pin_load 0.05 [get_ports {output_trunk[42]}]
set_load -pin_load 0.05 [get_ports {output_trunk[41]}]
set_load -pin_load 0.05 [get_ports {output_trunk[40]}]
set_load -pin_load 0.05 [get_ports {output_trunk[39]}]
set_load -pin_load 0.05 [get_ports {output_trunk[38]}]
set_load -pin_load 0.05 [get_ports {output_trunk[37]}]
set_load -pin_load 0.05 [get_ports {output_trunk[36]}]
set_load -pin_load 0.05 [get_ports {output_trunk[35]}]
set_load -pin_load 0.05 [get_ports {output_trunk[34]}]
set_load -pin_load 0.05 [get_ports {output_trunk[33]}]
set_load -pin_load 0.05 [get_ports {output_trunk[32]}]
set_load -pin_load 0.05 [get_ports {output_trunk[31]}]
set_load -pin_load 0.05 [get_ports {output_trunk[30]}]
set_load -pin_load 0.05 [get_ports {output_trunk[29]}]
set_load -pin_load 0.05 [get_ports {output_trunk[28]}]
set_load -pin_load 0.05 [get_ports {output_trunk[27]}]
set_load -pin_load 0.05 [get_ports {output_trunk[26]}]
set_load -pin_load 0.05 [get_ports {output_trunk[25]}]
set_load -pin_load 0.05 [get_ports {output_trunk[24]}]
set_load -pin_load 0.05 [get_ports {output_trunk[23]}]
set_load -pin_load 0.05 [get_ports {output_trunk[22]}]
set_load -pin_load 0.05 [get_ports {output_trunk[21]}]
set_load -pin_load 0.05 [get_ports {output_trunk[20]}]
set_load -pin_load 0.05 [get_ports {output_trunk[19]}]
set_load -pin_load 0.05 [get_ports {output_trunk[18]}]
set_load -pin_load 0.05 [get_ports {output_trunk[17]}]
set_load -pin_load 0.05 [get_ports {output_trunk[16]}]
set_load -pin_load 0.05 [get_ports {output_trunk[15]}]
set_load -pin_load 0.05 [get_ports {output_trunk[14]}]
set_load -pin_load 0.05 [get_ports {output_trunk[13]}]
set_load -pin_load 0.05 [get_ports {output_trunk[12]}]
set_load -pin_load 0.05 [get_ports {output_trunk[11]}]
set_load -pin_load 0.05 [get_ports {output_trunk[10]}]
set_load -pin_load 0.05 [get_ports {output_trunk[9]}]
set_load -pin_load 0.05 [get_ports {output_trunk[8]}]
set_load -pin_load 0.05 [get_ports {output_trunk[7]}]
set_load -pin_load 0.05 [get_ports {output_trunk[6]}]
set_load -pin_load 0.05 [get_ports {output_trunk[5]}]
set_load -pin_load 0.05 [get_ports {output_trunk[4]}]
set_load -pin_load 0.05 [get_ports {output_trunk[3]}]
set_load -pin_load 0.05 [get_ports {output_trunk[2]}]
set_load -pin_load 0.05 [get_ports {output_trunk[1]}]
set_load -pin_load 0.05 [get_ports {output_trunk[0]}]
set_load -pin_load 0.05 [get_ports output_branch_1_valid]
set_load -pin_load 0.05 [get_ports output_branch_2_valid]
set_load -pin_load 0.05 [get_ports output_trunk_valid]
set_load -pin_load 0.05 [get_ports input_branch_1_full]
set_load -pin_load 0.05 [get_ports input_branch_2_full]
set_load -pin_load 0.05 [get_ports input_trunk_full]
set_ideal_network -no_propagate  [get_ports clk]
create_clock [get_ports clk]  -period 26.5625  -waveform {0 13.2812}
set_input_delay -clock clk  0  [get_ports clk]
set_input_delay -clock clk  0  [get_ports rst_n]
set_input_delay -clock clk  13.2812  [get_ports INPUT_BRANCH_1_WRITE]
set_input_delay -clock clk  13.2812  [get_ports INPUT_BRANCH_2_WRITE]
set_input_delay -clock clk  13.2812  [get_ports INPUT_TRUNK_WRITE]
set_input_delay -clock clk  13.2812  [get_ports SEL]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[28]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[27]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[26]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[25]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[24]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[23]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[22]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[21]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[20]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[19]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[18]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[17]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[16]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[15]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[14]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[13]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[12]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[11]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[10]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[9]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[8]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[7]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[6]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[5]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[4]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[3]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[2]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[1]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_1[0]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[28]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[27]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[26]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[25]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[24]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[23]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[22]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[21]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[20]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[19]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[18]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[17]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[16]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[15]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[14]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[13]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[12]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[11]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[10]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[9]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[8]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[7]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[6]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[5]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[4]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[3]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[2]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[1]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_BRANCH_2[0]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[57]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[56]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[55]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[54]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[53]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[52]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[51]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[50]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[49]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[48]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[47]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[46]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[45]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[44]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[43]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[42]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[41]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[40]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[39]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[38]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[37]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[36]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[35]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[34]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[33]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[32]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[31]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[30]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[29]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[28]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[27]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[26]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[25]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[24]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[23]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[22]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[21]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[20]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[19]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[18]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[17]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[16]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[15]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[14]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[13]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[12]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[11]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[10]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[9]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[8]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[7]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[6]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[5]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[4]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[3]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[2]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[1]}]
set_input_delay -clock clk  13.2812  [get_ports {INPUT_TRUNK[0]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[28]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[27]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[26]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[25]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[24]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[23]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[22]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[21]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[20]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[19]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[18]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[17]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[16]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[15]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[14]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[13]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[12]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[11]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[10]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[9]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[8]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[7]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[6]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[5]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[4]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[3]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[2]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[1]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_1[0]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[28]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[27]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[26]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[25]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[24]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[23]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[22]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[21]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[20]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[19]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[18]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[17]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[16]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[15]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[14]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[13]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[12]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[11]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[10]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[9]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[8]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[7]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[6]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[5]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[4]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[3]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[2]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[1]}]
set_output_delay -clock clk  13.2812  [get_ports {output_branch_2[0]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[57]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[56]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[55]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[54]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[53]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[52]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[51]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[50]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[49]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[48]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[47]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[46]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[45]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[44]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[43]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[42]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[41]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[40]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[39]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[38]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[37]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[36]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[35]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[34]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[33]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[32]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[31]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[30]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[29]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[28]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[27]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[26]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[25]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[24]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[23]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[22]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[21]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[20]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[19]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[18]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[17]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[16]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[15]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[14]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[13]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[12]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[11]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[10]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[9]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[8]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[7]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[6]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[5]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[4]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[3]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[2]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[1]}]
set_output_delay -clock clk  13.2812  [get_ports {output_trunk[0]}]
set_output_delay -clock clk  13.2812  [get_ports output_branch_1_valid]
set_output_delay -clock clk  13.2812  [get_ports output_branch_2_valid]
set_output_delay -clock clk  13.2812  [get_ports output_trunk_valid]
set_output_delay -clock clk  13.2812  [get_ports input_branch_1_full]
set_output_delay -clock clk  13.2812  [get_ports input_branch_2_full]
set_output_delay -clock clk  13.2812  [get_ports input_trunk_full]
