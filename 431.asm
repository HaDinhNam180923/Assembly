.text
li $s1, -2
li $s0, 0

slt $t1, $s1, $zero    # neu $s1 <0 thì $t1=1 
addu $s0, $s1,$zero
bne $t1, $zero, Abs
Abs: subu $s0, $zero, $s1  