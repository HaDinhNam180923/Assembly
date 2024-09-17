.data
A: .word 1, 8, 9, 2, 3
Aend: .word
.text
main: 
      la $a0, A
      la $a1, Aend
      addi $v0, $a0, 0
      addi $a1, $a1, -4
      j sort
after_sort: li $v0, 10
            syscall
end_main:

sort: beq $a0, $a1, after_sort
      j hehe
hehe: 
      addi $a0, $a0, 4 #i
      lw $s0, 0($a0)#key
      addi $t0, $a0, -4#j=i-1
keke: slt $t1, $t0, $v0
      beq $t1, $zero, hoho
      j haha
hoho: 
      lw $s1, 0($t0)
      slt $t2, $s0, $s1
      beq $t2, $zero, haha
      addi $v1, $t0, 4
      sw $s1, 0($v1)
      addi $t0, $t0, -4
      j keke
haha: addi $t0, $t0, 4
      sw $s0, 0($t0)
      j sort
      
      

