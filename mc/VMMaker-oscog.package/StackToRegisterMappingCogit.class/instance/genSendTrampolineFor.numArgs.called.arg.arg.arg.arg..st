initialization
genSendTrampolineFor: aRoutine numArgs: numArgs called: aString arg: regOrConst0 arg: regOrConst1 arg: regOrConst2 arg: regOrConst3
	"Generate a trampoline with four arguments.
	 Hack: a negative value indicates an abstract register, a non-negative value indicates a constant."
	<var: #aRoutine type: #'void *'>
	<var: #aString type: #'char *'>
	| startAddress |
	<inline: false>
	startAddress := methodZoneBase.
	opcodeIndex := 0.
	self genPushRegisterArgsForNumArgs: numArgs.
	self genTrampolineFor: aRoutine
		called: aString
		callJumpBar: true
		numArgs: 4
		arg: regOrConst0
		arg: regOrConst1
		arg: regOrConst2
		arg: regOrConst3
		saveRegs: false
		resultReg: nil
		appendOpcodes: true.
	^startAddress