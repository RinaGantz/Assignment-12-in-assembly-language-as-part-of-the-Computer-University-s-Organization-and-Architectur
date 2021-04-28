#Title: question 4 c      Filename: question 4
#Author: Rina Gantz            Date: 20/08/2020
#Description: get a array of integers in memory (10 bytes) and print the array as unsigned numbers
#Input: array- array of integers in memory (10 bytes)
#Output: print the array as unsigned numbers
########################Data segment###################################
.data
array :  .byte 23,-2,45,67,89,12,-100,0,120,6 #my array for example

unsign_msg: .asciiz "The array as unsign nunbers : \n"

comma: .asciiz ","
#############Code segment#############
.text
.globl main     
main: # main program entry 
     la $a0, unsign_msg #display unsigned massage string
      li $v0, 4 #print string
      syscall
      li $t0, 0 # initialize the loop counter 
      li $t1, 10 # initialize the limit counter
loopC: #print numbers in array as unsigned numbers
      lbu $a0, array($t0) #load the byte from the array
      li $v0, 1 # Print integer
      syscall
      la $a0, comma # load address of label  
      li $v0, 4 # print string
      syscall
      addi $t0, $t0, 1 #loop counter
      bne $t0, $t1, loopC # repeat until loop counter $t0=10
      li $v0, 10 # Exit program
      syscall
