#Вычислить площадь круга S с радиусом min(А,В).
    #Результат S сохранить в памяти как новую переменную.

.data
MEM1: .word   77 	# first number
MEM2: .word   1        # количество сдвигов
MEM3: .word   1        # 0 - влево, 1 - вправо 
head1: .asciiz  	"the last shifted bit was 0\n"
head2: .asciiz  	"the last shifted bit was 1\n"
head3: .asciiz  	"The result of program\n"
head4: .asciiz  	"TATA\n"

	.text
la   	$t1, MEM1        	# load address of the first number to register $t1
lw   	$t1, 0($t1)      	# load the first number to register $t1(базовая адресация Адр=0+$t1)
lw	$t2, MEM2        	# load the second number to register $t2-псевдоинструкция
lw	$t3, MEM3        	# load the second number to register $t2-псевдоинструкция

bne	$t3,$zero,met_one 	# Branch if equal : Branch to statement at label's address if $t3 and NULLregister $zeroare equal
add	$t4, $t1, $zero
sub	$t5, $t2, 32
li	$t6, 1
sllv	$t6, $t6,$t5
and 	$t1,$t1,$t6  	
sllv 	$t4, $t4,$t1
beq 	$t1, $zero, print_zero
la  	$a0, head2	# load address of print heading 'DIVISABLE'
li   	$v0, 4
j print_h


met_one:
	add	$t4, $t1, $zero
	sub	$t5, $t2, 1
	li	$t6, 1
	sllv	$t6, $t6,$t5
	and 	$t1,$t1,$t6  	
	srlv 	$t4, $t4,$t1
	beq 	$t1, $zero, print_zero
	la  	$a0, head2	# load address of print heading 'DIVISABLE'
	li   	$v0, 4
	j print_h
	#li   	$v0, 1          # specify Print String service
	 


print_zero:
	la  	$a0, head1	# load address of print heading 'DIVISABLE'
	li   	$v0, 4          # specify Print String service
	j print_h 




	
print_h:
	syscall			# printheading
	add	$a0, $t4, $0	# load address of print heading 'DIVISABLE'
	li	$v0, 1
	syscall
# две строки, выделенные жёлтым, можно заменить на одну:  
#remu $t3,$t1,$t2		#REMainder : Set $t3to (remainder of $t1divided by $t2, unsigned division)
