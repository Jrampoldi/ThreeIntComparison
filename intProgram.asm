#####################################################################
# Program:Enter Three Int	Programmer: Jourdan Rampoldi
# Last Modified: 03/ 21/ 2023
#####################################################################
# Functional Description:
# This program will take three integers from the user and calculate
# the sum, average, and product of the values entered by the user
# then display all the calculated values to user.
#####################################################################
# Pseudocode:
# cout << "Enter val: "
# cin >> f2
# cout << "Enter val: "
# cin >> f3
# cout << "Enter val: "
# cin >> f4
#
# f5 = f2 + f3 + f4
# cout << "The values added: " << f5
#
# f6 = f2 * f3 * f4
# cout << "The values multiplied: " << f6
#
# f7 = f5 / 3
# cout << "The values averaged is: " << f7
#
# if (f2 > f3 && f2 > f4)
#	cout << "Highest val is: " << f2
# else if (f3 > f2 && f3 > f4)
#	cout << "Highest val is: " << f3
# else
#	cout << "Highest val is: " << f4
# if (f2 < f3 && f2 < f4)
#	cout << "Lowest val is: " << f2
# else if (f3 < f2 && f3 < f4)
#	cout << "Lowest val is: " << f3
# else
#	cout << "Lowest val is: " << f4
#
# terminate program
#
######################################################################
# Register Usage:
# $v0: sys code
# $a0: pass args
# $f0: holds user float input
# $f1: holds value of 0.0
# $f9: holds value of 3.0
# $f2: holds value 1
# $f3: holds value 2
# $f4: holds value 3
# $f5: holds values added
# $f6: holds multiplied values
# $f7: holds averaged values
# $f12: used to pass args
######################################################################


.data
	enterVal:	.asciiz "Please enter a value: "
	addVal:		.asciiz "\nThe values added are: "
	multVal:	.asciiz "\nThe valued multiplied are: "
	aveVal:		.asciiz "\nThe average of the values are: "
	highVal:	.asciiz "\nThe highest value is: "
	lowVal:		.asciiz "\nThe lowest value is: "
	
	zerof:		.float 0.0					# float zero 
	threef:		.float 3.0					# float three

.text

	main:				#main procedure
		li	$v0, 4						# print_string sys code
		la	$a0, enterVal					# msg to user
		syscall

		lwc1	$f1, zerof					# load zero value to float reg 1
		lwc1	$f9, threef					# load three value to float reg 9

		li	$v0, 6						# read_float sys code
		syscall
	
		add.s	$f2, $f0, $f1					# move float to float reg 2

		li	$v0, 4						# print_string sys code
		la	$a0, enterVal					# msg to user
		syscall

		li	$v0, 6						# read_float sys code
		syscall

		add.s	$f3, $f0, $f1					# move float to float reg 3
		
		li	$v0, 4						# print_string sys code
		la	$a0, enterVal					# msg to user
		syscall

		li	$v0, 6						# read_float sys code
		syscall

		add.s	$f4, $f0, $f1					# move float to float reg  4

# ------------------------------------- done with get data ----------------------------------------- #

		add.s	$f5, $f2, $f3					# add f2 and f3 
		add.s	$f5, $f5, $f4					# add last value
		
		li	$v0, 4						# print_string sys code
		la	$a0, addVal
		syscall

		add.s	$f12, $f5, $f1					# move value to float arg reg

		li	$v0, 2						# print_float syscall
		syscall

# ------------------------------------- done with add data ----------------------------------------- #

		mul.s	$f6, $f2, $f3					# multiply f2 and f3, place in f5
		mul.s	$f6, $f6, $f4					# multiply last value

		li	$v0, 4						# print_string sys code
		la	$a0, multVal
		syscall 

		add.s	$f12, $f6, $f1					# move value to float arg reg

		li, $v0, 2						# print_float syscall
		syscall

# ------------------------------------- done with mult data ---------------------------------------- #

		div.s	$f7, $f5, $f9					# divide added val by float three
	
		li	$v0, 4						# print_string sys code
		la	$a0, aveVal					
		syscall

		add.s	$f12, $f7, $f1					# move value into arg reg 		
		
		li	$v0, 2						# print_float sys code
		syscall

# -------------------------------------- done with ave data ---------------------------------------- #

		c.lt.s	$f3, $f2					# f2 > f3
		bc1t	testFirst					# if true, test f2 > f4
		
		c.lt.s	$f4, $f3					# false, test f3 > f4
		bc1t	secGrt						# if true, f3 greatest val. test lowest branch

		add.s	$f12, $f4, $f1					# false, f4 greatest. Load to print

		li	$v0, 4						# print_string sys code
		la	$a0, highVal					# high value string load
		syscall

		li	$v0, 2						# print_float sys code
		syscall

		li	$v0, 4						# print_string sys code
		la	$a0, lowVal					# low value string load
		syscall
		
		add.s	$f12, $f2, $f1					# load lowest for print

		li	$v0, 2						# print_float sys code
		syscall

		j	done
	
	testFirst:						# test for highest/lowest val
		c.lt.s	$f4, $f2				# f2 > f4

		bc1t	firstGreatest				# f2 is the greatest, branch to test lowest

		add.s	$f12, $f4, $f1				# f4 is the highest, load for print

		li	$v0, 4					# print_string sys code
		la	$a0, highVal				# load address of high val msg
		syscall

		li	$v0, 2					# print_float sys code
		syscall

		li	$v0, 4					# print_string sys code
		la	$a0, lowVal				# load address for low value

		add.s	$f12, $f3, $f1				# move low val to arg field

		li	$v0, 2					# print_float sys code
		syscall
	
		j 	done

	firstGreatest:						# test for the low value f3/f4

		c.lt.s	$f3, $f4				# f4 > f3
		bc1t	secondLowest				# f3 is lowest
		
		add.s	$f12, $f2, $f1				# load highest val for print

		li	$v0, 4					# print_string sys code
		la	$a0, highVal				# load address of high value
		syscall

		li	$v0, 2					# print_float sys code
		syscall

		add.s	$f12, $f4, $f1				# load lowest for print
		
		li	$v0, 4					# print_string sys code
		la	$a0, lowVal				# load address for lowest value msg
		syscall

		li	$v0, 2					# print_float sys code
		syscall

		j	done

	secondLowest:						# procedure for print lowest/highest f3/f2

		add.s	$f12, $f2, $f1				# load highest value
		
		li	$v0, 4					# print_string sys code
		la	$a0, highVal				# load address of high val msg
		syscall

		li	$v0, 2					# print_float
		syscall

		add.s	$f12, $f3, $f1				# load lowest for print

		li	$v0, 4					# print_string sys code
		la	$a0, lowVal				# load address of low val msg
		syscall

		li	$v0, 2					# print_float sys code
		syscall

		j	done
	secGrt:
		c.lt.s	$f4, $f2				# f4 < f2
			
		add.s	$f12, $f3, $f1				# move highest to be printed

		li	$v0, 4					# print_string sys code
		la	$a0, highVal				# load address for high val msg
		syscall

		li	$v0, 2					# print_float sys code
		syscall

		bc1t	thirdLowest				# f4 lowest value, move to print

		add.s	$f12, $f2, $f1				# move lowest val for print

		li	$v0, 4					# print_string sys code
		la	$a0, lowVal				# load low val address
		syscall

		li	$v0, 2					# print_float sys code
		syscall

		j	done

	thirdLowest:
		add.s	$f12, $f4, $f1				# load lowest to print

		li	$v0, 4					# print_string sys code
		la	$a0, lowVal				# load address of low val msg
		syscall

		li	$v0, 2					# print_float sys code
		syscall
# ------------------------------------- done with high/low val ------------------------------------------- #
		

	done:
		li	$v0, 10
		syscall

		
		
