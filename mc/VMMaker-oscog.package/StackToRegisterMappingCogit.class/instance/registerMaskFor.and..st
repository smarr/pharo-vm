simulation stack
registerMaskFor: reg1 and: reg2
	"Answer a bit mask identifying the symbolic registers.
	 Registers are negative numbers."
	^1 << (1 - reg1) bitOr: 1 << (1 - reg2)