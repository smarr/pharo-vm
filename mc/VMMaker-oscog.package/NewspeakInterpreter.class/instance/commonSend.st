message sending
commonSend
	"Send a message, starting lookup with the receiver's class."
	"Assume: messageSelector and argumentCount have been set, and that 
	the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	<sharedCodeNamed: 'commonSend' inCase: #singleExtendedSendBytecode>
	self fastLogSend: messageSelector.
	self sendBreak: messageSelector + BaseHeaderSize
		point: (self lengthOf: messageSelector)
		receiver: (self internalStackValue: argumentCount).
	self internalFindNewMethod.
	self internalExecuteNewMethod.
	self fetchNextBytecode