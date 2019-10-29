		MOV		R0, #0x100
		MOV		R1, #0
AGAIN	ADD		R1, R1, #1
		STRB		R1, [R0]
		ADD		R0, R0, #1
		CMP		R1, #9
		BNE		AGAIN
		END
