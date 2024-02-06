 
****************************************
Report : resources
Design : Shift_and_Add
Version: Q-2019.12
Date   : Wed Dec 20 01:09:01 2023
****************************************


Resource Report for this hierarchy in file
        /home/mark/Digital_Circuit/Shift_and_Add/01_RTL/Shift_and_Add.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_2       | DW_mult_uns    | a_width=6  | genblk1[0].U0/mult_92 (Calculate.v:92) |
     |                | b_width=8  |                            |
| sub_x_3        | DW01_sub       | width=14   | genblk1[0].U0/sub_104 (Calculate.v:104) |
| ash_4          | DW_leftsh      | A_width=21 | genblk1[0].U0/sll_109 (Calculate.v:109) |
    |                | SH_width=3 |                            |
| sub_x_5        | DW01_sub       | width=21   | genblk1[0].U0/sub_115 (Calculate.v:115) |
=============================================================================


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| mult_x_2           | DW_mult_uns      | apparch (area)     |                |
|                    |                  | mult_arch: and     |                |
| sub_x_3            | DW01_sub         | apparch (area)     |                |
| ash_4              | DW_leftsh        | astr (area)        |                |
===============================================================================

1
