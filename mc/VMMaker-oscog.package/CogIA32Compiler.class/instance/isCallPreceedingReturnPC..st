testing
isCallPreceedingReturnPC: mcpc
	"Assuming mcpc is a return pc answer if the instruction before it is a call."
	^(objectMemory byteAt: mcpc - 5) = 16rE8