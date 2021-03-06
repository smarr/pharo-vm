method prototypes
BehaviorPROTOTYPEbasicNew: sizeRequested 
	"Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive.
	
	 If the primitive fails because space is low then the scavenger will run before the
	 method is activated.  Check arguments and retry via failingBasicNew: if they're OK."

	<primitive: 71>
	self isVariable ifFalse:
		[self error: self printString, ' cannot have variable sized instances'].
	(sizeRequested isInteger and: [sizeRequested >= 0]) ifTrue:
		["arg okay; space must have been low, and the scavenger must have run.
		  retry after the scavenge"
		^self handleFailingBasicNew: sizeRequested].
	self primitiveFailed