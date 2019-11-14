main		mov		r0, #8 ; n
		ldr		r1, =0x100 ; head of array
		ldr		r5, =3 ; a[0]
		str		r5, [r1]
		ldr		r5, =2 ; a[1]
		str		r5, [r1, #4]
		ldr		r5, =16 ; a[2]
		str		r5, [r1, #8]
		ldr		r5, =-3 ; a[3]
		str		r5, [r1, #12]
		ldr		r5, =-9 ; a[4]
		str		r5, [r1, #16]
		ldr		r5, =10 ; a[5]
		str		r5, [r1, #20]
		ldr		r5, =45 ; a[6]
		str		r5, [r1, #24]
		ldr		r5, =-9 ; a[7]
		str		r5, [r1, #28]
		stmfd	r13!, {r1,r0}
		bl		find
		ldmfd	r13!, {r11, r10}
		ldmfd	r13!, {r0, r1}
		end
		
find		ldmfd	r13, {r0,r1}
		ldr		r6, [r1], #4
		mov		r10, r6 ; min
		mov		r11, r6 ; max
		sub		r0, r0, #1
again	cmp		r0, #0
		beq		return
		sub		r0, r0, #1
		ldr		r6, [r1], #4
		cmp		r6, r11
		bge		ge
		cmp		r6, r10
		ble		le
		b		again
ge		mov		r11, r6
		b		again
le		mov		r10, r6
		b		again
return	stmfd	r13!, {r10,r11}
		mov		pc, lr
