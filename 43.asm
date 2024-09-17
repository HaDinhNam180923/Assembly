.text
li $s1, -2
li $s2, 1
slt $s3, $s1, $zero
bne $s3, $s2, ABSss
subu $s0, $zero, $s1
j EXIT
ABSss: 
addu $s0, $s1,$zero
EXIT: