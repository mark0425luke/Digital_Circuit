import argparse
import math

def write_design(A_BIT=8, W_BIT=5, DAC_BIT=2, ARRAY_SIZE=32, ADC_NUM=8, ADC_BIT=8):

    SEL_BIT = math.ceil(math.log2(ARRAY_SIZE/ADC_NUM))
    LUT_BIT = DAC_BIT+W_BIT+math.ceil(math.log2(ARRAY_SIZE))
    BUF_BIT = A_BIT+W_BIT+math.ceil(math.log2(ARRAY_SIZE))

    with open('../01_RTL/S_AND_A.v', 'w') as design:

        design.write('`include \"DEMUX.v\"\n')
        design.write('`include \"MUX.v\"\n')

        design.write('\n')

        design.write('module S_AND_A\n')

        design.write('(\n')
        design.write('\tclk,\n')
        design.write('\trst_n,\n')
        design.write('\tSEL,\n')
        for i in range(ADC_NUM):
            design.write('\tIN_LUT_{},\n'.format(i))
        for i in range(ARRAY_SIZE):
            design.write('\tIN_BUF_{},\n'.format(i))
        for i in range(ARRAY_SIZE):
            if i!=ARRAY_SIZE-1:
                design.write('\tOUT_BUF_{},\n'.format(i))
            else:
                design.write('\tOUT_BUF_{}\n'.format(i))
        design.write(');\n')

        design.write('\n')

        design.write('input clk;\n')
        design.write('input rst_n;\n')
        design.write('input [{}:0] SEL;\n'.format(SEL_BIT-1))
        for i in range(ADC_NUM):
            design.write('input signed [{}:0] IN_LUT_{};\n'.format(LUT_BIT-1,i))
        for i in range(ARRAY_SIZE):
            design.write('input signed [{}:0] IN_BUF_{};\n'.format(BUF_BIT-1,i))
        for i in range(ARRAY_SIZE):
            design.write('output signed [{}:0] OUT_BUF_{};\n'.format(BUF_BIT-1,i))

        design.write('\n')
        
        design.write('reg [{}:0] sel;\n'.format(SEL_BIT-1))
        for i in range(ADC_NUM):
            design.write('wire signed [{}:0] mux_out_{};\n'.format(BUF_BIT-1,i))
        for i in range(ADC_NUM):
            design.write('reg signed [{}:0] add_in1_{};\n'.format(LUT_BIT-1,i))
        for i in range(ADC_NUM):
            design.write('reg signed [{}:0] add_in2_{};\n'.format(BUF_BIT-1,i))
        for i in range(ADC_NUM):
            design.write('reg signed [{}:0] add_out_{};\n'.format(BUF_BIT-1,i))

        design.write('\n')

        design.write('always @(posedge clk or negedge rst_n)\n')
        design.write('\tif (!rst_n)\n')
        design.write('\t\tsel <= 0;\n')
        design.write('\telse\n')
        design.write('\t\tsel <= SEL;\n')
        for i in range(ADC_NUM):
            design.write('always @(posedge clk or negedge rst_n)\n')
            design.write('\tif (!rst_n)\n')
            design.write('\t\tadd_in1_{} <= 0;\n'.format(i))
            design.write('\telse\n')
            design.write('\t\tadd_in1_{} <= IN_LUT_{};\n'.format(i,i))
            design.write('\n')
        for i in range(ADC_NUM):
            design.write('always @(posedge clk or negedge rst_n)\n')
            design.write('\tif (!rst_n)\n')
            design.write('\t\tadd_in2_{} <= 0;\n'.format(i))
            design.write('\telse\n')
            design.write('\t\tadd_in2_{} <= mux_out_{};\n'.format(i,i))
            design.write('\n')
        for i in range(ADC_NUM):
            design.write('always @(*)\n')
            design.write('\tadd_out_{} = add_in1_{} + add_in2_{};\n'.format(i,i,i))
            design.write('\n')

        design.write('\n')

        for i in range(ADC_NUM):
            design.write('MUX_{}TO1 #(.A_BIT({}), .W_BIT({}), .DAC_BIT({}), .ARRAY_SIZE({}))\n'.format(2**SEL_BIT,A_BIT,W_BIT,DAC_BIT,ARRAY_SIZE))
            design.write('mux_{} (.SEL(sel),'.format(i))
            for j in range(2**SEL_BIT):
                design.write(' .IN_BUF_{}(IN_BUF_{}),'.format(j,i*2**SEL_BIT+j))
            design.write(' .MUX(mux_out_{}));'.format(i))
            design.write('\n\n')

        for i in range(ADC_NUM):
            design.write('DEMUX_1TO{} #(.A_BIT({}), .W_BIT({}), .DAC_BIT({}), .ARRAY_SIZE({}))\n'.format(2**SEL_BIT,A_BIT,W_BIT,DAC_BIT,ARRAY_SIZE))
            design.write('demux_{} (.SEL(sel),'.format(i))
            design.write(' .IN_COL(add_out_{}),'.format(i))
            for j in range(2**SEL_BIT):
                if j!=2**SEL_BIT-1:
                    design.write(' .DEMUX_{}(OUT_BUF_{}),'.format(j,i*2**SEL_BIT+j))
                else:
                    design.write(' .DEMUX_{}(OUT_BUF_{}));'.format(j,i*2**SEL_BIT+j))
            design.write('\n\n')

        design.write('endmodule\n')

def write_pattern(A_BIT=8, W_BIT=5, DAC_BIT=2, ARRAY_SIZE=32, ADC_NUM=8, ADC_BIT=8, CYCLE=2, PATNUM=100):
    SEL_BIT = math.ceil(math.log2(ARRAY_SIZE/ADC_NUM))
    LUT_BIT = DAC_BIT+W_BIT+math.ceil(math.log2(ARRAY_SIZE))
    BUF_BIT = A_BIT+W_BIT+math.ceil(math.log2(ARRAY_SIZE))

    with open('../00_TESTBED/PATTERN.v', 'w') as pattern:

        pattern.write('module PATTERN\n')

        pattern.write('(\n')
        pattern.write('\tclk,\n')
        pattern.write('\trst_n,\n')
        pattern.write('\tSEL,\n')
        for i in range(ADC_NUM):
            pattern.write('\tIN_LUT_{},\n'.format(i))
        for i in range(ARRAY_SIZE):
            pattern.write('\tIN_BUF_{},\n'.format(i))
        for i in range(ARRAY_SIZE):
            if i!=ARRAY_SIZE-1:
                pattern.write('\tOUT_BUF_{},\n'.format(i))
            else:
                pattern.write('\tOUT_BUF_{}\n'.format(i))
        pattern.write(');\n')

        pattern.write('\n')

        pattern.write('parameter CYCLE = {};\n'.format(CYCLE))
        pattern.write('parameter PATNUM = {};\n'.format(PATNUM))

        pattern.write('\n')

        pattern.write('reg [{}:0] sel;\n'.format(SEL_BIT-1))
        pattern.write('integer i;\n')

        pattern.write('\n')

        pattern.write('output reg clk;\n')
        pattern.write('output reg rst_n;\n')
        pattern.write('output reg [{}:0] SEL;\n'.format(SEL_BIT-1))
        for i in range(ADC_NUM):
            pattern.write('output reg signed [{}:0] IN_LUT_{};\n'.format(LUT_BIT-1,i))
        for i in range(ARRAY_SIZE):
            pattern.write('output reg signed [{}:0] IN_BUF_{};\n'.format(BUF_BIT-1,i))
        for i in range(ARRAY_SIZE):
            pattern.write('input signed [{}:0] OUT_BUF_{};\n'.format(BUF_BIT-1,i))

        pattern.write('\n')

        pattern.write('initial clk = 0;\n')
        pattern.write('always #(CYCLE/2.0) clk = ~clk;\n')

        pattern.write('\n')

        pattern.write('initial exe;\n')
        
        pattern.write('\n')
        
        pattern.write('task reset; begin\n')
        pattern.write('\tforce clk = 0;\n')
        pattern.write('\trst_n = 1;\n')
        pattern.write('\tSEL = 0;\n')
        pattern.write('\tsel = 0;\n')
        for i in range(ARRAY_SIZE):
            pattern.write('\tIN_BUF_{} = 0;\n'.format(i))
        for i in range(ADC_NUM):
            pattern.write('\tIN_LUT_{} = 0;\n'.format(i))
        pattern.write('\t\n')
        pattern.write('\t#CYCLE; rst_n = 0;\n')
        pattern.write('\trepeat(5) #CYCLE; rst_n = 1;\n')
        pattern.write('\t\n')
        pattern.write('\trelease clk;\n')
        pattern.write('\trepeat(5) @(negedge clk);\n')
        pattern.write('\t\n')
        pattern.write('end endtask\n')

        pattern.write('\n')

        pattern.write('task send; begin\n')
        for i in range(ADC_NUM):
            pattern.write('\tIN_LUT_{} = $random();\n'.format(i))
        for i in range(ARRAY_SIZE):
            pattern.write('\tIN_BUF_{} = $random();\n'.format(i))
        pattern.write('\tSEL = sel;\n')
        pattern.write('\t\n')
        pattern.write('\tsel = sel + 1;\n')
        pattern.write('\t@(negedge clk);\n')
        pattern.write('\tSEL = 0;\n')
        for i in range(ARRAY_SIZE):
            pattern.write('\tIN_BUF_{} = 0;\n'.format(i))
        for i in range(ADC_NUM):
            pattern.write('\tIN_LUT_{} = 0;\n'.format(i))
        pattern.write('\trepeat(127) @(negedge clk);\n')
        pattern.write('\t\n')
        pattern.write('end endtask\n')

        pattern.write('\n')
        pattern.write('task exe; begin\n')
        pattern.write('\treset;\n')
        pattern.write('\tfor (i=0; i<PATNUM; i=i+1)\n')
        pattern.write('\t\tsend;\n')
        pattern.write('\t$finish;\n')
        pattern.write('end endtask\n')

        pattern.write('endmodule\n')

def write_testbed(A_BIT=8, W_BIT=5, DAC_BIT=2, ARRAY_SIZE=32, ADC_NUM=8, ADC_BIT=8):

    SEL_BIT = math.ceil(math.log2(ARRAY_SIZE/ADC_NUM))
    LUT_BIT = DAC_BIT+W_BIT+math.ceil(math.log2(ARRAY_SIZE))
    BUF_BIT = A_BIT+W_BIT+math.ceil(math.log2(ARRAY_SIZE))

    with open('../00_TESTBED/TESTBED.v', 'w') as testbed:

        testbed.write('`timescale 1ns/1ps\n')
        testbed.write('`include "PATTERN.v"\n')
        testbed.write('`ifdef RTL\n')
        testbed.write('`include "S_AND_A.v"\n')
        testbed.write('`elsif GATE\n')
        testbed.write('`include "S_AND_A_SYN.v"\n')
        testbed.write('`endif\n')

        testbed.write('\n')

        testbed.write('module TESTBED ();\n')

        testbed.write('wire clk;\n')
        testbed.write('wire rst_n;\n')
        testbed.write('wire [{}:0] SEL;\n'.format(SEL_BIT-1))
        for i in range(ADC_NUM):
            testbed.write('wire signed [{}:0] IN_LUT_{};\n'.format(LUT_BIT-1,i))
        for i in range(ARRAY_SIZE):
            testbed.write('wire signed [{}:0] IN_BUF_{};\n'.format(BUF_BIT-1,i))
        for i in range(ARRAY_SIZE):
            testbed.write('wire signed [{}:0] OUT_BUF_{};\n'.format(BUF_BIT-1,i))

        testbed.write('\n')

        testbed.write('PATTERN I_PATTERN\n')
        testbed.write('(\n')
        testbed.write('\t.clk(clk),\n')
        testbed.write('\t.rst_n(rst_n),\n')
        testbed.write('\t.SEL(SEL),\n')
        for i in range(ADC_NUM):
            testbed.write('\t.IN_LUT_{}(IN_LUT_{}),\n'.format(i,i))
        for i in range(ARRAY_SIZE):
            testbed.write('\t.IN_BUF_{}(IN_BUF_{}),\n'.format(i,i))
        for i in range(ARRAY_SIZE):
            if i!=ARRAY_SIZE-1:
                testbed.write('\t.OUT_BUF_{}(OUT_BUF_{}),\n'.format(i,i))
            else:
                testbed.write('\t.OUT_BUF_{}(OUT_BUF_{})\n'.format(i,i))
        testbed.write(');\n')

        testbed.write('\n')

        testbed.write('S_AND_A I_S_AND_A\n')
        testbed.write('(\n')
        testbed.write('\t.clk(clk),\n')
        testbed.write('\t.rst_n(rst_n),\n')
        testbed.write('\t.SEL(SEL),\n')
        for i in range(ADC_NUM):
            testbed.write('\t.IN_LUT_{}(IN_LUT_{}),\n'.format(i,i))
        for i in range(ARRAY_SIZE):
            testbed.write('\t.IN_BUF_{}(IN_BUF_{}),\n'.format(i,i))
        for i in range(ARRAY_SIZE):
            if i!=ARRAY_SIZE-1:
                testbed.write('\t.OUT_BUF_{}(OUT_BUF_{}),\n'.format(i,i))
            else:
                testbed.write('\t.OUT_BUF_{}(OUT_BUF_{})\n'.format(i,i))
        testbed.write(');\n')

        testbed.write('\n')

        testbed.write('initial begin\n')
        testbed.write('\t`ifdef RTL\n')
        testbed.write('\t\t$fsdbDumpfile("S_AND_A.fsdb");\n')
        testbed.write('\t\t$fsdbDumpvars(0,"+mda");\n')
        testbed.write('\t`elsif GATE\n')
        testbed.write('\t\t$fsdbDumpfile("S_AND_A_SYN.fsdb");\n')
        testbed.write('\t\t$sdf_annotate("S_AND_A_SYN.sdf",I_S_AND_A);\n')
        testbed.write('\t\t$fsdbDumpvars(0,"+mda");\n')
        testbed.write('\t`endif\n')
        testbed.write('end\n')

        testbed.write('\n')
        testbed.write('endmodule\n')




if __name__=='__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--A_BIT',      type=int, default=8,   help='Presiscion of activation')
    parser.add_argument('--W_BIT',      type=int, default=5,   help='Presiscion of weight')
    parser.add_argument('--DAC_BIT',    type=int, default=2,   help='Presiscion of DAC')
    parser.add_argument('--ADC_NUM',    type=int, default=8,   help='Number of ADC used in one array')
    parser.add_argument('--ADC_BIT',    type=int, default=8,   help='Presiscion of DAC')
    parser.add_argument('--ARRAY_SIZE', type=int, default=256,  help='Size of array')
    parser.add_argument('--CYCLE',      type=int, default=2.5,   help='Period of one cycle')
    parser.add_argument('--PATNUM',     type=int, default=5, help='Period of one cycle')
    opt = parser.parse_args()

    print('Configuration {}'.format(opt.ARRAY_SIZE))

    write_design(A_BIT=opt.A_BIT, W_BIT=opt.W_BIT, DAC_BIT=opt.DAC_BIT, ARRAY_SIZE=opt.ARRAY_SIZE, ADC_NUM=opt.ADC_NUM, ADC_BIT=opt.ADC_BIT)
    write_pattern(A_BIT=opt.A_BIT, W_BIT=opt.W_BIT, DAC_BIT=opt.DAC_BIT, ARRAY_SIZE=opt.ARRAY_SIZE, ADC_NUM=opt.ADC_NUM, ADC_BIT=opt.ADC_BIT, CYCLE=opt.CYCLE, PATNUM=opt.PATNUM)
    write_testbed(A_BIT=opt.A_BIT, W_BIT=opt.W_BIT, DAC_BIT=opt.DAC_BIT, ARRAY_SIZE=opt.ARRAY_SIZE, ADC_NUM=opt.ADC_NUM, ADC_BIT=opt.ADC_BIT)
