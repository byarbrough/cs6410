L127
addi 40, r0, 5
add 28, 40, r0
addi 41, r0, 1
add 27, 41, r0
jal printint
addi 42, r0, 1
add 37, 42, r0
add 38, 28, r0
L124
blt 37, 38, L125
L123
lw 43, L126
j 43
L128
mul 44, 27, 36
add 27, 44, r0
addi 45, r0, 0
add 39, 45, r0
lw 46, L124
j 46
L126
L130
addi 47, r0, 0
blt 30, 47, L120
L121
addi 48, r0, 0
blt 30, 48, L117
L118
lw 50, L116
jal print
add 34, 49, r0
L119
addi 51, r0, 0
add 35, 51, r0
L122
addi 52, r0, 0
add RV, 52, r0
lw 53, L129
j 53
L120
addi 55, r0, 0
sub 54, 55, 30
jal f
lw 57, L115
jal print
add 35, 56, r0
lw 58, L122
j 58
L117
jal f
add 34, 59, r0
lw 60, L119
j 60
L129
L116: .asciiz ""0""
L115: .asciiz ""-""
L132
addi 64, r0, 0
blt 32, 64, L113
L114
addi 65, r0, 0
add RV, 65, r0
lw 66, L131
j 66
L113
addi 70, r0, 10
div 32, 70
mflo 69
addi 71, r0, 10
mul 68, 69, 71
sub 67, 32, 68
add 63, 67, r0
lw 73, L112
jal ord
add 62, 72, r0
add 75, 63, 's1
jal chr
add 61, 74, r0
jal print
addi 78, r0, 10
div 32, 78
mflo 77
jal f
add 33, 76, r0
lw 79, L114
j 79
L131
L112: .asciiz ""0""
