#Title: question  5      Filename: mmn 12
#Author: Rina Gantz          Date: 20/08/2020
#Description: get 2 arrays and print the numbers that appears in both
#Input: array- 2 array of integers in memory (10 bytes)
#Output: prints the numbers that appear in both arrays in descending order according base 4                    
#       and 10.
########################Data segment###################################
.data
array1 :  .word 0:10 
array2 :  .word 0:10	
enter10_msg: .asciiz "Please enter 10 numbers: \n"

enter_msg: .asciiz "Please enter a number: \n"
wrong_msg: .asciiz " Your number isn’t valid. \n"
minus: .asciiz "-"
equals4_msg: .asciiz "The numbers that appear in both arrays on base 4 are : \n"
equals10_msg: .asciiz "The numbers that appear in both arrays on base 10 are: \n"
comma: .asciiz ", "
newLine: .asciiz "\n"
#############Code segment#############
.text

.globl main
main:
      la $a0, enter10_msg #display enter massage string
      li $v0, 4 #print string
      syscall 
      la $a1, array1 #load address of array1
      jal getArray #call the procedure get array
      la $a0, enter10_msg #display enter massage string
      li $v0, 4 #print string
      syscall 
      la $a1, array2#load address of array2
      jal getArray #call the procedure get array
      
       la $a0, equals10_msg #display equals massage string
      li $v0,4  #print string
      syscall 
      la $a1, array1 #load address of array1
      la $a2, array2 #load address of array2
      li $a3, 10 #load base 10
      jal findEq#call the procedure get array
      
      la $a0,newLine# entering an new line 
      li $v0,4# print string 
      syscall 
     la $a0, equals4_msg #display equals massage string
      li $v0, 4 #print string
      syscall 
      la $a1, array1 #load address of array1
      la $a2, array2 #load address of array2
      li $a3, 4 #load base 4
      jal findEq#call the procedure get array



    

     li $v0, 10 #load service number for exit 
     syscall 


      

      

      







###########################################section getArray######################

#function that set the array in order
#void getArray(words array){
#   array[0]=inputNumber1
#   array[1]=inputNumber2 
#....
#  array[9]= inputNumber10
# }
# parameters : $a1=base of the array

getArray: 
     li $t1, 0 #counter
     li $t4,10 # the counter limit
     j loopA  # jump to the loop that will print the input numbers
invalid: # print a message to get a new number- valid number
     la $a0,wrong_msg #display sum massage string
      li $v0, 4 #ptint the string= the “wrong_msg”
      syscall
 loopA: # get the input numbers and initialize them
      la $a0, enter_msg #display enter massage string
      li $v0, 4 #print string 
      syscall
      li $v0, 5 #read integer
      syscall
      beq $t1 , $zero , store # don’t compare the first number
      slt $t0, $t2,$v0 # $t0=$t2<$v0? 1 : 0;
      beq $t0,$zero ,invalid  # don’t store invalid number , brunch to a new message.
store: # store the input number to the array
       sw $v0, ($a1) # store number in the array   
      move $t2,$v0 #for comparing in the next iteration
      addi $a1, $a1,4 #so to the next cell in the array
      addi $t1, $t1, 1   #loop counter
      bne $t1,$t4 ,loopA # repeat until loop counter is 10
      jr $ra #return to the address in $ra
      #end procedure get array

#################################section find eq##########################
# function that prints the numbers in descending order of the classified arrays according #to the given base, 10 or 4
#parameters: $a1=arr1, $a2=arr2, $a3=the base, 4 or 10
findEq:
     li $t0, 4 # $t0=4, option for base
     move $t5, $a1 #copy the adrress that in $a1
     subi $t5,$t5, 4# loop limit of array 1
     move $t6, $a2# copy  the address thats in  $a2
      subi $t6,$t6, 4# loop limit of array 2
     addi $t1, $a1 ,36#load the  address last cell of the array 1
     addi $a2, $a2 ,36#load the address last cell of the array 2
loop:
     beq $t5,$t1, exit  # all the numbers from array1 already printed, exit
     beq $t6,$a2, exit  # all the numbers from array2 already printed ,exit
     lw $t3, ($t1) # load the current word from array1
     lw $t4, ($a2) # load the current word from array2
     bne $t3, $t4 , notEq
     beq  $a3,$t0,caller4 # the base is 4
     move $a0,$t3 # load word $a0=$t3 from arr1          
li $v0,1 # print integer
     syscall
      la $a0, comma  #load address of label
      li $v0, 4   # print char
      syscall
     j continue # jump because the base isn’t 4. 
caller4: # the base is 4, call to the help method “base4” that prints number in 4    base.
     addiu $sp, $sp, -4
     sw $ra, 0($sp)
     move $a1, $t3 # copy to the parameter for the method base4
     jal base4 #call to the help print method – base4
     lw $ra, 0($sp)
     addiu $sp,$sp,4
continue:
     subi $a2, $a2, 4 # the next address in the array2. (4 bytes all word)
     subi $t1, $t1, 4 # the next address in the array2. (4 bytes all word)
     j loop 
notEq:
     slt $t2,$t3, $t4  #$t2=$t3<$t4?1:0; if t2!=0, t4 bigger.
     bne $t2, $zero, counterArr2 # $t4 is bigger, should backtrack array2
# $t3 is greater, reduce counter array1:	
     subi $t1, $t1, 4 # the next address in the array1. (4 bytes all word)
     j loop  #repeat for the next word 
counterArr2: # t4 is bigger, reduce counter:
     subi $a2, $a2, 4 # the next address in the array2. (4 bytes all word)
     j loop #repeat for the next word
exit:
      jr, $ra
#enf of section find eq

     

     
     
     
     
    


###################################section base4##########################
#function that converts a number (sign) from base binary to base 4 
# parameters : $a1=number to convert
 
base4: 
      srl $t7,$a1,31 #remain only the msb
      beq  $t7,$zero, counter # brunch if the input number is positive
      la $a0, minus #load the sign “-“, $a0=’-‘
      li $v0,11 # syscall service-print the character ($a0)
      syscall
      sub $a1, $zero, $a1
 counter:  li $t7, 16 
loopzero: #intilize left 16 bits to zero
       move $a0, $zero # $a0 = value to print 
       li $v0, 1 # Print integer 
       syscall
       subi $t7, $t7,1 #loop counter 
      bne $t7, $zero, loopzero #repeat until loop counter is 0
      #end of loopzero
      li $t7, 16 #set the loop counter
loopbase4: #print one bit in 4 base, calculate each pair of bits according to 2’complete 
         # method
      srl $t8,$a1,31  #$t4=the msb
      sll $a1,$a1,1  #delete the msb (that already in $t8)
      mul $t8 , $t8, 2  # double the msb according to 2’complete method
      srl $t9, $a1,31  #$t5=the new msb
      sll $a1,$a1,1  #delete the msb (that already in $t9)
      add $a0, $t9, $t8  # $a0=$t9+$t8 = value to print
      li $v0 , 1  # Print integer ($a0)
      syscall
      subi $t7, $t7, 1 # loop counter
      bne $t7, $zero, loopbase4 #repeat until loop counter is 0
      la $a0, comma  #load address of label
      li $v0, 4   # print char
      syscall
     jr $ra # return to the address in $ra

