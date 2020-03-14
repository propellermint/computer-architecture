.data

aa: .asciiz		"Hello world\n"

.text 
la	$a0,aa     	# load address of string –псевдо-инструкция
li	$v0,4        	# specify Print String service–псевдо-инструкция
syscall			# outputstring–системный сервис
