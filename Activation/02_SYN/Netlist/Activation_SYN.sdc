###################################################################

# Created by write_sdc on Tue Dec 19 18:25:20 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_wire_load_mode top
set_wire_load_model -name Small -library                                       \
sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c
set_load -pin_load 0.05 [get_ports out_valid]
set_load -pin_load 0.05 [get_ports {Activation[7]}]
set_load -pin_load 0.05 [get_ports {Activation[6]}]
set_load -pin_load 0.05 [get_ports {Activation[5]}]
set_load -pin_load 0.05 [get_ports {Activation[4]}]
set_load -pin_load 0.05 [get_ports {Activation[3]}]
set_load -pin_load 0.05 [get_ports {Activation[2]}]
set_load -pin_load 0.05 [get_ports {Activation[1]}]
set_load -pin_load 0.05 [get_ports {Activation[0]}]
set_ideal_network -no_propagate  [get_ports clk]
create_clock [get_ports clk]  -period 26.5625  -waveform {0 13.2812}
set_input_delay -clock clk  0  [get_ports clk]
set_input_delay -clock clk  0  [get_ports rst_n]
set_input_delay -clock clk  13.2812  [get_ports in_valid]
set_input_delay -clock clk  13.2812  [get_ports {OFM[28]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[27]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[26]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[25]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[24]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[23]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[22]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[21]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[20]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[19]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[18]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[17]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[16]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[15]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[14]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[13]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[12]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[11]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[10]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[9]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[8]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[7]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[6]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[5]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[4]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[3]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[2]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[1]}]
set_input_delay -clock clk  13.2812  [get_ports {OFM[0]}]
set_output_delay -clock clk  13.2812  [get_ports out_valid]
set_output_delay -clock clk  13.2812  [get_ports {Activation[7]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[6]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[5]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[4]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[3]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[2]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[1]}]
set_output_delay -clock clk  13.2812  [get_ports {Activation[0]}]
