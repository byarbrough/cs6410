L162
jal readlist
addi 136, r0, 4
sub 135, fp, 136
add 130, 135, r0
jal getchar
add 129, 137, r0
sw 130, 0(129)
addi 138, r0, 0
add 128, 138, r0
jal readlist
add 127, 139, r0
addi 141, r0, 4
sub 140, fp, 141
add 132, 140, r0
jal getchar
add 131, 142, r0
sw 132, 0(131)
add 134, fp, r0
jal merge
add 133, 143, r0
jal printlist
lw 144, L161
j 144
L161
L164
addi 146, r0, 4
sub 145, fp, 146
sw 145, 0(5)
add 118, ra, r0
add 119, 19, r0
add 120, 20, r0
add 121, 21, r0
add 122, 22, r0
add 123, 23, r0
add 124, 24, r0
add 125, 25, r0
add 126, 26, r0
addi 147, r0, 0
blt 116, 147, L158
L159
addi 149, 116, 4
la 148, 0(149)
jal printlist
lw 150, L157
jal print
addi 153, 116, 0
la 152, 0(153)
jal printint
add 117, 151, r0
L160
add ra, 118, r0
add 19, 119, r0
add 20, 120, r0
add 21, 121, r0
add 22, 122, r0
add 23, 123, r0
add 24, 124, r0
add 25, 125, r0
add 26, 126, r0
addi 154, r0, 0
add rv, 154, r0
lw 155, L163
j 155
L158
lw 157, L156
jal print
add 117, 156, r0
lw 158, L160
j 158
L163
L157: .asciiz " "
L156: .asciiz "\n"
L166
addi 160, r0, 4
sub 159, fp, 160
sw 159, 0(5)
add 107, ra, r0
add 108, 19, r0
add 109, 20, r0
add 110, 21, r0
add 111, 22, r0
add 112, 23, r0
add 113, 24, r0
add 114, 25, r0
add 115, 26, r0
addi 161, r0, 0
blt 93, 161, L153
L154
addi 162, r0, 0
blt 93, 162, L150
L151
lw 164, L149
jal print
add 105, 163, r0
L152
addi 165, r0, 0
add 106, 165, r0
L155
add ra, 107, r0
add 19, 108, r0
add 20, 109, r0
add 21, 110, r0
add 22, 111, r0
add 23, 112, r0
add 24, 113, r0
add 25, 114, r0
add 26, 115, r0
addi 166, r0, 0
add rv, 166, r0
lw 167, L165
j 167
L153
addi 169, r0, 0
sub 168, 169, 93
jal f
lw 171, L148
jal print
add 106, 170, r0
lw 172, L155
j 172
L150
jal f
add 105, 173, r0
lw 174, L152
j 174
L165
L149: .asciiz "0"
L148: .asciiz "-"
L168
addi 179, r0, 4
sub 178, fp, 179
sw 178, 0(5)
add 96, ra, r0
add 97, 19, r0
add 98, 20, r0
add 99, 21, r0
add 100, 22, r0
add 101, 23, r0
add 102, 24, r0
add 103, 25, r0
add 104, 26, r0
addi 180, r0, 0
blt 94, 180, L146
L147
add ra, 96, r0
add 19, 97, r0
add 20, 98, r0
add 21, 99, r0
add 22, 100, r0
add 23, 101, r0
add 24, 102, r0
add 25, 103, r0
add 26, 104, r0
addi 181, r0, 0
add rv, 181, r0
lw 182, L167
j 182
L146
addi 186, r0, 10
div 94, 186
mflo 185
addi 187, r0, 10
mul 184, 185, 187
sub 183, 94, 184
add 177, 183, r0
lw 189, L145
jal ord
add 176, 188, r0
add 191, 177, 176
jal chr
add 175, 190, r0
jal print
addi 194, r0, 10
div 94, 194
mflo 193
jal f
add 95, 192, r0
lw 195, L147
j 195
L167
L145: .asciiz "0"
L170
addi 201, r0, 4
sub 200, fp, 201
sw 200, 0(5)
add 84, ra, r0
add 85, 19, r0
add 86, 20, r0
add 87, 21, r0
add 88, 22, r0
add 89, 23, r0
add 90, 24, r0
add 91, 25, r0
add 92, 26, r0
addi 202, r0, 0
blt 77, 202, L142
L143
addi 203, r0, 0
blt 78, 203, L139
L140
addi 205, 77, 0
la 204, 0(205)
addi 207, 78, 0
la 206, 0(207)
blt 204, 206, L136
L137
addi 209, r0, 8
jal allocRecord
add 80, 208, r0
addi 210, 80, 0
addi 212, 78, 0
la 211, 0(212)
sw 210, 0(211)
addi 213, 80, 4
add 199, 213, r0
addi 216, 78, 4
la 215, 0(216)
jal merge
add 198, 214, r0
sw 199, 0(198)
add 81, 80, r0
L138
addi 217, r0, 0
add 82, 217, r0
L141
addi 218, r0, 0
add 83, 218, r0
L144
add ra, 84, r0
add 19, 85, r0
add 20, 86, r0
add 21, 87, r0
add 22, 88, r0
add 23, 89, r0
add 24, 90, r0
add 25, 91, r0
add 26, 92, r0
addi 219, r0, 0
add rv, 219, r0
lw 220, L169
j 220
L142
add 83, 78, r0
lw 221, L144
j 221
L139
add 82, 77, r0
lw 222, L141
j 222
L136
addi 224, r0, 8
jal allocRecord
add 79, 223, r0
addi 225, 79, 0
addi 227, 77, 0
la 226, 0(227)
sw 225, 0(226)
addi 228, 79, 4
add 197, 228, r0
addi 231, 77, 4
la 230, 0(231)
jal merge
add 196, 229, r0
sw 197, 0(196)
add 81, 79, r0
lw 232, L138
j 232
L169
L172
addi 236, r0, 4
sub 235, fp, 236
sw 235, 0(5)
add 68, ra, r0
add 69, 19, r0
add 70, 20, r0
add 71, 21, r0
add 72, 22, r0
add 73, 23, r0
add 74, 24, r0
add 75, 25, r0
add 76, 26, r0
jal readint
add 65, 237, r0
addi 239, r0, 4
jal allocRecord
add 63, 238, r0
addi 240, 63, 0
addi 241, r0, 0
sw 240, 0(241)
add 64, 63, r0
addi 243, 64, 0
la 242, 0(243)
addi 244, r0, 0
bne 242, 244, L133
L134
addi 245, r0, 0
add 67, 245, r0
L135
add ra, 68, r0
add 19, 69, r0
add 20, 70, r0
add 21, 71, r0
add 22, 72, r0
add 23, 73, r0
add 24, 74, r0
add 25, 75, r0
add 26, 76, r0
addi 246, r0, 0
add rv, 246, r0
lw 247, L171
j 247
L133
addi 249, r0, 8
jal allocRecord
add 66, 248, r0
addi 250, 66, 0
sw 250, 0(65)
addi 251, 66, 4
add 234, 251, r0
jal readlist
add 233, 252, r0
sw 234, 0(233)
add 67, 66, r0
lw 253, L135
j 253
L171
L174
addi 264, r0, 4
sub 263, fp, 264
sw 263, 0(5)
add 54, ra, r0
add 55, 19, r0
add 56, 20, r0
add 57, 21, r0
add 58, 22, r0
add 59, 23, r0
add 60, 24, r0
add 61, 25, r0
add 62, 26, r0
addi 265, r0, 0
add 28, 265, r0
L131
addi 269, r0, 4
sub 268, fp, 269
la 267, 0(268)
jal isdigit
add 260, 266, r0
addi 270, r0, 0
bne 260, 270, L132
L129
addi 271, 27, 0
add 262, 271, r0
addi 275, r0, 4
sub 274, fp, 275
la 273, 0(274)
jal isdigit
add 261, 272, r0
sw 262, 0(261)
jal skipto
add ra, 54, r0
add 19, 55, r0
add 20, 56, r0
add 21, 57, r0
add 22, 58, r0
add 23, 59, r0
add 24, 60, r0
add 25, 61, r0
add 26, 62, r0
addi 276, r0, 0
add rv, 276, r0
lw 277, L173
j 277
L132
addi 279, r0, 4
sub 278, fp, 279
add 255, 278, r0
jal getchar
add 254, 280, r0
sw 255, 0(254)
addi 282, r0, 10
mul 281, 28, 282
add 257, 281, r0
addi 286, r0, 4
sub 285, fp, 286
la 284, 0(285)
jal ord
add 256, 283, r0
add 287, 257, 256
add 259, 287, r0
lw 289, L130
jal ord
add 258, 288, r0
sub 290, 259, 258
add 28, 290, r0
addi 291, r0, 0
add 53, 291, r0
lw 292, L131
j 292
L173
L130: .asciiz "0"
L176
addi 298, r0, 4
sub 297, fp, 298
sw 297, 0(5)
add 44, ra, r0
add 45, 19, r0
add 46, 20, r0
add 47, 21, r0
add 48, 22, r0
add 49, 23, r0
add 50, 24, r0
add 51, 25, r0
add 52, 26, r0
L127
addi 302, r0, 4
sub 301, fp, 302
la 300, 0(301)
lw 303, L121
jal stringCompare
add 295, 299, r0
addi 304, r0, 0
bne 295, 304, L122
L123
addi 305, r0, 1
add 42, 305, r0
addi 309, r0, 4
sub 308, fp, 309
la 307, 0(308)
lw 310, L120
jal stringCompare
add 296, 306, r0
addi 311, r0, 0
bne 296, 311, L125
L126
addi 312, r0, 0
add 42, 312, r0
L125
add 41, 42, r0
L124
addi 313, r0, 0
addi 314, r0, 0
bne 313, 314, L128
L119
add ra, 44, r0
add 19, 45, r0
add 20, 46, r0
add 21, 47, r0
add 22, 48, r0
add 23, 49, r0
add 24, 50, r0
add 25, 51, r0
add 26, 52, r0
addi 315, r0, 0
add rv, 315, r0
lw 316, L175
j 316
L128
addi 318, r0, 4
sub 317, fp, 318
add 294, 317, r0
jal getchar
add 293, 319, r0
sw 294, 0(293)
addi 320, r0, 0
add 43, 320, r0
lw 321, L127
j 321
L122
addi 322, r0, 1
add 41, 322, r0
lw 323, L124
j 323
L175
L121: .asciiz " "
L120: .asciiz "\n"
L178
addi 331, r0, 4
sub 330, fp, 331
sw 330, 0(5)
add 32, ra, r0
add 33, 19, r0
add 34, 20, r0
add 35, 21, r0
add 36, 22, r0
add 37, 23, r0
add 38, 24, r0
add 39, 25, r0
add 40, 26, r0
addi 335, r0, 4
sub 334, fp, 335
la 333, 0(334)
jal ord
add 324, 332, r0
add 326, 324, r0
lw 337, L113
jal ord
add 325, 336, r0
blt 326, 325, L114
L115
addi 338, r0, 0
add 30, 338, r0
L116
add ra, 32, r0
add 19, 33, r0
add 20, 34, r0
add 21, 35, r0
add 22, 36, r0
add 23, 37, r0
add 24, 38, r0
add 25, 39, r0
add 26, 40, r0
addi 339, r0, 0
add rv, 339, r0
lw 340, L177
j 340
L114
addi 341, r0, 1
add 31, 341, r0
addi 345, r0, 4
sub 344, fp, 345
la 343, 0(344)
jal ord
add 327, 342, r0
add 329, 327, r0
lw 347, L112
jal ord
add 328, 346, r0
blt 329, 328, L117
L118
addi 348, r0, 0
add 31, 348, r0
L117
add 30, 31, r0
lw 349, L116
j 349
L177
L113: .asciiz "0"
L112: .asciiz "9"
