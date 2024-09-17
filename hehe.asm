.data
A: .word 1, 8, 9, 2, 3
B: .word
.text
main: li $s0, 5 #so phan tu mang A
      la $a0, A
      la $a1, B
