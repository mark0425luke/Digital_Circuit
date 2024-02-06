wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/mark/Digital_Circuit/Pooling/01_RTL/Pooling.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Pooling"
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Pooling/activation_pixel\[0:7\]} \
{/TESTBED/I_Pooling/clk} \
{/TESTBED/I_Pooling/out_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 )} 
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Pooling/activation_pixel\[0:7\]} \
{/TESTBED/I_Pooling/clk} \
{/TESTBED/I_Pooling/out_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 )} 
wvSetPosition -win $_nWave1 {("G1" 3)}
wvGetSignalClose -win $_nWave1
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvExpandBus -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Pooling"
wvSetPosition -win $_nWave1 {("G1" 13)}
wvSetPosition -win $_nWave1 {("G1" 13)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Pooling/activation_pixel\[0:7\]} \
{/TESTBED/I_Pooling/activation_pixel\[0\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[1\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[2\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[3\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[4\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[5\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[6\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[7\]\[0:3\]} \
{/TESTBED/I_Pooling/clk} \
{/TESTBED/I_Pooling/out_valid} \
{/TESTBED/I_Pooling/Pooling\[63:0\]} \
{/TESTBED/I_Pooling/pooling\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 13 )} 
wvSetPosition -win $_nWave1 {("G1" 13)}
wvSetPosition -win $_nWave1 {("G1" 13)}
wvSetPosition -win $_nWave1 {("G1" 13)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Pooling/activation_pixel\[0:7\]} \
{/TESTBED/I_Pooling/activation_pixel\[0\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[1\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[2\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[3\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[4\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[5\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[6\]\[0:3\]} \
{/TESTBED/I_Pooling/activation_pixel\[7\]\[0:3\]} \
{/TESTBED/I_Pooling/clk} \
{/TESTBED/I_Pooling/out_valid} \
{/TESTBED/I_Pooling/Pooling\[63:0\]} \
{/TESTBED/I_Pooling/pooling\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 13 )} 
wvSetPosition -win $_nWave1 {("G1" 13)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 13 )} 
wvExpandBus -win $_nWave1 {("G1" 13)}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvCollapseBus -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 13)}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvExpandBus -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 21)}
wvExit
