Sort		STR		R2,		[SP, #-4]
		CMP		R0,		R1
		MOVGT	R2,		R1
		MOVGT	R1,		R0
		MOVGT	R0,		R2
		LDR		R2,		[SP],	#4
		MOV		PC,		LR
