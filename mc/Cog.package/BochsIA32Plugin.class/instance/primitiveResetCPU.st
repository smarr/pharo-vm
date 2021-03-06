primitives
primitiveResetCPU
	| cpuAlien cpu maybeErr |
	<var: #cpu type: 'void *'>
	cpuAlien := self primitive: #primitiveResetCPU parameters: #() receiver: #Oop.
	(cpu := self startOfData: cpuAlien) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	maybeErr := self resetCPU: cpu.
	maybeErr ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	^cpuAlien