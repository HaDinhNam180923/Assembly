.text
li $s0, 0x12345678 	
andi $t0, $s0, 0xff000000 # Trich xuat MSB cua $s0 (2 bytes dau tien) vao t0
andi $s0, $s0, 0xffffff00 # Xoa LSB cua $s0
ori $s0, $s0, 0xff # Thiet lap cac bit tu 7 den 0 bang 1
andi $s0, $s0, 0x00000000 # Clear $s0

