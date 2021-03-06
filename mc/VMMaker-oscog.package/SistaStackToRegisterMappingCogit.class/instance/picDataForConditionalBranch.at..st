method introspection
picDataForConditionalBranch: counterReferenceMcpc at: bcpc
	| address counter executedCount tuple untakenCount |
	<var: #counter type: #'unsigned long'>
	tuple := objectMemory
				instantiateClass: (objectMemory splObj: ClassArray)
				indexableSize: 3.
	tuple = 0 ifTrue:
		[^0].
	self assert: CounterBytes = 4.
	address := backEnd counterTargetFromFollowingAddress: counterReferenceMcpc.
	counter := objectMemory longAt: address.
	executedCount := initialCounterValue - (counter >> 16).
	untakenCount := initialCounterValue - (counter bitAnd: 16rFFFF).
	objectMemory
		storePointerUnchecked: 0 ofObject: tuple withValue: (objectMemory integerObjectOf: bcpc);
		storePointerUnchecked: 1 ofObject: tuple withValue: (objectMemory integerObjectOf: executedCount);
		storePointerUnchecked: 2 ofObject: tuple withValue: (objectMemory integerObjectOf: untakenCount).
	^tuple