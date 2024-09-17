.data
Message1: .asciiz "The largest element is stored in $s"
Message2: .asciiz ", largest value is "
Message3: .asciiz "\nThe smallest element is stored in $s"
Message4: .asciiz ", smallest value is "
.text
li $s0, 1
li $s1, 8
li $s2, 9
li $s3, 0
li $s4, 2
li $s5, 3
li $s6, 18
li $s7, 90
.main:
sw $s0, -4($sp) # Lưu giá trị vào ngăn xếp 
sw $s1, -12($sp)
sw $s2, -20($sp)
sw $s3, -28($sp)
sw $s4, -36($sp)
sw $s5, -44($sp)
sw $s6, -52($sp)
sw $s7, -60($sp)
add $t0, $zero, $zero #i = 0
jal store
print1:
li $v0, 4
la $a0, Message1
syscall
li $v0, 1
add $a0, $t2, $zero # Vị trí max
syscall
li $v0, 4
la $a0, Message2
syscall
li $v0, 1
add $a0, $k0, $zero # Giá trị max
syscall
print2:
li $v0, 4
la $a0, Message3
syscall
li $v0, 1
add $a0, $t3, $zero # Vị trí min
syscall
li $v0, 4
la $a0, Message4
syscall
li $v0, 1
add $a0, $k1, $zero # Giá trị min
syscall
exit:
li $v0, 10
syscall
store:
sw $t0, 0($sp) # Lưu vị trí của từng giá trị vào ngăn xếp 
addi $t0, $t0, 1 
slti $t1, $t0, 8
bne $t1, $zero, adjust_stack
lw $k0, -4($sp) # Mặc định key là phần tử cuối 
lw $t2, 0($sp) # Vị trí của phần tử cuối 
max:
lw $t3, 4($sp) 
lw $t4, 8($sp)
slt $t1, $t3, $k0
bne $t1, $zero, maxx # Nếu $t3 > key -> Cập nhật max 
add $k0, $t3, $zero # Cập nhật max 
add $t2, $t4, $zero # Cập nhật vị trí max 
maxx:
addi $sp, $sp, 8 # Duyệt đến phần tử liền trước
bgtz $t4, max # Nếu duyệt đến vị trí 0 thì dừng lại 
lw $k1, -4($sp) # Key là phần tử đầu 
lw $t3, 0($sp) # Vị trí phần tử đầu 
min:
lw $t5, -8($sp) 
lw $t4, -12($sp) 
slt $t1, $k1, $t4 # So sánh 
bne $t1, $zero, minn
add $k1, $t4, $zero
add $t3, $t5, $zero 
minn:
addi $sp, $sp, -8 # Duyệt đến phân tử kế tiếp 
slti $t1, $t5, 7 # Nếu duyệt đến phần tử có vị trí là 7 thì dừng lại 
bne $t1, $zero, min
jr $ra # quay lại (*)
adjust_stack:
addi $sp, $sp, -8 
j store
