message sending
newspeakSuperclassSend
"Send a message to self, starting lookup in the superclass of the method application of the currently executing method's mixin."
"Assume: messageSelector and argumentCount have been set, and that the receiver and arguments have been pushed onto the stack," 
"WE WANT THE RECEIVER PUSHED IMPLICITLY"
"Note: This method is inlined into the interpreter dispatch loop."
	| rcvr mClassMixin mixinApplication |
	<inline: true>
	rcvr := self internalStackValue: argumentCount.
	mClassMixin := self methodClassOf: method.
	mixinApplication := self 
		findApplicationOfTargetMixin: mClassMixin
		startingAtBehavior: (self fetchClassOf: rcvr).
	lkupClass := self superclassOf: mixinApplication.
	self commonSend