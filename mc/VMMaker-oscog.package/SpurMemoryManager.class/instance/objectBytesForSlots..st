object enumeration
objectBytesForSlots: numSlots
	"Answer the total number of bytes in an object with the given
	 number of slots, including header and possible overflow size header."
	self subclassResponsibility