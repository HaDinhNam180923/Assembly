.data
Message: .asciiz "Ket qua tinh giai thua la: "
.text
main: jal WARP
print: add $a1, $v0, $zero # $a0 = result from N!
li $v0, 56
la $a0, Message
syscall
quit: li $v0, 10 #terminate
syscall
endmain:
WARP:
sw $fp, -4($sp) #save frame pointer
addi $fp, $sp, 0 #new frame pointer point to the top
addi $sp, $sp, -8 #adjust stack pointer
sw $ra, 0($sp) #save return address
li $a0, 3 #load test input N
jal FACT #call fact procedure
nop
lw $ra, 0($sp) #restore retrun address
addi $sp, $fp, 0 #retrun stac pointer
lw $fp, -4($sp) #return frame pointer
jr $ra
wrap_end:
FACT:
sw $fp, -4($sp) #save frame pointer
addi $fp, $sp, 0 #new frame pointer point to stack's top
addi $sp, $sp, -12 #allocate space for $fp, $ra, $a0 in stack
sw $ra, 4($sp) #save return address
sw $a0, 0($sp) #save $a0 register
slti $t0, $a0, 2 #if input argument N < 2
beq $t0, $zero, recursive #if it is false ((a0 = N) >= 2)
nop
li $v0, 1 #return the result N!=1
j done
nop
recursive:
addi $a0, $a0, -1 #adjust input argument
jal FACT #recursive call
nop
lw $v1, 0($sp) #load a0
mult $v1, $v0 #compute the result
mflo $v0
done: lw $ra, 4($sp) #restore retrun address
lw $a0, 0($sp) #restore a0
addi $sp, $fp, 0 #restore stackpointer
lw $fp, -4($sp) #restore frame pointer
jr $ra #jump to calling
fact_end:
