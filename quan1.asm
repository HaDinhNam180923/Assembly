.eqv SEVENSEG_LEFT 0xFFFF0011 
.eqv SEVENSEG_RIGHT 0xFFFF0010 
.data
x: .asciiz "Nhap so nguyen:"
youtube: .space 8
.text
li $v0, 51
la $a0, x
syscall #Nhập số nguyên 
li $s0, 10
la $t0, youtube #địa chỉ mảng rỗng 
div $a0, $s0# Chia cho 10 
mfhi $a1#Gán số dư cũng là chữ số cuối cùng của số nguyên đó 
sw $a1, 0($t0)#lưu vào mảng, đoạn sau tương tự 
addi $t0, $t0, 4
mflo $a0
div $a0, $s0
mfhi $a1
sw $a1, 0($t0)
main:

 la $s0, youtube
 lw $a0, 0($s0) # set value for segments
 bne $a0, 0, hehe1 #nhảy đến hàm sau nếu nó khác 0 
 li $a0, 63 #giá trị để in ra số 0 , cái sau tương tự 
 j hehe #Nếu nó bằng 0 nhảy đến hàm để hiển thị 
 hehe1:
 bne $a0, 1, hehe2
 li $a0, 6
 j hehe
 hehe2:
  bne $a0, 2, hehe3
 li $a0, 91
 j hehe
 hehe3:
  bne $a0, 3, hehe4
 li $a0, 79
 j hehe
  hehe4:
  bne $a0, 4, hehe5
 li $a0, 102
 j hehe
  hehe5:
  bne $a0, 5, hehe6
 li $a0, 109
 j hehe
  hehe6:
  bne $a0, 6, hehe7
 li $a0, 125
 j hehe
  hehe7:
  bne $a0, 7, hehe8
 li $a0, 7
 j hehe
  hehe8:
  bne $a0, 8, hehe9
 li $a0, 127
 j hehe
  hehe9:
 li $a0, 111
 
 
 
 
 
 
 hehe:
 jal SHOW_7SEG_RIGHT # show
 nop

 lw $a0, 4($s0) # set value for segments
 bne $a0, 0, hoho1
 li $a0, 63 
 j hoho
 hoho1:
 bne $a0, 1, hoho2
 li $a0, 6
 j hoho
 hoho2:
  bne $a0, 2, hoho3
 li $a0, 91
 j hoho
 hoho3:
  bne $a0, 3, hoho4
 li $a0, 79
 j hoho
  hoho4:
  bne $a0, 4, hoho5
 li $a0, 102
 j hoho
  hoho5:
  bne $a0, 5, hoho6
 li $a0, 109
 j hoho
  hoho6:
  bne $a0, 6, hoho7
 li $a0, 125
 j hoho
  hoho7:
  bne $a0, 7, hoho8
 li $a0, 7
 j hoho
  hoho8:
  bne $a0, 8, hoho9
 li $a0, 127
 j hoho
  hoho9:
 li $a0, 111
 
 
 hoho:
 jal SHOW_7SEG_LEFT # show
 nop
exit: li $v0, 10
 syscall
endmain:

SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address
 sb $a0, 0($t0) # assign new value
 nop
jr $ra
nop

SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # assign port's address
 sb $a0, 0($t0) # assign new value
 nop
jr $ra
 nop
