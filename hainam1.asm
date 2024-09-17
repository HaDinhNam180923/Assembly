.data
X: .asciiz " "
.text 
li $v0, 5
syscall
move $s0, $v0
li $s1, 5
li $s2, 7
li $s3, 5
li $s4, 7
hainam1:
addi $a0, $s3, 0
li $v0, 1
syscall
la $a0, X
li $v0, 4
syscall
addi $s3, $s3, 5
slt $t1, $s3, $s0
beq $t1, $zero, end_hainam1
j hainam1
end_hainam1:

hainam2:
addi $a0, $s4, 0
div $s4, $s1
mfhi $t0
beqz $t0, hailam
li $v0, 1
syscall
la $a0, X
li $v0, 4
syscall
hailam:
addi $s4, $s4, 7
slt $t1, $s4, $s0
beq $t1, $zero, end
j hainam2
end_hainam2:
end: