###################################################################

# Created by write_sdc on Tue Jan  9 01:32:35 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name Small -library                                       \
sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c
set_load -pin_load 0.05 [get_ports out_valid]
set_load -pin_load 0.05 [get_ports {toPEs[39]}]
set_load -pin_load 0.05 [get_ports {toPEs[38]}]
set_load -pin_load 0.05 [get_ports {toPEs[37]}]
set_load -pin_load 0.05 [get_ports {toPEs[36]}]
set_load -pin_load 0.05 [get_ports {toPEs[35]}]
set_load -pin_load 0.05 [get_ports {toPEs[34]}]
set_load -pin_load 0.05 [get_ports {toPEs[33]}]
set_load -pin_load 0.05 [get_ports {toPEs[32]}]
set_load -pin_load 0.05 [get_ports {toPEs[31]}]
set_load -pin_load 0.05 [get_ports {toPEs[30]}]
set_load -pin_load 0.05 [get_ports {toPEs[29]}]
set_load -pin_load 0.05 [get_ports {toPEs[28]}]
set_load -pin_load 0.05 [get_ports {toPEs[27]}]
set_load -pin_load 0.05 [get_ports {toPEs[26]}]
set_load -pin_load 0.05 [get_ports {toPEs[25]}]
set_load -pin_load 0.05 [get_ports {toPEs[24]}]
set_load -pin_load 0.05 [get_ports {toPEs[23]}]
set_load -pin_load 0.05 [get_ports {toPEs[22]}]
set_load -pin_load 0.05 [get_ports {toPEs[21]}]
set_load -pin_load 0.05 [get_ports {toPEs[20]}]
set_load -pin_load 0.05 [get_ports {toPEs[19]}]
set_load -pin_load 0.05 [get_ports {toPEs[18]}]
set_load -pin_load 0.05 [get_ports {toPEs[17]}]
set_load -pin_load 0.05 [get_ports {toPEs[16]}]
set_load -pin_load 0.05 [get_ports {toPEs[15]}]
set_load -pin_load 0.05 [get_ports {toPEs[14]}]
set_load -pin_load 0.05 [get_ports {toPEs[13]}]
set_load -pin_load 0.05 [get_ports {toPEs[12]}]
set_load -pin_load 0.05 [get_ports {toPEs[11]}]
set_load -pin_load 0.05 [get_ports {toPEs[10]}]
set_load -pin_load 0.05 [get_ports {toPEs[9]}]
set_load -pin_load 0.05 [get_ports {toPEs[8]}]
set_load -pin_load 0.05 [get_ports {toPEs[7]}]
set_load -pin_load 0.05 [get_ports {toPEs[6]}]
set_load -pin_load 0.05 [get_ports {toPEs[5]}]
set_load -pin_load 0.05 [get_ports {toPEs[4]}]
set_load -pin_load 0.05 [get_ports {toPEs[3]}]
set_load -pin_load 0.05 [get_ports {toPEs[2]}]
set_load -pin_load 0.05 [get_ports {toPEs[1]}]
set_load -pin_load 0.05 [get_ports {toPEs[0]}]
set_ideal_network -no_propagate  [get_ports clk]
create_clock [get_ports clk]  -period 3.125  -waveform {0 1.5625}
set_input_delay -clock clk  0  [get_ports clk]
set_input_delay -clock clk  0  [get_ports rst_n]
set_input_delay -clock clk  1.5625  [get_ports in_valid]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[23]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[22]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[21]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[20]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[19]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[18]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[17]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[16]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[15]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[14]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[13]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[12]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[11]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[10]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[9]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[8]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[7]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[6]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[5]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[4]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[3]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[2]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[1]}]
set_input_delay -clock clk  1.5625  [get_ports {DATAIN[0]}]
set_output_delay -clock clk  1.5625  [get_ports out_valid]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[39]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[38]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[37]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[36]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[35]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[34]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[33]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[32]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[31]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[30]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[29]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[28]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[27]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[26]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[25]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[24]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[23]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[22]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[21]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[20]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[19]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[18]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[17]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[16]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[15]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[14]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[13]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[12]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[11]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[10]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[9]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[8]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[7]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[6]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[5]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[4]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[3]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[2]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[1]}]
set_output_delay -clock clk  1.5625  [get_ports {toPEs[0]}]
