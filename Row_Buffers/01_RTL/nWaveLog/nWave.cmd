wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/mark/Digital_Circuit/Row_Buffers/01_RTL/Row_Buffers.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers/genblk1\[0\]/S0"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvGetSignalClose -win $_nWave1
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
{/TESTBED/I_PATTERN/in_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvSetPosition -win $_nWave1 {("G1" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
{/TESTBED/I_PATTERN/in_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSetPosition -win $_nWave1 {("G1" 7)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 155376.910448 503421.189851
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_Row_Buffers/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_Row_Buffers/toPEs\[39:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 2776695.866378 3380655.705987
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Row_Buffers"
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_Row_Buffers/toPEs\[39:0\]} \
{/TESTBED/I_Row_Buffers/out_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Row_Buffers/DATAIN\[23:0\]} \
{/TESTBED/I_Row_Buffers/address\[7:0\]} \
{/TESTBED/I_Row_Buffers/sram_input\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_input_select\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output\[0:4\]} \
{/TESTBED/I_Row_Buffers/sram_output_DFF\[0:4\]} \
{/TESTBED/I_PATTERN/in_valid} \
{/TESTBED/I_Row_Buffers/toPEs\[39:0\]} \
{/TESTBED/I_Row_Buffers/out_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvGetSignalClose -win $_nWave1
wvExit
