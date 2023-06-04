.data
A: .word 7, 2, 5, 1, 3
.text
la $a0, A
li $s6, 5
addi $s1, $zero, -1  #$s1 = i = -1
addi $s3, $zero, 2 # $s3 = n = 2
addi $s4, $zero, 1  # $s4 = step = 1
addi $s5, $zero, 0  # $s5 = sum = 0
loop: 
add $s1,$s1,$s4 #i=i+step
add $t1,$s1,$s1 #t1=2*s1
add $t1,$t1,$t1 #t1=4*s1 do 1 phan tu 4 byte
add $t3,$t1,$a0 #4i+A address of A[i]
lw $t0,0($t3) #load value of A[i] in $t0
add $s5,$s5,$t0 #sum=sum+A[i]
bne $s5,$zero,loop #if, goto loop
j done 
done:






