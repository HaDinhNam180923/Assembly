.text
main:
li $a0, -18 #load input parameter
jal absolute #jump and link to abs procedure
nop
add $s0, $zero, $v0
li $v0, 10 #terminate
syscall
endmain:
absolute:
sub $v0, $zero, $a0 #put -(a0) in v0; in case (a0) < 0
bltz $a0, done #if (a0) < 0 then done
nop
add $v0, $a0, $zero #else put (a0) in v0
done:
jr $ra
