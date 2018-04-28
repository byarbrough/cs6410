sw $17,-8($0)
sw $18,-12($0)
sw $19,-16($0)
sw $20,-20($0)
sw $21,-24($0)
sw $22,-28($0)
sw $23,-32($0)
L129:
addi $56, $0, 5
move $28, $56
addi $57, $0, 1
move $27, $57
jal L112
addi $58, $0, 1
move $53, $58
move $54, $28
L126:
blt $53, $54, L127
L125:
la $59, L128
j $59
L130:
mul $60, $27, $52
move $27, $60
addi $61, $0, 0
move $55, $61
la $62, L126
j $62
L128:
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
L132:
addi $64, $0, 4
sub $63, $fp, $64
sw $63, 0($5)
move $43, $ra
move $44, $19
move $45, $20
move $46, $21
move $47, $22
move $48, $23
move $49, $24
move $50, $25
move $51, $26
addi $65, $0, 0
blt $29, $65, L122
L123:
addi $66, $0, 0
blt $29, $66, L119
L120:
la $68, L118
move $ra, $68
jal L101
move $41, $67
L121:
addi $69, $0, 0
move $42, $69
L124:
move $ra, $43
move $19, $44
move $20, $45
move $21, $46
move $22, $47
move $23, $48
move $24, $49
move $25, $50
move $26, $51
addi $70, $0, 0
move $rv, $70
la $71, L131
j $71
L122:
addi $73, $0, 0
sub $72, $73, $29
jal L113
la $75, L117
move $ra, $75
jal L101
move $42, $74
la $76, L124
j $76
L119:
move $ra, $fp
jal L113
move $41, $77
la $78, L121
j $78
L131:
lw $16,-4($0)
lw $17,-8($0)
lw $18,-12($0)
lw $19,-16($0)
lw $20,-20($0)
lw $21,-24($0)
lw $22,-28($0)
lw $23,-32($0)
L118: .asciiz "0"
L117: .asciiz "-"
sw $17,-8($0)
sw $18,-12($0)
sw $19,-16($0)
sw $20,-20($0)
sw $21,-24($0)
sw $22,-28($0)
sw $23,-32($0)
L134:
addi $83, $0, 4
sub $82, $fp, $83
sw $82, 0($5)
move $32, $ra
move $33, $19
move $34, $20
move $35, $21
move $36, $22
move $37, $23
move $38, $24
move $39, $25
move $40, $26
addi $84, $0, 0
blt $30, $84, L115
L116:
move $ra, $32
move $19, $33
move $20, $34
move $21, $35
move $22, $36
move $23, $37
move $24, $38
move $25, $39
move $26, $40
addi $85, $0, 0
move $rv, $85
la $86, L133
j $86
L115:
addi $90, $0, 10
div $30, $90
mflo $89
addi $91, $0, 10
mul $88, $89, $91
sub $87, $30, $88
move $81, $87
la $93, L114
move $ra, $93
jal L104
move $80, $92
add $95, $81, $80
move $ra, $95
jal L105
move $79, $94
jal L101
addi $98, $0, 10
div $30, $98
mflo $97
move $ra, $fp
jal L113
move $31, $96
la $99, L116
j $99
L133:
lw $16,-4($0)
lw $17,-8($0)
lw $18,-12($0)
lw $19,-16($0)
lw $20,-20($0)
lw $21,-24($0)
lw $22,-28($0)
lw $23,-32($0)
L114: .asciiz "0"
