C code generation
emitCCodeAsFunctionCallOn: aStream level: level generator: aCodeGen

	"Translate this message send into a C function call"
	"Special case for pluggable modules. Replace messages to interpreterProxy
	 by interpreterProxy->message(..) if the message is not builtin"
	(aCodeGen messageReceiverIsInterpreterProxy: self) ifTrue:
		[(aCodeGen noteUsedPluginFunction: selector) ifTrue:
			[aStream nextPutAll: 'interpreterProxy->']].
	"Translate this message send into a C function call."
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector); nextPut: $(.
	"Only include the receiver as the first argument in certain cases.
	 The receiver is always included if it is an expression.
	 If it is a variable:
		 If the vmClass says it is an implicit variable, don't include it.
		 If the variable is 'self' and the method being called is not in
		 the method set (i.e. it is some external code), don't include it."
	(self shouldExcludeReceiverAsFirstArgument: aCodeGen) ifFalse:
		[receiver emitCCodeOn: aStream level: level generator: aCodeGen.
		 arguments isEmpty ifFalse:
			[aStream nextPutAll: ', ']].
	arguments
		do: [ :arg| arg emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen]
		separatedBy: [aStream nextPut: $,; space].
	aStream nextPut: $)