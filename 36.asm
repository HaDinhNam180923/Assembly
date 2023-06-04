  .data
array:  .word   1, 2, -3, -4, 10   
n:      .word   5                                  

    .text 

main:
    la      $t1, array       
    lw      $t2, n           
    lw      $t0, ($t1)       
    abs     $t0, $t0         

loop:
    addi    $t1, $t1, 4      
    lw      $t3, ($t1)       
    abs     $t3, $t3         
    bgt     $t3, $t0, update 

    bne     $t2, $zero, loop 
    j       done             

update:
    move    $t0, $t3         
    bne     $t2, $zero, loop 
    j       done

done:


