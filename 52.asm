.data
test1: .asciiz "The sum of "
test2: .asciiz " and "
test3: .asciiz " is "
.text
 li $s0, 1
 li $s1, 2
 add $s2, $s1, $s0
 
 li $v0, 4
 la $a0, test1
 syscall
 
 li $v0, 1
 move $a0, $s0
 syscall 
 
 li $v0, 4
 la $a0, test2
 syscall 
 
 li $v0, 1
 move $a0, $s1
 syscall 
 
 li $v0, 4
 la $a0, test3
 syscall 
 
 li $v0, 1
 move $a0, $s2
 syscall 
