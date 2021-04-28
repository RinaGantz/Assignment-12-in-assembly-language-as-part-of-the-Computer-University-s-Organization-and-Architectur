#Title: question 4 b      Filename: question 4
#Author: Rina Gantz            Date: 20/08/2020
#Description: print the difference of each pair of number in the array 
#Input: array- array of integers in memory (10 bytes)
#Output: print the difference of each pair of number(sign) in the array 
########################Data segment###################################
.data
array :  .byte 23,-2,45,67,89,12,-100,0,120,6 #my array for example
diff_msg: .asciiz " The difference of each pair of number(sign) in the array is: \n"
comma: .asciiz ","
#############Code segment#############
.text
.globl main     
main: # main program entry 
      
      la $a0, diff_msg #display sum massage string
      li $v0, 4 #print string
      syscall

      li $t0, 0 # initialize the loop counter
      li $t3, 9 # initialize the limit counter 
loopB: 
      lb $t1, array($t0) #load a number from the array
      addi $t0,$t0,1 #loop counter
          lb $t2, array($t0) # load the next number from the array
      sub $a0, $t1, $t2# $a0=$t1-$t2, calculate the difference 
      li $v0, 1 # print integer ($a0)
      syscall
      la $a0, comma # $a0=”,”
      li $v0, 4 #print string
      syscall
      bne $t0, $t3, loopB # repeat until $t0=$t3=9

      li $v0, 10 # Exit program
      syscall
