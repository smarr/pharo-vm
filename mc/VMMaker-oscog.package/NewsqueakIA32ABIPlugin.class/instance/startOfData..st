private-support
startOfData: rcvr "<Alien oop> ^<Integer>"
	"Answer the start of rcvr's data.  For direct aliens this is the address of
	 the second field.  For indirect and pointer aliens it is what the second field points to."
	<inline: true>
	^(self sizeField: rcvr) > 0
	 	ifTrue: [rcvr + BaseHeaderSize + BytesPerOop]
		ifFalse: [self longAt: rcvr + BaseHeaderSize + BytesPerOop]