indexing primitives
primitiveFloatAtPut
	"Provide platform-independent access to 32-bit words comprising
	 a Float.  Map index 1 onto the most significant word and index 2
	 onto the least significant word."
	| rcvr index oopToStore valueToStore |
	<var: #result type: #usqInt>
	self initPrimCall.
	oopToStore := self stackTop.
	valueToStore := self positive32BitValueOf: oopToStore.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 2.
	index := self stackValue: 1.
	index = ConstOne ifTrue:
		[objectMemory storeLong32: (VMBIGENDIAN ifTrue: [0] ifFalse: [1])
			ofObject: rcvr
			withValue: valueToStore.
		^self pop: 3 thenPush: oopToStore].
	index = ConstTwo ifTrue:
		[objectMemory storeLong32: (VMBIGENDIAN ifTrue: [1] ifFalse: [0])
			ofObject: rcvr
			withValue: valueToStore.
		^self pop: 3 thenPush: oopToStore].
	self primitiveFailFor: ((objectMemory isIntegerObject: index)
							ifTrue: [PrimErrBadIndex]
							ifFalse: [PrimErrBadArgument])