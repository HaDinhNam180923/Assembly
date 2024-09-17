.data
	data: .word 0 : 256       
.text
       	li $t0 ,16
	li $t1, 0 #column
	li $t2, 0 #row
	li $t3, 0
	li $s1, 0
	li $s2, 0
For1:
	beq $t1, $t0, Exit #duyệt đến cột thứ 16
	sll $s2,$t1,2 #
	addi $t1, $t1,1
	add $t2, $zero, $zero
	For2:
	beq $t2, $t0,For1
	mult $t2,$t0
	mflo $s1
	sll $s1,$s1,2
	add $s1, $s2, $s1
	sw $t3, data($s1)
	addi $t3,$t3,1
	addi $t2, $t2, 1
	j For2
Exit:
	li $v0, 10
	syscall
