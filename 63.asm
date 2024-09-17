.data
A: .word 1, 8, 9, 2, 3
Aend: .word
.text
main: 
      la $a0, A
      la $a1, Aend
      addi $t2, $a0, 0
      addi $v0, $a0, -4
      addi $a1, $a1, -4
      addi $t3, $a1, -4
      addi $a0, $a0, -4
      j sort
after_sort: li $v0, 10
            syscall
end_main:
sort: beq $a0, $t3, after_sort
      j hehe
hehe:
      addi $a0, $a0, 4#i
      addi $v0, $t2, -4
      j hoho
hoho: 
      addi $v0, $v0, 4#j
      lw $s0, 0($v0)
      addi $v1, $v0, 4#j+1
      lw $s1, 0($v1)
      slt $t1, $s1, $s0
      bne $t1, $zero, haha
      j kaka
kaka: sub $a2, $a1, $a0
      add $a3, $t2, $a2
      addi $a3, $a3, -4
      beq $v0, $a3, sort
      j hoho
haha: 
      sw $s1, 0($v0)
      sw $s0, 0($v1)
      j kaka
      
      
      
      
      