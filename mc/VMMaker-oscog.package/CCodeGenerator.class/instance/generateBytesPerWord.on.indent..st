C translation
generateBytesPerWord: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: 'BytesPerWord'