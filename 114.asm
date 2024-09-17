.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.eqv COUNTER 0xFFFF0013 # Time Counter
.eqv MASK_CAUSE_COUNTER 0x00000400 # Bit 10: Counter interrupt
.eqv MASK_CAUSE_KEYMATRIX 0x00000800 # Bit 11: Key matrix interrupt
.data
msg_keypress: .asciiz "Someone has pressed a key!\n"
msg_counter: .asciiz "Time inteval!\n"
.text
main:
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t4, OUT_ADRESS_HEXA_KEYBOARD
 li $t3, 0x80 # bit 7 = 1 to enable
 sb $t3, 0($t1)
 li $t1, COUNTER
 sb $t1, 0($t1)
Loop: nop
 nop
 nop
sleep: addi $v0,$zero,32 # BUG: must sleep to wait for TimeCounter
 li $a0,1000 # sleep 300 ms
 syscall
 nop # WARNING: nop is mandatory here.
 nop
 nop
 nop
 b Loop
end_main:
.ktext 0x80000180
IntSR: 
dis_int:li $t1, COUNTER # BUG: must disable with Time Counter
 sb $zero, 0($t1)
get_caus:mfc0 $t1, $13 # $t1 = Coproc0.cause
IsCount:li $t2, MASK_CAUSE_COUNTER# if Cause value confirm Counter..
 and $at, $t1,$t2
 beq $at,$t2, Counter_Intr
IsKeyMa:li $t2, MASK_CAUSE_KEYMATRIX # if Cause value confirm Key..
 and $at, $t1,$t2
 beq $at,$t2, Keymatrix_Intr
others: j end_process # other cases
Keymatrix_Intr: li $v0, 4 # Processing Key Matrix Interrupt
 la $a0, msg_keypress
 syscall
  li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x01 # check row 1
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t4) # read scan code of key button
 bnez $a0, print
 li $t3, 0x02 # check row 2
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t4) # read scan code of key button
 bnez $a0, print
 li $t3, 0x04 # check row 3
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t4) # read scan code of key button
 bnez $a0, print
 li $t3, 0x08 # check row 4
 sb $t3, 0($t1 ) # must reassign expected row
 lb $a0, 0($t4) # read scan code of key button
 print: li $v0, 34 # print integer (hexa)
 syscall
 sleepy: li $a0, 1000 # sleep 1000ms
 li $v0, 32
 syscall
 addi $v0,$zero,11
 li $a0,'\n' # print endofline
 syscall
 li $t3, 0x80 # bit 7 = 1 to enable
 sb $t3, 0($t1)
 li $t1, COUNTER
 sb $t1, 0($t1)
 
 j end_process
Counter_Intr: li $v0, 4 # Processing Counter Interrupt
 la $a0, msg_counter
 syscall
 j end_process
end_process:
 mtc0 $zero, $13 # Must clear cause reg
en_int:
 li $t1, COUNTER
 sb $t1, 0($t1)
next_pc:mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc
 addi $at, $at, 4 # $at = $at + 4 (next instruction)
 mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at
 return: eret # Return from exception
 
