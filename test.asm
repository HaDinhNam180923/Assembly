.data
x: .asciiz "True"
x1: .asciiz "False"
x2: .asciiz "Nhap so nguyen co so chu so la chan:"
youtube: .word 

.text
main:

la $s6, youtube  
addi $s7, $s6, 0 

li $v0, 51
la $a0, x2
syscall
move $a1, $a0
li $s1,10
li $t0, 0   
li $a2, 4  
li $t2, 2
j anh1
anh1:
div $a1, $s1
mfhi $s2
sw $s2, 0($s7)
addi $s7, $s7, 4
mflo $s3
sub $t1, $a1, $s2
div $t1, $s1
mflo $a1
addi $t0, $t0, 1
j anh2

anh3:
sub $a0, $s7, $s6
div $a0, $a2
mflo $a3
div $a3, $t2
mflo $a3
add $a3, $a3, $a3
add $a3, $a3, $a3
add $a3, $a3, $s6 #dia chi phan tu thu n/2+1

anh4:
lw $t3, 0($s6)
add $t4, $t3, $t4
addi $s6, $s6, 4
beq $s6, $a3, anh5
j anh4

anh5:
lw $t3, 0($s6)
sub $t4, $t4, $t3
addi $s6, $s6, 4
beq $s6, $s7, anh6
j anh5

anh6:
beqz $t4, true
li $v0, 55
la $a0, x1
syscall

j exit
true:
li $v0, 55
la $a0, x
syscall

exit:
li $v0,10
syscall


anh2:
bne $a1,$zero,anh1
j anh3


