.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.text
main: li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t2, OUT_ADRESS_HEXA_KEYBOARD
polling: 
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
 sleep: li $a0, 1000 # sleep 1000ms
 li $v0, 32
 syscall
back_to_polling: j polling # continue polling
