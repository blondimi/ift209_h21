foo:
	mv	a5, a0
	beqz	a0, fin
	li	a0, 0
debut:
	add	a0, a0, a5
	addi    a5, a5, -1
	bnez	a5, debut
	ret
fin:
	ret
