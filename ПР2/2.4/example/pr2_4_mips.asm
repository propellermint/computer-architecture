.data

aa: .float 22.1
bb: .float 33.7
Sum: .float 0.0
head_A: .asciiz 	"\n A=\0"
head_B: .asciiz 	"\n B=\0"
head_Sum: .asciiz 	"\n Sum A+B=\0"

.text

la $a0, head_A 		# load address of print heading
li $v0, 4 		# specify Print String service
syscall 		# print head_A
lwc1 $f1, aa 		# load number A from memory in register $f1
lwc1 $f12, aa 		# load number A from memory in register $f12 for printing
li $v0, 2 		# specify Print Float service
syscall 		# print float A (from $f12)
la $a0, head_B 		# load address of print heading
li $v0, 4 		# specify Print String service
syscall 		# print head_B
lwc1 $f2, bb 		# load number B from memory in register $f2
lwc1 $f12, bb 		# load number B from memory in register $f12 for printing
li $v0, 2 		# specify Print Float service
syscall 		# print float B (from $f12)
add.s $f12, $f2, $f1, 	# calculate $f3=$f1+$f2
swc1 $f12, Sum
la $a0, head_Sum 	# load address of head_Sum
li $v0, 4 		# specify Print String service
syscall 		# print head_Sunm
li $v0, 2 		# specify Print Float service

syscall 		# print Sum number