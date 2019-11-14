main		mov		r0, #8 ; n
		ldr		r5, =3 ; a[0]
		str		r5, [r13, #-4]
		ldr		r5, =2 ; a[1]
		str		r5, [r13, #-4]!
		ldr		r5, =16 ; a[2]
		str		r5, [r13, #-4]!
		ldr		r5, =-3 ; a[3]
		str		r5, [r13, #-4]!
		ldr		r5, =-9 ; a[4]
		str		r5, [r13, #-4]!
		ldr		r5, =10 ; a[5]
		str		r5, [r13, #-4]!
		ldr		r5, =45 ; a[6]
		str		r5, [r13, #-4]!
		ldr		r5, =-9 ; a[7]
		str		r5, [r13, #-4]!
		stmfd	r13!, {r0}
		bl		find
		ldmfd	r13!, {r11, r10}
		end
		
find		ldmfd	r13!, {r8}
		ldmfd	r13!, {r6}
		mov		r1, r6 ; min
		mov		r2, r6 ; max
		sub		r8, r8, #1
again	cmp		r8, #0
		beq		return
		sub		r8, r8, #1
		ldmfd	r13!, {r6}
		cmp		r6, r2
		bge		ge
		cmp		r6, r1
		ble		le
		b		again
ge		mov		r2, r6
		b		again
le		mov		r1, r6
		b		again
return	stmfd	r13!, {r1,r2}
		mov		pc, lr
