translation
translateInDirectory: directory doInlining: inlineFlag
"This is the default method for writing out sources for a plugin. Several classes need special handling, so look at all implementors of this message"
	| cg fname fstat reference |
	 fname := self moduleName, '.c'.

	"don't translate if the file is newer than my timeStamp"
	reference := directory asFileReference / name.
	fstat := reference exists ifTrue: [ reference entry ] ifFalse: [nil].
	fstat ifNotNil:
		[((self pluginClassesUpTo: self) allSatisfy:
				[ :aPluginClass| aPluginClass timeStamp < fstat modificationTime asSeconds ]) ifTrue:
			[^nil]].

	self initialize.
	cg := self buildCodeGeneratorUpTo: self.
	cg storeCodeOnFile:  (directory asFileReference / fname) fullName doInlining: inlineFlag.
	^cg exportedPrimitiveNames asArray