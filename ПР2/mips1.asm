.data

aa: .asciiz		"Hello world\n"

.text 
la	$a0,aa     	# load address of string �������-����������
li	$v0,4        	# specify Print String service�������-����������
syscall			# outputstring���������� ������
