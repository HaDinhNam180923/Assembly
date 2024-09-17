.text		
li $t0, 0		
li $s1, 18
li $s2, 0x7fffffff	
addu $s3,$s1,$s2	
xor $t1,$s1,$s2 #Test if $s1 and $s2 have the same sign
bltz $t1,HEHE #If not, exit		
xor $t2,$s3,$s1	
bltz $t2, OVERFLOW	
j HEHE
OVERFLOW:
	li $t0,1
HEHE:
