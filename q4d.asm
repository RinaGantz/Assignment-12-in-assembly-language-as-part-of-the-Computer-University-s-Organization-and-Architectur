
#Title: question 4 d      Filename: question 4
#Author:  Rina Gantz           Date: 20/08/2020
#Description: accumulate the sum and the multiplication of the integers (unsigned) in the array 
#Input: array- array of integers in memory (10 bytes)
#Output: print the sum of the array (unsigned),
#       also print the multiplication of the array(unsigned). 

########################Data segment###################################
.data
array :  .byte 23,-2,45,67,89,12,-100,0,120,6 #my array for example	
sum_msg: .asciiz "The sum of the array(unsign) is:"
mult_msg: .asciiz "\nThe sum of the squares (unsign) is :" 
#############Code segment#############
.text
.globl main     
main: # main program entry 
      li $t0, 0 # initialize the loop counter
      li $t5, 10 # initialize the limit counter
loopD: # accumulate the sum and the multiply of all the numbers (unsigned!) in the array
      lbu $t1, array($t0) # load the number as unsigned number
      add $t2,$t2,$t1 # accumulate the sum 
      mul $t3,$t1,$t1  # $t3= $t1*$t1
      add $t4, $t4, $t3 ##$t4+=$t3 , accumulate the multiply
      addi $t0, $t0, 1#  loop counter
      bne $t5, $t0, loopD #repeat until loop counter $t0=10

      la $a0, sum_msg #display sum massage string
      li $v0, 4 #print string 
      syscall
      
      move $a0, $t2 # $a0 = value to print 
      li $v0, 1 # Print integer
      syscall
     
      la $a0, mult_msg #display multiplication massage string
      li $v0, 4 #print string 
      syscall
      
      move $a0, $t4 # $a0 = value to print 
      li $v0, 1# Print integer
      syscall
      li $v0, 10 # Exit program
      syscall
