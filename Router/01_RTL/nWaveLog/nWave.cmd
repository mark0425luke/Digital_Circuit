wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/mark/Digital_Circuit/Router/01_RTL/Router.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Router"
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvGetSignalClose -win $_nWave1
wvResizeWindow -win $_nWave1 1920 31 1920 1017
wvZoom -win $_nWave1 0.000000 689433.203854
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Router"
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
{/TESTBED/I_Router/output_branch_1_valid} \
{/TESTBED/I_Router/output_branch_2_valid} \
{/TESTBED/I_Router/output_trunk_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 11 12 )} 
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvSetPosition -win $_nWave1 {("G1" 12)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
{/TESTBED/I_Router/output_branch_1_valid} \
{/TESTBED/I_Router/output_branch_2_valid} \
{/TESTBED/I_Router/output_trunk_valid} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 10 11 12 )} 
wvSetPosition -win $_nWave1 {("G1" 12)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Router"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Router"
wvSetPosition -win $_nWave1 {("G1" 15)}
wvSetPosition -win $_nWave1 {("G1" 15)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
{/TESTBED/I_Router/output_branch_1_valid} \
{/TESTBED/I_Router/output_branch_2_valid} \
{/TESTBED/I_Router/output_trunk_valid} \
{/TESTBED/I_Router/output_branch_1\[28:0\]} \
{/TESTBED/I_Router/output_branch_2\[28:0\]} \
{/TESTBED/I_Router/output_trunk\[57:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 13 14 15 )} 
wvSetPosition -win $_nWave1 {("G1" 15)}
wvSetPosition -win $_nWave1 {("G1" 15)}
wvSetPosition -win $_nWave1 {("G1" 15)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
{/TESTBED/I_Router/output_branch_1_valid} \
{/TESTBED/I_Router/output_branch_2_valid} \
{/TESTBED/I_Router/output_trunk_valid} \
{/TESTBED/I_Router/output_branch_1\[28:0\]} \
{/TESTBED/I_Router/output_branch_2\[28:0\]} \
{/TESTBED/I_Router/output_trunk\[57:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 13 14 15 )} 
wvSetPosition -win $_nWave1 {("G1" 15)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Router"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Router"
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/clk} \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
{/TESTBED/I_Router/output_branch_1_valid} \
{/TESTBED/I_Router/output_branch_2_valid} \
{/TESTBED/I_Router/output_trunk_valid} \
{/TESTBED/I_Router/output_branch_1\[28:0\]} \
{/TESTBED/I_Router/output_branch_2\[28:0\]} \
{/TESTBED/I_Router/output_trunk\[57:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Router/clk} \
{/TESTBED/I_Router/INPUT_BRANCH_1\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_1_WRITE} \
{/TESTBED/I_Router/INPUT_BRANCH_2\[28:0\]} \
{/TESTBED/I_Router/INPUT_BRANCH_2_WRITE} \
{/TESTBED/I_Router/INPUT_TRUNK\[57:0\]} \
{/TESTBED/I_Router/INPUT_TRUNK_WRITE} \
{/TESTBED/I_Router/SEL} \
{/TESTBED/I_Router/add\[0:0\]} \
{/TESTBED/I_Router/concatenate\[57:0\]} \
{/TESTBED/I_Router/output_branch_1_valid} \
{/TESTBED/I_Router/output_branch_2_valid} \
{/TESTBED/I_Router/output_trunk_valid} \
{/TESTBED/I_Router/output_branch_1\[28:0\]} \
{/TESTBED/I_Router/output_branch_2\[28:0\]} \
{/TESTBED/I_Router/output_trunk\[57:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 15 )} 
