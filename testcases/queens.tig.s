L144
addi 57, r0, 20
sub 56, FP, 57
add 52, 56, r0
addi 63, r0, 4
sub 62, FP, 63
lw 61, 0(62)addi 66, r0, 4
sub 65, FP, 66
lw 64, 0(65)add 60, 61, 's1
addi 67, r0, 1
sub 59, 60, 67
addi 68, r0, 0
jal initArray
add 30, 58, r0
sw 52, 0(30)
addi 70, r0, 16
sub 69, FP, 70
add 53, 69, r0
addi 76, r0, 4
sub 75, FP, 76
lw 74, 0(75)addi 79, r0, 4
sub 78, FP, 79
lw 77, 0(78)add 73, 74, 's1
addi 80, r0, 1
sub 72, 73, 80
addi 81, r0, 0
jal initArray
add 29, 71, r0
sw 53, 0(29)
addi 83, r0, 12
sub 82, FP, 83
add 54, 82, r0
addi 87, r0, 4
sub 86, FP, 87
lw 85, 0(86)addi 88, r0, 0
jal initArray
add 28, 84, r0
sw 54, 0(28)
addi 90, r0, 8
sub 89, FP, 90
add 55, 89, r0
addi 94, r0, 4
sub 93, FP, 94
lw 92, 0(93)addi 95, r0, 0
jal initArray
add 27, 91, r0
sw 55, 0(27)
addi 97, r0, 4
sub 96, FP, 97
addi 98, r0, 8
sw 96, 0(98)
addi 99, r0, 0
jal try
L143
j 100L143
L146
addi 103, r0, 4
sub 102, FP, 103
lw 101, 0(102)blt41, 101, L140L141
addi 104, r0, 0
add 48, 104, r0
addi 108, r0, 4
sub 107, FP, 108
lw 106, 0(107)addi 109, r0, 1
sub 105, 106, 109
add 49, 105, r0
L138
blt48, 49, L139L125
addi 110, r0, 0
add 51, 110, r0
L142
addi 111, r0, 0
add RV, 111, r0
L145
j 112L140
jal printboard
add 51, 113, r0
L142
j 114L147
addi 119, r0, 8
sub 118, FP, 119
lw 117, 0(118)addi 121, r0, 4
mul 120, 42, 121
add 116, 117, 's1
lw 115, 0(116)addi 122, r0, 0
blt115, 122, L126L127
addi 123, r0, 0
add 43, 123, r0
L128
addi 124, r0, 0
addi 125, r0, 0
bne124, 125, L131L132
addi 126, r0, 0
add 45, 126, r0
L133
addi 127, r0, 0
addi 128, r0, 0
bne127, 128, L136L137
addi 129, r0, 0
add 50, 129, r0
L138
j 130L126
addi 131, r0, 1
add 44, 131, r0
addi 136, r0, 16
sub 135, FP, 136
lw 134, 0(135)add 138, 42, 's1
addi 139, r0, 4
mul 137, 138, 139
add 133, 134, 's1
lw 132, 0(133)addi 140, r0, 0
blt132, 140, L129L130
addi 141, r0, 0
add 44, 141, r0
L129
add 43, 44, r0
L128
j 142L131
addi 143, r0, 1
add 46, 143, r0
addi 148, r0, 20
sub 147, FP, 148
lw 146, 0(147)addi 151, 42, 7
sub 150, 151, 41
addi 152, r0, 4
mul 149, 150, 152
add 145, 146, 's1
lw 144, 0(145)addi 153, r0, 0
blt144, 153, L134L135
addi 154, r0, 0
add 46, 154, r0
L134
add 45, 46, r0
L133
j 155L136
addi 159, r0, 20
sub 158, FP, 159
lw 157, 0(158)addi 162, 42, 7
sub 161, 162, 41
addi 163, r0, 4
mul 160, 161, 163
add 156, 157, 's1
addi 164, r0, 0
sw 156, 0(164)
addi 168, r0, 16
sub 167, FP, 168
lw 166, 0(167)add 170, 42, 's1
addi 171, r0, 4
mul 169, 170, 171
add 165, 166, 's1
addi 172, r0, 0
sw 165, 0(172)
addi 176, r0, 8
sub 175, FP, 176
lw 174, 0(175)addi 178, r0, 4
mul 177, 42, 178
add 173, 174, 's1
addi 179, r0, 0
sw 173, 0(179)
addi 180, 41, 1
jal try
addi 184, r0, 12
sub 183, FP, 184
lw 182, 0(183)addi 186, r0, 4
mul 185, 41, 186
add 181, 182, 's1
sw 181, 0(42)
addi 190, r0, 20
sub 189, FP, 190
lw 188, 0(189)addi 193, 42, 7
sub 192, 193, 41
addi 194, r0, 4
mul 191, 192, 194
add 187, 188, 's1
addi 195, r0, 1
sw 187, 0(195)
addi 199, r0, 16
sub 198, FP, 199
lw 197, 0(198)add 201, 42, 's1
addi 202, r0, 4
mul 200, 201, 202
add 196, 197, 's1
addi 203, r0, 1
sw 196, 0(203)
addi 207, r0, 8
sub 206, FP, 207
lw 205, 0(206)addi 209, r0, 4
mul 208, 42, 209
add 204, 205, 's1
addi 210, r0, 1
sw 204, 0(210)
addi 211, r0, 0
add 47, 211, r0
L137
j 212L145
L149
L124
jal print
addi 214, r0, 0
add 38, 214, r0
addi 218, r0, 4
sub 217, FP, 218
lw 216, 0(217)addi 219, r0, 1
sub 215, 216, 219
add 39, 215, r0
L122
blt38, 39, L123L112
addi 220, r0, 0
add RV, 220, r0
L148
j 221L150
L121
jal print
addi 223, r0, 0
add 35, 223, r0
addi 227, r0, 4
sub 226, FP, 227
lw 225, 0(226)addi 228, r0, 1
sub 224, 225, 228
add 36, 224, r0
L119
blt35, 36, L120L113
addi 229, r0, 0
add 40, 229, r0
L122
j 230L151
addi 235, r0, 12
sub 234, FP, 235
lw 233, 0(234)addi 237, r0, 4
mul 236, 32, 237
add 232, 233, 's1
lw 231, 0(232)blt231, 33, L116L117
L115
add 34, 238, r0
L118
addi 240, r0, 0
jal print
add 37, 239, r0
L119
j 241L116
L114
add 34, 242, r0
L118
j 243L148
L124: .asciiz ""\n""
L121: .asciiz ""\n""
L115: .asciiz "" .""
L114: .asciiz "" O""