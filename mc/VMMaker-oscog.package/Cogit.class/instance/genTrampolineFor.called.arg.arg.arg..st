initialization
genTrampolineFor: aRoutine called: aString arg: regOrConst0 arg: regOrConst1 arg: regOrConst2
	"Generate a trampoline with three arguments.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	^self
		genTrampolineFor: aRoutine
		called: aString
		callJumpBar: true
		numArgs: 3
		arg: regOrConst0
		arg: regOrConst1
		arg: regOrConst2
		arg: nil
		saveRegs: false
		resultReg: nil
		appendOpcodes: false