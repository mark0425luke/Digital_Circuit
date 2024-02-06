#======================================================
#
# PrimeTime  Scripts (dctcl mode)
#
#======================================================

#======================================================
#  1. Set the Power Analysis Mode
#======================================================

set power_enable_analysis true
set power_analysis_mode time_based
set power_report_leakage_breakdowns true
set power_clock_network_include_register_clock_pin_power false

#======================================================
#  2. Read and link the design
#======================================================
set search_path { ./\
                  ./File/ \
                  /usr/cad/synopsys/synthesis/2019.12/dw/sim_ver/ \
			        /usr/cad/synopsys/synthesis/2019.12/libraries/syn/ \
			        /usr/cad/arm/CBDK_TSMC40_Arm_f2.0/CIC/SynopsysDC/db/sc9_base_rvt/ }
set synthetic_library {dw_foundation.sldb}
#! Slow - 0.81v, 125C
# set target_library {sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c.db}
# set link_library {* dw_foundation.sldb standard.sldb sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c.db}
#! Typical - 0.9v, 25C
set link_library {* dw_foundation.sldb standard.sldb sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db}
set target_library {sc9_cln40g_base_rvt_tt_typical_max_0p90v_25c.db}

set DESIGN "Accumulator"
read_verilog $DESIGN\_SYN.v
current_design $DESIGN
link

#======================================================
#  3. Set transition time / annotate parasitics
#======================================================
set_input_transition .1 [all_inputs]
read_sdc File/$DESIGN\_SYN.sdc
read_sdf -load_delay net $DESIGN\_SYN.sdf

#======================================================
#  4. Read Switching Activity File
#======================================================
read_vcd -strip_path TESTBED/I_$DESIGN $DESIGN\_SYN.fsdb

#======================================================
#  5. Perform power analysis
#======================================================
check_power
update_power

#======================================================
#  6. Generate Power Report
#======================================================
# BUG command 

set_power_analysis_options -waveform_interval 1 -waveform_format out -waveform_output vcd
# vcd.out
# report_power > Report/$DESIGN\_POWER 
# report_power -verbose
report_power -verbose > Report/$DESIGN\_POWER 

report_unit
exit
