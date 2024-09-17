.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.data
Message: .asciiz "\nOh my god. Someone's presed a button.\n"
.text
main:
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t2, OUT_ADRESS_HEXA_KEYBOARD 
 li $t3, 0x80 # bit 7 of = 1 to enable interrupt
 sb $t3, 0($t1)
Loop: nop
 nop
 nop
 nop
 b Loop # Wait for interrupt
end_main:
.ktext 0x80000180
IntSR: addi $v0, $zero, 4 # show message
 la $a0, Message
 syscall
 li $t3, 0x01 # check row 1
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 bnez $a0, print
 li $t3, 0x02 # check row 2
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 bnez $a0, print
 li $t3, 0x04 # check row 3
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 bnez $a0, print
 li $t3, 0x08 # check row 4
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t2) # read scan code of key button
 print: li $v0, 34 # print integer (hexa)
 syscall
next_pc:mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 addi $at, $at, 4 # $at = $at + 4 (next instruction)
 mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at
 li $t3, 0x80 # bit 7 of = 1 to enable interrupt
 sb $t3, 0($t1)
return: eret # Return from exception 
