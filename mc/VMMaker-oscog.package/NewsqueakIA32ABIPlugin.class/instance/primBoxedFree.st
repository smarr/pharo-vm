primitives-memory management
primBoxedFree
	"Free the memory referenced by the receiver, an Alien."
	"proxy <Alien> primFree ^<Alien>
		<primitive: 'primBoxedFree' error: errorCode module: 'IA32ABI'>"
	| addr rcvr ptr sizeField |
	<export: true>
	<var: #ptr type: 'sqInt *'>
	<var: #sizeField type: 'long'>

	rcvr := interpreterProxy stackObjectValue: 0.
	(interpreterProxy byteSizeOf: rcvr) >= 2 * BytesPerOop ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	ptr := interpreterProxy firstIndexableField: rcvr.
	sizeField := ptr at: 0.
	addr := ptr at: 1.
	"Don't you dare to free Squeak's memory!"
	(sizeField >= 0 or: [addr = 0 or: [interpreterProxy isInMemory: addr]]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	self cCode: 'free((void *)addr)'
		inSmalltalk: [self Cfree: addr].
	ptr
		at: 0 put: 0;
		at: 1 put: 0 "cleanup"