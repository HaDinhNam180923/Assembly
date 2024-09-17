.data
y: .word
.text
la $t0, y 
addi $t1, $t0, 0
hehe:
li $v0, 5
syscall
addi $s0, $v0, 0
sw $s0, 0($t1)
addi $t1, $t1, 4
j hehe
end: