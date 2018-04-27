sw $17,-8($0)
sw $18,-12($0)
sw $19,-16($0)
sw $20,-20($0)
sw $21,-24($0)
sw $22,-28($0)
sw $23,-32($0)
L146
addi 74, r0, 20
sub 73, fp, 74
move 69, 73, r0
addi 80, r0, 4
sub 79, fp, 80
la 78, 0(79)
addi 83, r0, 4
sub 82, fp, 83
la 81, 0(82)
add 77, 78, 81
addi 84, r0, 1
sub 76, 77, 84
addi 85, r0, 0
jal initArray
move 30, 75, r0
sw 69, 0(30)
addi 87, r0, 16
sub 86, fp, 87
move 70, 86, r0
addi 93, r0, 4
sub 92, fp, 93
la 91, 0(92)
addi 96, r0, 4
sub 95, fp, 96
la 94, 0(95)
add 90, 91, 94
addi 97, r0, 1
sub 89, 90, 97
addi 98, r0, 0
jal initArray
move 29, 88, r0
sw 70, 0(29)
addi 100, r0, 12
sub 99, fp, 100
move 71, 99, r0
addi 104, r0, 4
sub 103, fp, 104
la 102, 0(103)
addi 105, r0, 0
jal initArray
move 28, 101, r0
sw 71, 0(28)
addi 107, r0, 8
sub 106, fp, 107
move 72, 106, r0
addi 111, r0, 4
sub 110, fp, 111
la 109, 0(110)
addi 112, r0, 0
jal initArray
move 27, 108, r0
sw 72, 0(27)
addi 114, r0, 4
sub 113, fp, 114
addi 115, r0, 8
sw 113, 0(115)
addi 116, r0, 0
jal L113
lw 117, L145
j 117
L145
lw $16,-4($0)
lw $17,-8($0)
lw $18,-12($0)
lw $19,-16($0)
lw $20,-20($0)
lw $21,-24($0)
lw $22,-28($0)
lw $23,-32($0)
sw $17,-8($0)
sw $18,-12($0)
sw $19,-16($0)
sw $20,-20($0)
sw $21,-24($0)
sw $22,-28($0)
sw $23,-32($0)
L148
addi 119, r0, 4
sub 118, fp, 119
sw 118, 0(5)
move 60, ra, r0
move 61, 19, r0
move 62, 20, r0
move 63, 21, r0
move 64, 22, r0
move 65, 23, r0
move 66, 24, r0
move 67, 25, r0
move 68, 26, r0
addi 122, r0, 4
sub 121, fp, 122
la 120, 0(121)
blt 49, 120, L142
L143
addi 123, r0, 0
move 56, 123, r0
addi 127, r0, 4
sub 126, fp, 127
la 125, 0(126)
addi 128, r0, 1
sub 124, 125, 128
move 57, 124, r0
L140
blt 56, 57, L141
L127
addi 129, r0, 0
move 59, 129, r0
L144
move ra, 60, r0
move 19, 61, r0
move 20, 62, r0
move 21, 63, r0
move 22, 64, r0
move 23, 65, r0
move 24, 66, r0
move 25, 67, r0
move 26, 68, r0
addi 130, r0, 0
move rv, 130, r0
lw 131, L147
j 131
L142
jal L112
move 59, 132, r0
lw 133, L144
j 133
L149
addi 138, r0, 8
sub 137, fp, 138
la 136, 0(137)
addi 140, r0, 4
mul 139, 50, 140
add 135, 136, 139
la 134, 0(135)
addi 141, r0, 0
blt 134, 141, L128
L129
addi 142, r0, 0
move 51, 142, r0
L130
addi 143, r0, 0
addi 144, r0, 0
bne 143, 144, L133
L134
addi 145, r0, 0
move 53, 145, r0
L135
addi 146, r0, 0
addi 147, r0, 0
bne 146, 147, L138
L139
addi 148, r0, 0
move 58, 148, r0
lw 149, L140
j 149
L128
addi 150, r0, 1
move 52, 150, r0
addi 155, r0, 16
sub 154, fp, 155
la 153, 0(154)
add 157, 50, 49
addi 158, r0, 4
mul 156, 157, 158
add 152, 153, 156
la 151, 0(152)
addi 159, r0, 0
blt 151, 159, L131
L132
addi 160, r0, 0
move 52, 160, r0
L131
move 51, 52, r0
lw 161, L130
j 161
L133
addi 162, r0, 1
move 54, 162, r0
addi 167, r0, 20
sub 166, fp, 167
la 165, 0(166)
addi 170, 50, 7
sub 169, 170, 49
addi 171, r0, 4
mul 168, 169, 171
add 164, 165, 168
la 163, 0(164)
addi 172, r0, 0
blt 163, 172, L136
L137
addi 173, r0, 0
move 54, 173, r0
L136
move 53, 54, r0
lw 174, L135
j 174
L138
addi 178, r0, 20
sub 177, fp, 178
la 176, 0(177)
addi 181, 50, 7
sub 180, 181, 49
addi 182, r0, 4
mul 179, 180, 182
add 175, 176, 179
addi 183, r0, 0
sw 175, 0(183)
addi 187, r0, 16
sub 186, fp, 187
la 185, 0(186)
add 189, 50, 49
addi 190, r0, 4
mul 188, 189, 190
add 184, 185, 188
addi 191, r0, 0
sw 184, 0(191)
addi 195, r0, 8
sub 194, fp, 195
la 193, 0(194)
addi 197, r0, 4
mul 196, 50, 197
add 192, 193, 196
addi 198, r0, 0
sw 192, 0(198)
addi 199, 49, 1
jal L113
addi 203, r0, 12
sub 202, fp, 203
la 201, 0(202)
addi 205, r0, 4
mul 204, 49, 205
add 200, 201, 204
sw 200, 0(50)
addi 209, r0, 20
sub 208, fp, 209
la 207, 0(208)
addi 212, 50, 7
sub 211, 212, 49
addi 213, r0, 4
mul 210, 211, 213
add 206, 207, 210
addi 214, r0, 1
sw 206, 0(214)
addi 218, r0, 16
sub 217, fp, 218
la 216, 0(217)
add 220, 50, 49
addi 221, r0, 4
mul 219, 220, 221
add 215, 216, 219
addi 222, r0, 1
sw 215, 0(222)
addi 226, r0, 8
sub 225, fp, 226
la 224, 0(225)
addi 228, r0, 4
mul 227, 50, 228
add 223, 224, 227
addi 229, r0, 1
sw 223, 0(229)
addi 230, r0, 0
move 55, 230, r0
lw 231, L139
j 231
L147
lw $16,-4($0)
lw $17,-8($0)
lw $18,-12($0)
lw $19,-16($0)
lw $20,-20($0)
lw $21,-24($0)
lw $22,-28($0)
lw $23,-32($0)
sw $17,-8($0)
sw $18,-12($0)
sw $19,-16($0)
sw $20,-20($0)
sw $21,-24($0)
sw $22,-28($0)
sw $23,-32($0)
L151
addi 233, r0, 4
sub 232, fp, 233
sw 232, 0(5)
move 40, ra, r0
move 41, 19, r0
move 42, 20, r0
move 43, 21, r0
move 44, 22, r0
move 45, 23, r0
move 46, 24, r0
move 47, 25, r0
move 48, 26, r0
lw 234, L126
jal L101
addi 235, r0, 0
move 37, 235, r0
addi 239, r0, 4
sub 238, fp, 239
la 237, 0(238)
addi 240, r0, 1
sub 236, 237, 240
move 38, 236, r0
L124
blt 37, 38, L125
L114
move ra, 40, r0
move 19, 41, r0
move 20, 42, r0
move 21, 43, r0
move 22, 44, r0
move 23, 45, r0
move 24, 46, r0
move 25, 47, r0
move 26, 48, r0
addi 241, r0, 0
move rv, 241, r0
lw 242, L150
j 242
L152
lw 243, L123
jal L101
addi 244, r0, 0
move 34, 244, r0
addi 248, r0, 4
sub 247, fp, 248
la 246, 0(247)
addi 249, r0, 1
sub 245, 246, 249
move 35, 245, r0
L121
blt 34, 35, L122
L115
addi 250, r0, 0
move 39, 250, r0
lw 251, L124
j 251
L153
addi 256, r0, 12
sub 255, fp, 256
la 254, 0(255)
addi 258, r0, 4
mul 257, 31, 258
add 253, 254, 257
la 252, 0(253)
blt 252, 32, L118
L119
lw 259, L117
move 33, 259, r0
L120
addi 261, r0, 0
jal L101
move 36, 260, r0
lw 262, L121
j 262
L118
lw 263, L116
move 33, 263, r0
lw 264, L120
j 264
L150
lw $16,-4($0)
lw $17,-8($0)
lw $18,-12($0)
lw $19,-16($0)
lw $20,-20($0)
lw $21,-24($0)
lw $22,-28($0)
lw $23,-32($0)
L126: .asciiz "\n"
L123: .asciiz "\n"
L117: .asciiz " ."
L116: .asciiz " O"
