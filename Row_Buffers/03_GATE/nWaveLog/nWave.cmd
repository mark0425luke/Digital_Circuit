wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/mark/Digital_Circuit/Row_Buffers/03_GATE/Row_Buffers_SYN.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 356780017.351070 667023510.699826
wvSetCursor -win $_nWave1 403074303.807899
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvExpandBus -win $_nWave1 {("G1" 2)}
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvCollapseBus -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvAddSignal -win $_nWave1 "/TESTBED/I_PATTERN/CYCLE" \
           "/TESTBED/I_PATTERN/DATAIN\[23:0\]" "/TESTBED/I_PATTERN/clk" \
           "/TESTBED/I_PATTERN/i\[31:0\]" "/TESTBED/I_PATTERN/in_valid" \
           "/TESTBED/I_PATTERN/j\[31:0\]" "/TESTBED/I_PATTERN/out_valid" \
           "/TESTBED/I_PATTERN/pat_num\[31:0\]" "/TESTBED/I_PATTERN/rst_n" \
           "/TESTBED/I_PATTERN/toPEs\[39:0\]" \
           "/TESTBED/I_PATTERN/wait_cycle\[31:0\]"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 6 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvSetPosition -win $_nWave1 {("G2" 12)}
wvSetPosition -win $_nWave1 {("G2" 12)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 12 )} 
wvSetPosition -win $_nWave1 {("G2" 12)}
wvSetPosition -win $_nWave1 {("G2" 13)}
wvSetPosition -win $_nWave1 {("G2" 13)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSetPosition -win $_nWave1 {("G2" 13)}
wvSetPosition -win $_nWave1 {("G2" 13)}
wvSetPosition -win $_nWave1 {("G2" 13)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSetPosition -win $_nWave1 {("G2" 13)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvSetPosition -win $_nWave1 {("G2" 14)}
wvSetPosition -win $_nWave1 {("G2" 14)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
{/TESTBED/I_Row_Buffers/w\[4:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSetPosition -win $_nWave1 {("G2" 14)}
wvSetPosition -win $_nWave1 {("G2" 15)}
wvSetPosition -win $_nWave1 {("G2" 15)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
{/TESTBED/I_Row_Buffers/w\[4:0\]} \
{/TESTBED/I_Row_Buffers/sram_output\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 15 )} 
wvSetPosition -win $_nWave1 {("G2" 15)}
wvSetPosition -win $_nWave1 {("G2" 16)}
wvSetPosition -win $_nWave1 {("G2" 16)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
{/TESTBED/I_Row_Buffers/w\[4:0\]} \
{/TESTBED/I_Row_Buffers/sram_output\[39:0\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[9:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 16 )} 
wvSetPosition -win $_nWave1 {("G2" 16)}
wvSetPosition -win $_nWave1 {("G2" 17)}
wvSetPosition -win $_nWave1 {("G2" 17)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
{/TESTBED/I_Row_Buffers/w\[4:0\]} \
{/TESTBED/I_Row_Buffers/sram_output\[39:0\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[9:0\]} \
{/TESTBED/I_Row_Buffers/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 17 )} 
wvSetPosition -win $_nWave1 {("G2" 17)}
wvSetPosition -win $_nWave1 {("G2" 17)}
wvSetPosition -win $_nWave1 {("G2" 17)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/out_valid} \
{/TESTBED/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/CYCLE} -color ID_RED5 \
{/TESTBED/I_PATTERN/DATAIN\[23:0\]} \
{/TESTBED/I_PATTERN/clk} \
{/TESTBED/I_PATTERN/i\[31:0\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_PATTERN/j\[31:0\]} \
{/TESTBED/I_PATTERN/out_valid} \
{/TESTBED/I_PATTERN/pat_num\[31:0\]} \
{/TESTBED/I_PATTERN/rst_n} \
{/TESTBED/I_PATTERN/toPEs\[39:0\]} \
{/TESTBED/I_PATTERN/wait_cycle\[31:0\]} \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[39:0\]} \
{/TESTBED/I_Row_Buffers/w\[4:0\]} \
{/TESTBED/I_Row_Buffers/sram_output\[39:0\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[9:0\]} \
{/TESTBED/I_Row_Buffers/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 17 )} 
wvSetPosition -win $_nWave1 {("G2" 17)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 15 )} 
wvExit
