.text
.globl __start

__start:
la $a0,txtM
li $v0,4
syscall
li $v0,5
syscall

add $a1,$v0,$zero # a1 M

la $a0,txtQ
li $v0,4
syscall
li $v0,5
syscall

add $a0,$v0,$zero # a0 Q
addi $t0,$zero,0 # t0 A
addi $t1,$zero,0 # t1 Q1
addi $s1,$zero,32 # counter

loop:
beq $s1,$zero,end # check
andi $t2,$a0,1 # t2 Q0
beq $t1,$t2,ASR
blt $t2,$t1,AplusM
blt $t1,$t2,AminusM

ASR:
andi $t1,$a0,1 # new Q1
srl $a0,$a0,1 # right shift Q
andi $t3,$t0,1 # tmp A0
sll $t3,$t3,31 # flip A0
or $a0,$a0,$t3 # new Q
andi $t4,$t0,-2147483648 # MSB of A
srl $t0,$t0,1 # right shift A
or $t0,$t0,$t4 # correct A
sub $s1,$s1,1 # counter - 1
j loop

AplusM:
add $t0,$t0,$a1
j ASR

AminusM:
sub $t0,$t0,$a1
j ASR

end:
# result move
move $v1,$a0
move $a1,$t0

la $a0,txtReg
li $v0,4
syscall
addi $a0,$a1,0
li $v0,1
syscall
la $a0,endl
li $v0,4
syscall
addi $a0,$v1,0
li $v0,1
syscall
#addi $

li $v0,10
syscall

.data
txtM: .asciiz "Ingresar multiplicando(M): "
txtQ: .asciiz "Ingresar multiplicador(Q): "
txtReg: .asciiz "Resultados en registros $a1 y $v1:\n"
endl: .asciiz "\n"