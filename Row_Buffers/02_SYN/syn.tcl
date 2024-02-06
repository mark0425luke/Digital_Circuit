#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================

#======================================================
#*  Set Libraries
#todo Select Needed Technology
#======================================================
# ? 40nm technology
set search_path { ./../01_RTL   										\
				  ./../04_MEM/sram_448word_12bit/						\
				  ./../04_MEM/sram_2400word_48bit/						\
				  ./../04_MEM/sram_1792word_32bit/						\
				  ./../04_MEM/sram_256word_8bit/						\
				  ./../04_MEM/sram_1024word_16bit/						\
				  ./../04_MEM/sram_512word_16bit/						\
                  /usr/cad/synopsys/synthesis/2019.12/dw/sim_ver/      	\
			      /usr/cad/synopsys/synthesis/2019.12/libraries/syn/   	\
			      /usr/cad/arm/CBDK_TSMC40_Arm_f2.0/CIC/SynopsysDC/db/sc9_base_rvt/ \
				  }


set synthetic_library {dw_foundation.sldb}
#! Slow - 0.81v, 125C
# set link_library {* dw_foundation.sldb standard.sldb sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c.db}
# set target_library {sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c.db}
#! Typical - 0.9v, 25C


# depend on sram, each time choose one
# set link_library {	* dw_foundation.sldb \
# 					standard.sldb \
# 					sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db \
# 					sram_448word_12bit_sp_hde_nldm_tt_0p90v_0p90v_25c_syn.db \
# 
# 					 }

# set link_library {	* dw_foundation.sldb \
# 					standard.sldb \
# 					sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db \
# 					sram_1792word_32bit_sp_hde_nldm_tt_0p90v_0p90v_25c_syn.db \
# 					 }

# set link_library {	* dw_foundation.sldb \
# 					standard.sldb \
# 					sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db \
# 					sram_2400word_48bit_sp_hde_nldm_tt_0p90v_0p90v_25c_syn.db\
# 						}

set link_library {	* dw_foundation.sldb \
					standard.sldb \
					sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db \
					sram_256word_8bit_sp_hde_nldm_tt_0p90v_0p90v_25c_syn.db\
						}

# set link_library {	* dw_foundation.sldb \
# 					standard.sldb \
# 					sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db \
# 					sram_1024word_16bit_sp_hde_nldm_tt_0p90v_0p90v_25c_syn.db\
# 						}


# set link_library {	* dw_foundation.sldb \
# 					standard.sldb \
# 					sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db \
# 					sram_512word_16bit_sp_hde_nldm_tt_0p90v_0p90v_25c_syn.db\
# 						}


set target_library {sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db}

#======================================================
#*  Global Parameters
#todo Change Current Design & Clock Period 
#======================================================
set DESIGN "Row_Buffers"
set CLK_period 3.125
# set CLK_period 4.6875
# set CLK_period 7.8125
# set CLK_period 14.0625
# set CLK_period 26.5625
set IN_DLY [expr 0.5*$CLK_period]
set OUT_DLY [expr 0.5*$CLK_period]
set hdlin_ff_always_sync_set_reset true

#======================================================
#*  Read RTL Code
#todo Change Needed Design.sv, Package.sv, Interface.sv
#======================================================
set hdlin_auto_save_templates TRUE
analyze -f sverilog $DESIGN\.v
elaborate $DESIGN
# read_sverilog {$DESIGN\.sv}
# current_design $DESIGN

#======================================================
#*  Global Setting
#======================================================
set_wire_load_mode top

#======================================================
#*  Set Design Constraints
#======================================================
# set_max_delay $CLK_period -from [all_inputs] -to [all_outputs]
create_clock -name "clk" -period $CLK_period clk
set_ideal_net clk
set_input_delay $IN_DLY -clock clk [all_inputs]
set_input_delay 0 -clock clk clk
set_input_delay 0 -clock clk rst_n
set_output_delay $OUT_DLY -clock clk [all_outputs]
set_load 0.05 [all_outputs]

#======================================================
#*  Optimization
#======================================================
uniquify
check_design > Report/$DESIGN\.check
set_fix_multiple_port_nets -all -buffer_constants
set_fix_hold [all_clocks]
compile_ultra

#======================================================
#*  Output Reports 
#======================================================
report_timing >  Report/$DESIGN\.timing
report_area >  Report/$DESIGN\.area
report_resource >  Report/$DESIGN\.resource

#======================================================
#*  Change Naming Rule
#======================================================
set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
change_names -hierarchy -rules name_rule

#======================================================
#*  Output Results
#======================================================
set verilogout_higher_designs_first true
write -format verilog -output Netlist/$DESIGN\_SYN.v -hierarchy
write_sdf -version 3.0 -context verilog -load_delay cell Netlist/$DESIGN\_SYN.sdf
write_sdc Netlist/$DESIGN\_SYN.sdc

#======================================================
#*  Finish and Quit
#======================================================
report_resource
report_timing
report_area
exit
