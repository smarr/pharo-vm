accessing
methodObject: aValue
	^memory
		unsignedLongAt: address + 13
		put: aValue