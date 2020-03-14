# TO CHECK THE DIVISIBILITY OF TWO NUMBERS

	.data
MEM1: .word   220 	# number
MEM2: .word   2        	# i'th bit
head1: .asciiz  	"The first number is divisible by the second number\n"
head2: .asciiz  	"The first number is NOT divisible by the second number\n"

	.text
la   	$t1, MEM1        	# load address of the first number to register $t1
lw   	$t1, 0($t1)      	# load the first number to register $t1(базовая адресация Адр=0+$t1)
lw	$t2, MEM2 	       	# load the second number to register $t2-псевдоинструкция



la   	$a0, 1		       	# load address of print heading 'NOT DIV'
li   	$v0, 1           	# specify Print String service=load immidiate 4to register $v0
j print_h             		# Jump unconditionally to statement at target address

met_div:
	la  	$a0, head1	# load address of print heading 'DIVISABLE'
	li   	$v0, 4          # specify Print String service

print_h:
	syscall			# printheading

# две строки, выделенные жёлтым, можно заменить на одну:  
#remu $t3,$t1,$t2		#REMainder : Set $t3to (remainder of $t1divided by $t2, unsigned division)