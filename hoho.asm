.data
string: .space 21
string2: .space 21
Meg1: .asciiz "Nhap xau: "
Meg2: .asciiz "Xau in nguoc: "
.text
li $t7, 10
li $t6, 20

 li $v0, 4
 la $a0, Meg1
 syscall

la $a1, string
la $a0, string2
main:
get_string_end_length: # TODO
xor $t5, $zero, $zero # v0 = length = 0
xor $t0, $zero, $zero # t0 = i = 0
nhap_ki_tu:add $t1, $a1, $t0 
li $v0, 12
syscall 
sb $v0,0($t1)
addi $t0, $t0, 1 
beq $v0,$t7,end_of_str
addi $t5, $t5, 1 # v0=v0+1->length=length+1
subi $s0,$t5,1
beq $s0,$t6,strcpy
j nhap_ki_tu
end_nhap_ki_tu:
end_of_str:



strcpy:
L1:
add $t1,$s0,$a1 #t1 = s0 + a1 = i + y[0]
# = address of y[i]
lb $t2,0($t1) #t2 = value at t1 = y[i]
add $t3,$s1,$a0 #t3 = s0 + a0 = i + x[0]
# = address of x[i]
sb $t2,0($t3) #x[i]= t2 = y[i]
beq $t2,$zero,end_of_strcpy #if y[i]==0, exit
nop
addi $s1, $s1, 1
subi $s0,$s0,1 #s0=s0 + 1 <-> i=i+1
j L1 #next character
nop
end_of_strcpy:
 li $v0, 4
 la $a0, Meg2
 syscall
li $v0, 4
la $a0, string2
syscall
