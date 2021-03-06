object format
firstIndexableField: oop
	"NOTE: overridden in various simulator subclasses to add coercion to CArray, so please duplicate any changes"
	| hdr fmt totalLength fixedFields |
	<returnTypeC: #'void *'>
	hdr := self baseHeader: oop.
	fmt := self formatOfHeader: hdr.
	fmt <= 4 ifTrue: "<= 4 pointer"
		["pointer; may need to delve into the class format word"
		totalLength := self lengthOf: oop baseHeader: hdr format: fmt.
		fixedFields := self fixedFieldsOf: oop format: fmt length: totalLength.
		^self pointerForOop: oop + BaseHeaderSize + (fixedFields << ShiftForWord)].
	^self pointerForOop: oop + BaseHeaderSize