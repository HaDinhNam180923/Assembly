.data
input1:     .space 100     
input2:     .space 100     
output1:    .space 100     
output2:    .space 100     
separator:  .asciiz " "    

prompt1:    .asciiz "Enter the first student's name: "
prompt2:    .asciiz "Enter the second student's name: "
result1:    .asciiz "Transformed name of the first student: "
result2:    .asciiz "\nTransformed name of the second student: "

.text
.globl main

main:
    li $v0, 4               
    la $a0, prompt1
    syscall

    li $v0, 8               
    la $a0, input1
    li $a1, 100
    syscall

    li $v0, 4               
    la $a0, prompt2
    syscall

    li $v0, 8               
    la $a0, input2
    li $a1, 100
    syscall

    jal transformName       

    li $v0, 4               
    la $a0, result1
    syscall

    li $v0, 4               
    la $a0, output1
    syscall

    li $v0, 4            
    la $a0, result2
    syscall

    li $v0, 4               
    la $a0, output2
    syscall

    j endProgram
transformName:
    la $a0, separator #địa chỉ dấu cách 
    lb $a1, 0($a0) #giá trị dấu cách 
    li $a2, 10 #giá trị \n (Enter)
findSeparator:#tìm dấu ngăn cách 
        la $t0, input1 #con trỏ trỏ đến đầu xâu 1
    hehe:    
        lb $t1, 0($t0) #lấy ra từng kí tự của chuỗi 1 
        beq $t1, $a2, kaka #duyệt đến kí tự cuối (so sánh với kí tự \n)
        beq $a1, $t1, hehe1 #nếu kí tự đó là dấu ngăn cách (so sánh với kí tự ngăn cách )
        addi $t0, $t0, 1 #con trỏ trỏ đến kí tự tiếp 
        j hehe
    hehe1:
        addi $s0, $t0, 1 #địa chỉ kí tự sau dấu cách, nếu duyệt hết chuỗi 1 sẽ là địa chỉ firstname 
        addi $t4, $t0, 0 #địa chỉ dấu cách, nếu duyệt hết sẽ là địa chỉ dấu cách cuối 
        addi $t0, $t0, 1 #con trỏ trỏ đến kí tự tiếp 
        j hehe
kaka:
        la $t2, input2 #con trỏ trỏ đến đầu xâu 2
    hehehe:
        lb $t3, 0($t2)# lấy ra từng kí tự của chuỗi 2 
        beq $t3, $a2, kakaka #duyệt đến kí tự cuối
        beq $a1, $t3, hehehe1#nếu kí tự đó là dấu cách 
        addi $t2, $t2, 1 #con trỏ trỏ đến kí tự kế tiếp
        j hehehe
    hehehe1:
        addi $s1, $t2, 1 #địa chỉ kí tự sau dấu cách, nếu duyệt hết chuỗi 1 sẽ là địa chỉ firstname 
        addi $t5, $t2, 0#địa chỉ dấu cách, nếu duyệt hết sẽ là địa chỉ dấu cách cuối 
        addi $t2, $t2, 1#con trỏ trỏ đến kí tự tiếp 
        j hehehe
kakaka:
    la $t0, input1#load địa chỉ các xâu
    la $t1, input2
    la $v0, output1
    la $v1, output2
    out1:#load firstname
        lb $t2, 0($s0)# $s0 la dia chi firstname của xâu 1
        beq $t2, $a2, out11 # duyet den phan tu cuoi
        sb $t2, 0($v0) #lưu firstname vào xâu output 1 
        addi $s0, $s0, 1#tăng gtri con trỏ của 2 xâu
        addi $v0, $v0, 1
        j out1
    out11:#load dau cach
        sb $a1, 0($v0) #sau khi duyệt lưu xong firstname lưu thêm dấu cách 
        addi $v0, $v0, 1#dịch con trỏ 
    out111:#load last name
        beq $t0, $t4, out2#$t4 là địa chỉ dấu cách cuối của xâu 1 (trỏ đến có nghĩa đã duyệt hết lastname)
        lb $t2, 0($t0)#lấy ra kí tự của xâu 1
        sb $t2, 0($v0)#lưu kí tự vào xâu output 1 
        addi $t0, $t0, 1#dịch con trỏ 
        addi $v0, $v0, 1
        j out111
    out2:
        lb $t3, 0($s1)# $s1 la dia chi firstname của xâu 2
        beq $t3, $a2, out22# duyet den phan tu cuoi
        sb $t3, 0($v1)#lưu firstname vào xâu output 2
        addi $s1, $s1, 1#dịch con trỏ
        addi $v1, $v1, 1
        j out2
    out22:
        sb $a1, 0($v1)#sau khi duyệt lưu xong firstname lưu thêm dấu cách 
        addi $v1, $v1, 1#dịch con trỏ 
    out222:
        beq $t1, $t5, end#kiểm tra xem đã duyệt hết lastname hay chưa 
        lb $t3, 0($t1)#lấy kí tự xâu 2
        sb $t3, 0($v1)#lưu vào xâu output 2
        addi $t1, $t1, 1#dịch con trỏ 
        addi $v1, $v1, 1
        j out222
 
        
end:

jr $ra #quay lại in chuỗi 

endProgram:
