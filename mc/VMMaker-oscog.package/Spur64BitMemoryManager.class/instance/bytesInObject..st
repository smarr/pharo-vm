object enumeration
bytesInObject: objOop
	"Answer the total number of bytes in an object including header and possible overflow size header."
	| header headerNumSlots numSlots |
	self flag: #endianness.
	header := self longAt: objOop.
	headerNumSlots := header >> self numSlotsFullShift bitAnd: self numSlotsMask.
	numSlots := headerNumSlots = self numSlotsMask
					ifTrue: [header bitAnd: 16rFFFFFFFFFFFFFF]
					ifFalse: [headerNumSlots = 0 ifTrue: [1] ifFalse: [headerNumSlots]].
	^numSlots << self shiftForWord
	+ (headerNumSlots = self numSlotsMask
		ifTrue: [self baseHeaderSize + self baseHeaderSize]
		ifFalse: [self baseHeaderSize])