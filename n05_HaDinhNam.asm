.data
	infix: .space 256
	postfix: .space 256
	stack_Operator: .space 256
	stack_Calc: .space 256
	message: .asciiz "Nhap bieu thuc trung to:"
	message1: .asciiz "Bieu thuc khong hop le!"
	message2: .asciiz "Cac so phai nam trong pham vi tu 0-99"
	prompt1: .asciiz "\nBieu thuc trung to:"
	prompt2: .asciiz "Bieu thuc hau to:"
	prompt3: .asciiz "\nGia tri cua bieu thuc da nhap:"

.text
main:
input:
	jal nhap_infix
	jal khoi_tao_bien
	jal in_infix
	jal duyet_infix
	jal in_postfix
	jal in_it_Calc
	jal duyet_postfix		
	li $v0,10
	syscall
	

nhap_infix:
	li $v0,54
	la $a0,message
	la $a1,infix
	li $a2,255
	syscall		
	jr $ra

khoi_tao_bien:
	li $t6,0 # =1 khi quet dc 0-9, =2 '+,-,*,/', =3 '(', =4 ')'
	li $t7,0 # so chu so lien tiep quet duoc
	         # neu 3 chu so lien tiep thi ngoai pham vi 0-99
	la $s0,infix		
	la $s1,postfix		
	la $s2,stack_Operator	
	li $s6,-1 # index stack_Operator
	li $s7,-1 # index stackPostfix 
	jr $ra

in_it_Calc:	
	la $s4,stack_Calc		
	li $s5,-4		
	jr $ra
	
duyet_infix:
	addi $sp,$sp,-4	 # dia chi tra ve
	sw $ra,0($sp)	
	move $t5,$s0 # dia chi infix
start_scan:
scan:
	lb $s3,0($t5) # s3 luu gia tri duoc quet den
	addi $t5,$t5,1	# quet phan tu tiep
	beq $s3,' ',scan # quet duoc ki tu space->tiep tuc quet
	beq $t7,0,scan_number1	
	beq $t7,1,scan_number2	
	beq $t7,2,scan_number3	
continueScan:
	addi $t7,$zero,0 # de xet $t7	
	beq $s3,'*',nhan_chia		
	beq $s3,'/',nhan_chia
	beq $s3,'+',cong_tru
	beq $s3,'-',cong_tru
	beq $s3,'(',mo_ngoac		
	beq $s3,')',close_bracket
	beq $s3,10,scan		
	beq $s3,0,finishScan		
	j errorInput # quet den ki tu khong hop le
finishScan:
	jal pop_all_operator		
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

scan_number1:
	move $a0,$s3
	jal is_number	# is number?
	beqz $v0,continueScan	# not number -> quet tiep
	addi $t7,$zero,1 # so co 1 chu so	
	addi $s4,$s3,-48 # chuyen chu so sang so
	addi $t6,$zero,1 # chuyen trang thai nhan vao 1 so
	j scan			
scan_number2:
	move $a0,$s3
	jal is_number	# is number?		
	beqz $v0,numberToPostfix # not number -> push vao stack
	move $s5,$s3		
	addi $s5,$s5,-48
	mul $t3,$s4,10		
	add $s4,$t3,$s5	 # chuyen 2 chu so -> so co 2 chu so	
	addi $t7,$zero,2 # so co 2 chu so
	li $t6,1	
	j scan
scan_number3:
	move $a0,$s3
	jal is_number		 
	bnez $v0,errorNumber	# so > 99
	j numberToPostfix # push vao Postfix
numberToPostfix:
	move $a0,$s4
	jal push_postfix		
	j continueScan

nhan_chia:
	li $t6,2 # quet den toan tu
	bltz $s6,push_to_op_stack	# neu stack dang trong thi push toan tu vao
	jal degreeAtTheTop # tinh do uu tien cua operator dinh stack
	blt $v0,2,push_to_op_stack	 # neu phan tu dang xet lon hon phan tu o dinh thi push
	jal pop_operator	 # nguoc lai thi pop phan tu o dinh ra cho vao postfix
	move $a0,$v0
	jal push_postfix
	move $a0,$s3
	jal push_operator
	j scan
cong_tru:
	li $t6,2 # chuyen trang thai sang 2
	bltz $s6,push_to_op_stack	# stack rong thi push vao luon
	jal degreeAtTheTop # tinh do uu tien cua dinh stack_Operator
	blt $v0,1,push_to_op_stack	 # v0 = do uu tien cua dinh stack
				# neu phan tu dang xet lon hon phan tu o dinh thi push
	jal pop_operator	 # nguoc lai thi pop phan tu o dinh ra 
	move $a0,$v0	# cho vao postfix
	jal push_postfix	 # push vao postfix
	move $a0,$s3
	jal push_operator # push operator dang xet vao stack_Operator
	j scan
push_to_op_stack:				
	move $a0,$s3
	jal push_operator
	j scan
mo_ngoac:
	addi $t6,$zero,3 # chuyen trang thai sang 3
	move $a0,$s3
	jal push_operator # lap tuc push vao neu la '('
	j scan
close_bracket:
	addi $t6,$zero,4 # chuyen  trang thai sang 4
	add $t0,$s2,$s6	 # lay phan tu dau tien cua stack
	lb  $t2,0($t0)
	beq $t2,'(',errorInput	# tao thanh  () -> bao loi
continueClose_bracket:
	beq $s6,-1,errorInput	# neu khong co phan tu nao trong stackOp -> bao loi
	add $t0,$s2,$s6	
	lb  $t2,0($t0)	# quet qua cac ki tu
	beq $t2,'(',popMo_ngoac # neu ki tu hien tai != '(' pop_operator ra cho den khi ki tu hien tai ='('
	jal pop_operator	 #  nguoc lai popMo_ngoac
	move $a0,$v0	
	jal push_postfix	 # pop operator ra cho vao Postfix
	j continueClose_bracket		
popMo_ngoac:
	jal pop_operator	# pop ki tu '(' ra khoi stack
	j scan
	
degreeAtTheTop:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	add $t0,$s2,$s6
	lb $a0,0($t0)
	jal degree
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

degree:
	beq $a0,'*',degreeNhan_chia # neu = * , / thi output = 2
	beq $a0,'/',degreeNhan_chia
	beq $a0,'+',degreeCong_tru # neu = +, - thi output = 1
	beq $a0,'-',degreeCong_tru
	beq $a0,'(',degreeMo_ngoac # neu = '(' thi output = 0
degreeNhan_chia:
	addi $v0,$zero,2
	jr $ra
degreeCong_tru:
	addi $v0,$zero,1
	jr $ra	
degreeMo_ngoac:
	addi $v0,$zero,0
	jr $ra	

push_postfix:
	addi $s7,$s7,1
	add $t0,$s1,$s7
	sb $a0,0($t0)
	jr $ra

popPostfix:
	add $t0,$s1,$s7
	lb $v0,0($t0)
	addi $s7,$s7,-1
	jr $ra	

pushStack_Calc:
	addi $s5,$s5,4
	add $t0,$s4,$s5
	sw $a0,0($t0)
	jr $ra

popStack_Calc:
	add $t0,$s4,$s5
	lw $v0,0($t0)
	addi $s5,$s5,-4
	jr $ra

in_postfix:
	addi $sp,$sp,-4	# cat giu dia chi tro ve
	sw $ra,0($sp)
	la $a0,prompt2
	jal printString	# in ra prompt2
	addi $t0,$zero,0# bien diem i
	add $t1,$zero,$s1	
printPost:
	add $t1,$s1,$t0
	lbu $t2,0($t1)		
	bgt $t0,$s7,finishPrint	# neu i > index -> finishPrint
	addi $t0,$t0,1
	move $a0,$t2
	jal is_operator	# kiem tra xem co phai la toan tu k ? 
	bnez $v0,printOp# neu la toan tu chuyen den -> print Operator
	move $a0,$t2	# nguoc lai in so ra man hinh
	li $v0,1
	syscall	
	jal print_space	# in khoang trang 
	j printPost
printOp:# in operator
	li $v0,11
	move $a0,$t2
	syscall
	jal print_space
	j printPost
finishPrint:
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

print_space:
	li $v0,11
	li $a0,' '
	syscall
	jr $ra

in_infix:
	addi $sp,$sp,-4	 # cat giu gia tri tro ve
	sw $ra,0($sp)
	la $a0,prompt1	
	jal printString
	la $a0,infix
	jal printString	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
pop_all_operator:	
	beq $s0, -1, errorInput # Neu ko nhap j -> Loi	
	addi $sp,$sp,-4
	sw $ra,0($sp)
startPop:
	bltz  $s6,finishPopAll	# neu index stack < 0 -> da duyet qua dc het cac phan tu
	jal pop_operator	# -> ket thuc viec pop
	move $a0,$v0	# nguoc lai thi pop_operator ra va push vao Postfix
	jal push_postfix	
	j startPop
finishPopAll:
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

calc:
	beq $a2,'+',Add		
	beq $a2,'-',Sub
	beq $a2,'*',Multi
	beq $a2,'/',Div
Add:
	add $v0,$a0,$a1
	jr $ra
Sub:
	sub $v0,$a0,$a1
	jr $ra
Multi:
	mul $v0,$a0,$a1
	jr $ra
Div:	
	div $v0,$a0,$a1
	jr $ra

duyet_postfix:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	addi $t4,$zero,0
start_scan_post:
	add $t1,$s1,$t4
	lb  $t2,0($t1)
	bgt $t4,$s7,finish_scan_post
	addi $t4,$t4,1
	move $a0,$t2
	jal is_operator
	bnez $v0,calculator# neu la toan tu thi di vao ham tinh toan
	move $a0,$t2
	jal pushStack_Calc
	j start_scan_post
calculator:
	jal popStack_Calc# lay ra so thu 2
	move $a1,$v0	
	jal popStack_Calc# lay ra so thu 1
	move $a0,$v0
	move $a2,$t2
	jal calc # thuc hien phep toan 
	move $a0,$v0
	jal pushStack_Calc
	j start_scan_post
finish_scan_post:
printResult:
	la $a0,prompt3
	jal printString
	jal popStack_Calc
	move $a0,$v0
	li $v0,1
	syscall
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

push_operator:
	addi $s6,$s6,1
	add $t0,$s2,$s6
	sb $a0,0($t0)
	jr $ra

pop_operator:
	add $t0,$s2,$s6
	lb $v0,0($t0)
	addi $s6,$s6,-1
	jr $ra

is_operator:
	beq $a0,'+',end_op
	beq $a0,'-',end_op
	beq $a0,'*',end_op
	beq $a0,'/',end_op
	addi $v0,$zero,0
	jr $ra
end_op:
	addi $v0,$zero,1
	jr $ra
is_number:
	beq $a0,'0',end_number
	beq $a0,'1',end_number
	beq $a0,'2',end_number
	beq $a0,'3',end_number
	beq $a0,'4',end_number
	beq $a0,'5',end_number
	beq $a0,'6',end_number
	beq $a0,'7',end_number
	beq $a0,'8',end_number
	beq $a0,'9',end_number
	addi $v0,$zero,0
	jr $ra
end_number:
	addi $v0,$zero,1
	jr $ra
errorInput:
	li $v0,55
	li $a1,0
	la $a0,message1
	syscall
	j input
errorNumber:
	li $v0,55
	li $a1,0
	la $a0,message2
	syscall
	j input
printString:	
	li $v0,4
	syscall
	jr $ra 



	
	
	
