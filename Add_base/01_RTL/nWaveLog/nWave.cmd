wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/mark/Digital_Circuit/Add_base/01_RTL/Add_base.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/clk} \
{/TESTBED/in\[11:0\]} \
{/TESTBED/out\[28:0\]} \
{/TESTBED/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/clk} \
{/TESTBED/in\[11:0\]} \
{/TESTBED/out\[28:0\]} \
{/TESTBED/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/clk} \
{/TESTBED/in\[11:0\]} \
{/TESTBED/out\[28:0\]} \
{/TESTBED/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/in_array\[0:2\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/clk} \
{/TESTBED/in\[11:0\]} \
{/TESTBED/out\[28:0\]} \
{/TESTBED/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_PATTERN/in_array\[0:2\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalClose -win $_nWave1
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvExpandBus -win $_nWave1 {("G2" 1)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_PATTERN"
wvSelectSignal -win $_nWave1 {( "G1" 3 )} {( "G2" 2 3 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} {( "G2" 2 3 4 )} 
wvSetRadix -win $_nWave1 -format UDec
