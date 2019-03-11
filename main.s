.syntax unified

.word 0x20000100
.word _start

.global _start
.type _start, %function
_start:
	//
	//mov # to reg
	//
	mov	r0,	#1
	mov	r1,	#2
	mov	r2,	#3

	//	
	//push and pop
	//
	push	{r0, r1, r2}
	pop	{r3, r4, r5}

	//reset
	mov	r0,	#0
	mov	r1,	#0
	mov	r2,	#0
	mov	r3,	#0
	mov	r4,	#0
	mov	r5,	#0
//=======================================
	//
	//mov # to reg
	//
	mov	r0,	#1
	mov	r1,	#2
	mov	r2,	#3

	//
	//push and pop
	//
	push	{r2, r0, r1}
	pop	{r3, r4, r5}
