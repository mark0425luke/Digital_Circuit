wvResizeWindow -win $_nWave1 0 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/mark/Digital_Circuit/Shift_and_Add/01_RTL/Shift_and_Add.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 266606.703297
wvZoom -win $_nWave1 28063.863505 266606.703297
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 "/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]"
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetCursor -win $_nWave1 161924.425197
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 3 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetRadix -win $_nWave1 -2Com
wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvExpandBus -win $_nWave1 {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetPosition -win $_nWave1 {("G1" 5)}
wvCollapseBus -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[8\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 2 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 2 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSelectSignal -win $_nWave1 {( "G4" 1 2 )} 
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetRadix -win $_nWave1 -format UDec
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ADC_RESULT\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ADC_RESULT\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetPosition -win $_nWave1 {("G4" 4)}
wvGetSignalClose -win $_nWave1
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetPosition -win $_nWave1 {("G4" 4)}
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetRadix -win $_nWave1 -format Bin
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetRadix -win $_nWave1 -format UDec
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetPosition -win $_nWave1 {("G4" 2)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 4 5 )} 
wvSetRadix -win $_nWave1 -2Com
wvZoomAll -win $_nWave1
wvZoom -win $_nWave1 0.000000 1826319.294770
wvZoom -win $_nWave1 251806.305301 370473.644581
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 278417.127026
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSetRadix -win $_nWave1 -Unsigned
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetRadix -win $_nWave1 -Unsigned
wvSetRadix -win $_nWave1 -2Com
wvSetCursor -win $_nWave1 188523.326430 -snap {("G3" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 280297.750469
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 266005.012299 -snap {("G5" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetCursor -win $_nWave1 302489.107101
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 302489.107101
wvSetCursor -win $_nWave1 231777.665629
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSetRadix -win $_nWave1 -Unsigned
wvSetRadix -win $_nWave1 -2Com
wvSetCursor -win $_nWave1 249455.525997 -snap {("G5" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 0.000000 625871.481971
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetRadix -win $_nWave1 -2Com
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSetRadix -win $_nWave1 -2Com
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetCursor -win $_nWave1 278716.143318
wvSetCursor -win $_nWave1 296073.910251
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSetRadix -win $_nWave1 -Unsigned
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetRadix -win $_nWave1 -Unsigned
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSetCursor -win $_nWave1 312935.740985
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 5 6 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G4" 5)}
wvSetPosition -win $_nWave1 {("G4" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 4 5 )} 
wvSetPosition -win $_nWave1 {("G4" 5)}
wvSetPosition -win $_nWave1 {("G4" 5)}
wvSetPosition -win $_nWave1 {("G4" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 4 5 )} 
wvSetPosition -win $_nWave1 {("G4" 5)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 6 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvSelectSignal -win $_nWave1 {( "G4" 4 5 6 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 3)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSetPosition -win $_nWave1 {("G5" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSetPosition -win $_nWave1 {("G5" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSetPosition -win $_nWave1 {("G5" 3)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 1 2 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 2 3 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetRadix -win $_nWave1 -2Com
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/multiple\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/multiple\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetRadix -win $_nWave1 -2Com
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0"
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/multiple\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/I_Shift_and_Add/ADC_RESULT\[3:0\]} \
{/TESTBED/I_Shift_and_Add/INPUT_BIT_POSITION\[2:0\]} \
{/TESTBED/I_Shift_and_Add/ONES_COUNTER\[2:0\]} \
{/TESTBED/I_Shift_and_Add/WEIGHT_BIT_POSITION\[255:0\]} \
{/TESTBED/I_Shift_and_Add/weight_bit_position\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/I_Shift_and_Add/clk} \
{/TESTBED/I_Shift_and_Add/cur_state\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/I_Shift_and_Add/out_valid} \
{/TESTBED/I_Shift_and_Add/input_shift\[0:31\]} \
{/TESTBED/I_Shift_and_Add/Shift_and_Add\[607:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/WEIGHT_BIT_POSITION\[7:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/ones_counter_1t\[2:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/OFFSET\[8:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_shift\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/multiple\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/weight_subtract\[11:0\]} \
{/TESTBED/I_Shift_and_Add/genblk1\[0\]/U0/input_shift\[18:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetRadix -win $_nWave1 -Unsigned
wvSetRadix -win $_nWave1 -2Com
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 398286.360675
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvExit
