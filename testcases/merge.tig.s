L162
jal readlist
addi 71, r0, 4
sub 70, FP, 71
add 65, 70, r0
jal getchar
add 64, 72, r0
sw 65, 0(64)
addi 73, r0, 0
add 63, 73, r0
jal readlist
add 62, 74, r0
addi 76, r0, 4
sub 75, FP, 76
add 67, 75, r0
jal getchar
add 66, 77, r0
sw 67, 0(66)
add 69, FP, r0
jal merge
add 68, 78, r0
jal printlist
L161
j 79L161
L164
addi 80, r0, 0
blt60, 80, L158L159
addi 82, 60, 4
lw 81, 0(82)jal printlist
L157
jal print
addi 86, 60, 0
lw 85, 0(86)jal printint
add 61, 84, r0
L160
addi 87, r0, 0
add RV, 87, r0
L163
j 88L158
L156
jal print
add 61, 89, r0
L160
j 91L163
L157: .asciiz "" ""
L156: .asciiz ""\n""
L166
addi 92, r0, 0
blt54, 92, L153L154
addi 93, r0, 0
blt54, 93, L150L151
L149
jal print
add 58, 94, r0
L152
addi 96, r0, 0
add 59, 96, r0
L155
addi 97, r0, 0
add RV, 97, r0
L165
j 98L153
addi 100, r0, 0
sub 99, 100, 54
jal f
L148
jal print
add 59, 101, r0
L155
j 103L150
jal f
add 58, 104, r0
L152
j 105L165
L149: .asciiz ""0""
L148: .asciiz ""-""
L168
addi 109, r0, 0
blt56, 109, L146L147
addi 110, r0, 0
add RV, 110, r0
L167
j 111L146
addi 115, r0, 10
div 56, 115
mflo 114
addi 116, r0, 10
mul 113, 114, 116
sub 112, 56, 113
add 108, 112, r0
L145
jal ord
add 107, 117, r0
add 120, 108, 's1
jal chr
add 106, 119, r0
jal print
addi 123, r0, 10
div 56, 123
mflo 122
jal f
add 57, 121, r0
L147
j 124L167
L145: .asciiz ""0""
L170
addi 129, r0, 0
blt47, 129, L142L143
addi 130, r0, 0
blt48, 130, L139L140
addi 132, 47, 0
lw 131, 0(132)addi 134, 48, 0
lw 133, 0(134)blt131, 133, L136L137
addi 136, r0, 8
jal allocRecord
add 50, 135, r0
addi 137, 50, 0
addi 139, 48, 0
lw 138, 0(139)sw 137, 0(138)
addi 140, 50, 4
add 128, 140, r0
addi 143, 48, 4
lw 142, 0(143)jal merge
add 127, 141, r0
sw 128, 0(127)
add 51, 50, r0
L138
addi 144, r0, 0
add 52, 144, r0
L141
addi 145, r0, 0
add 53, 145, r0
L144
addi 146, r0, 0
add RV, 146, r0
L169
j 147L142
add 53, 48, r0
L144
j 148L139
add 52, 47, r0
L141
j 149L136
addi 151, r0, 8
jal allocRecord
add 49, 150, r0
addi 152, 49, 0
addi 154, 47, 0
lw 153, 0(154)sw 152, 0(153)
addi 155, 49, 4
add 126, 155, r0
addi 158, 47, 4
lw 157, 0(158)jal merge
add 125, 156, r0
sw 126, 0(125)
add 51, 49, r0
L138
j 159L169
L172
jal readint
add 44, 162, r0
addi 164, r0, 4
jal allocRecord
add 42, 163, r0
addi 165, 42, 0
addi 166, r0, 0
sw 165, 0(166)
add 43, 42, r0
addi 168, 43, 0
lw 167, 0(168)addi 169, r0, 0
bne167, 169, L133L134
addi 170, r0, 0
add 46, 170, r0
L135
addi 171, r0, 0
add RV, 171, r0
L171
j 172L133
addi 174, r0, 8
jal allocRecord
add 45, 173, r0
addi 175, 45, 0
sw 175, 0(44)
addi 176, 45, 4
add 161, 176, r0
jal readlist
add 160, 177, r0
sw 161, 0(160)
add 46, 45, r0
L135
j 178L171
L174
addi 188, r0, 0
add 29, 188, r0
L131
addi 192, r0, 4
sub 191, FP, 192
lw 190, 0(191)jal isdigit
add 185, 189, r0
addi 193, r0, 0
bne185, 193, L132L129
addi 194, 28, 0
add 187, 194, r0
addi 198, r0, 4
sub 197, FP, 198
lw 196, 0(197)jal isdigit
add 186, 195, r0
sw 187, 0(186)
jal skipto
add RV, 199, r0
L173
j 200L132
addi 202, r0, 4
sub 201, FP, 202
add 180, 201, r0
jal getchar
add 179, 203, r0
sw 180, 0(179)
addi 205, r0, 10
mul 204, 29, 205
add 182, 204, r0
addi 209, r0, 4
sub 208, FP, 209
lw 207, 0(208)jal ord
add 181, 206, r0
add 210, 182, 's1
add 184, 210, r0
L130
jal ord
add 183, 211, r0
sub 213, 184, 183
add 29, 213, r0
addi 214, r0, 0
add 37, 214, r0
L131
j 215L173
L130: .asciiz ""0""
L176
L127
addi 223, r0, 4
sub 222, FP, 223
lw 221, 0(222)L121
jal stringCompare
add 218, 220, r0
addi 225, r0, 0
bne218, 225, L122L123
addi 226, r0, 1
add 35, 226, r0
addi 230, r0, 4
sub 229, FP, 230
lw 228, 0(229)L120
jal stringCompare
add 219, 227, r0
addi 232, r0, 0
bne219, 232, L125L126
addi 233, r0, 0
add 35, 233, r0
L125
add 34, 35, r0
L124
addi 234, r0, 0
addi 235, r0, 0
bne234, 235, L128L119
addi 236, r0, 0
add RV, 236, r0
L175
j 237L128
addi 239, r0, 4
sub 238, FP, 239
add 217, 238, r0
jal getchar
add 216, 240, r0
sw 217, 0(216)
addi 241, r0, 0
add 36, 241, r0
L127
j 242L122
addi 243, r0, 1
add 34, 243, r0
L124
j 244L175
L121: .asciiz "" ""
L120: .asciiz ""\n""
L178
addi 254, r0, 4
sub 253, FP, 254
lw 252, 0(253)jal ord
add 245, 251, r0
add 247, 245, r0
L113
jal ord
add 246, 255, r0
blt247, 246, L114L115
addi 257, r0, 0
add 32, 257, r0
L116
addi 258, r0, 0
add RV, 258, r0
L177
j 259L114
addi 260, r0, 1
add 33, 260, r0
addi 264, r0, 4
sub 263, FP, 264
lw 262, 0(263)jal ord
add 248, 261, r0
add 250, 248, r0
L112
jal ord
add 249, 265, r0
blt250, 249, L117L118
addi 267, r0, 0
add 33, 267, r0
L117
add 32, 33, r0
L116
j 268L177
L113: .asciiz ""0""
L112: .asciiz ""9""
