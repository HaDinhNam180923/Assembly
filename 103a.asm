.eqv HEADING 0xffff8010 
.eqv MOVING 0xffff8050 
.eqv LEAVETRACK 0xffff8020 
.eqv WHEREX 0xffff8030 
.eqv WHEREY 0xffff8040 
.text
main: 
 addi $a0, $zero, 90 
 jal ROTATE
 jal GO
sleep: addi $v0,$zero,32
 li $a0,5000
 syscall
 addi $a0, $zero, 180 
 jal ROTATE
sleep1: addi $v0,$zero,32 
 li $a0,5000
 syscall
#Bắt đầu vẽ hình 
 jal TRACK 
go1: addi $a0, $zero, 18
 jal ROTATE
sleep2: addi $v0,$zero,32 
 li $a0,5000
 syscall
jal UNTRACK
jal TRACK
go2: addi $a0, $zero, 162
 jal ROTATE
sleep3: addi $v0,$zero,32 
 li $a0,5000
 syscall
 jal UNTRACK
 jal TRACK
go3:addi $a0, $zero, 306
 jal ROTATE
sleep4: addi $v0,$zero,32 
 li $a0,5000
 syscall
  jal UNTRACK
 
 jal TRACK
go4: addi $a0, $zero, 90
 jal ROTATE
sleep5: addi $v0,$zero,32 
 li $a0,5000
 syscall
 jal UNTRACK
 
 jal TRACK
go5: addi $a0, $zero, 234
 jal ROTATE
sleep6: addi $v0,$zero,32 
 li $a0,5000
 syscall
 jal UNTRACK
 
jal STOP 
j hehe 
end_main:
GO: li $at, MOVING
 addi $k0, $zero,1 
 sb $k0, 0($at) 
 jr $ra
STOP: li $at, MOVING 
 sb $zero, 0($at) 
 jr $ra
TRACK: li $at, LEAVETRACK 
 addi $k0, $zero,1 
 sb $k0, 0($at) 
 jr $ra
UNTRACK:li $at, LEAVETRACK 
 sb $zero, 0($at) 
 jr $ra
ROTATE: li $at, HEADING 
 sw $a0, 0($at)
 jr $ra
 hehe:
