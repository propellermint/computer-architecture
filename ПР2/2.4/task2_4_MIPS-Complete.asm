#Вычислить площадь круга S с радиусом min(А,В).
    #Результат S сохранить в памяти как новую переменную.

.data
	number1: 	.double   20.0 	# first number
	number2: 	.double  19.0   # second number
	pi:		.double	 3.1415926535	
	head1: .asciiz  	"\n The first number is bigger, the area is: \n"
	head2: .asciiz  	"\n The second number is bigger, the area is: \n"
	head3: .asciiz  	"\n Numbers are equal, the area is: \n"


.text
	ldc1 	$f0, number1
	ldc1 	$f2, number2
	ldc1 	$f4, pi
	
	c.eq.d 	$f0, $f2
	bc1t equal
	
	c.le.d $f0, $f2
	bc1t less
	
	bc1f bigger
	#if first number is bigger


	equal:
		la  	$a0, head3
		li	$v0, 4
		syscall
		mul.d $f12, $f0, $f2
		mul.s $f12, $f12, $f4
		li	$v0, 3
		syscall
		
		
	less:
		la  	$a0, head2
		li	$v0, 4
		syscall
		mul.d $f12, $f2, $f2
		mul.d $f12, $f12, $f4
		li	$v0, 3
		syscall
		
	bigger:
		la  	$a0, head1
		li	$v0, 4
		syscall
		mul.d $f12, $f0, $f0
		mul.d $f12, $f12, $f4
		li	$v0, 3
		syscall