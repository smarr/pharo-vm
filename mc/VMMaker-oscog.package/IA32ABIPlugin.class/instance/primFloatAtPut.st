primitives-accessing
primFloatAtPut
	"Store a float into 32 bits starting at the given byte offset (little endian)."
	"<Alien> floatAt: index <Integer> put: value <Float | Integer> ^<Float | Integer>
		<primitive: 'primFloatAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr valueOop floatValue |
	<export: true>
	<var: #floatValue type: #float>

	valueOop := interpreterProxy stackValue: 0.
	(interpreterProxy isIntegerObject: valueOop)
		ifTrue:[floatValue := self cCoerce: (interpreterProxy integerValueOf: valueOop) to: #double]
		ifFalse:[floatValue := self cCoerce: (interpreterProxy floatValueOf: valueOop) to: #double].
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 4 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	self cCode:'((long *)addr)[0] = ((long *)(&floatValue))[0]'.
	interpreterProxy methodReturnValue: valueOop