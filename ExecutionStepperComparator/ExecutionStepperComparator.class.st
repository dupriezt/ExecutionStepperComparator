Class {
	#name : #ExecutionStepperComparator,
	#superclass : #Object,
	#instVars : [
		'dastStepper',
		'btcdNodes',
		'dastNodes',
		'btcdStepper',
		'btcdOperandStacks',
		'dastOperandStacks',
		'btcdContextStacks',
		'dastContextStacks'
	],
	#category : #ExecutionStepperComparator
}

{ #category : #callMethodWithArgumentsAndTemporaryVariables }
ExecutionStepperComparator class >> exCallMethodWithArgumentsAndTemporaryVariables [
	^ [ ExecutionStepperComparator method1: 4 with: 5 ]
]

{ #category : #ifTrueIfFalse }
ExecutionStepperComparator class >> exIfTrueIfFalse [
	^ [ false ifTrue: ['true'] ifFalse: [ 'false' ] ]
]

{ #category : #pointNew }
ExecutionStepperComparator class >> exPointNew [
	^ [ Point new ]
]

{ #category : #callMethodWithArgumentsAndTemporaryVariables }
ExecutionStepperComparator class >> method1: arg1 with: arg2 [
	|temp1 temp2|
	temp1 := arg1.
	temp2 := arg2.
	Point new.
]

{ #category : #callMethodWithArgumentsAndTemporaryVariables }
ExecutionStepperComparator class >> runCallMethodWithArgumentsAndTemporaryVariables [
	<script>
	| block btcd dast comparator |
	block := ExecutionStepperComparator exCallMethodWithArgumentsAndTemporaryVariables.
	btcd := BytecodeStepper startOn: block.
	dast := DASTStepper startOn: block.
	[btcd selector = #method1:with:] whileFalse: [ btcd step ].
	[dast selector = #method1:with:] whileFalse: [ dast step ].
	
	comparator := self new compare: btcd with: dast.
	comparator inspect; inspect.
	
]

{ #category : #callMethodWithArgumentsAndTemporaryVariables }
ExecutionStepperComparator class >> runIfTrueIfFalse [
	<script>
	| block btcd dast comparator |
	block := ExecutionStepperComparator exIfTrueIfFalse.
	btcd := BytecodeStepper startOn: block.
	dast := DASTStepper startOn: block.
	
	comparator := self new compare: btcd with: dast.
	comparator inspect; inspect.
	
]

{ #category : #callMethodWithArgumentsAndTemporaryVariables }
ExecutionStepperComparator class >> runPointNew [
	<script>
	| block btcd dast comparator |
	block := ExecutionStepperComparator exPointNew.
	btcd := BytecodeStepper startOn: block.
	dast := DASTStepper startOn: block.
	
	comparator := self new compare: btcd with: dast.
	comparator inspect; inspect.
	
]

{ #category : #pointNew }
ExecutionStepperComparator class >> setUpExPointNew [
	| block bs ds |
	block := ExecutionStepperComparator new exPointNew.

	bs := BytecodeStepper startOn: block.
	ds := DASTStepper startOn: block.

	^ { bs. ds. }
]

{ #category : #testing }
ExecutionStepperComparator >> compare: aBytecodeStepper with: aDASTStepper [
	btcdStepper := aBytecodeStepper.
	dastStepper := aDASTStepper.
	btcdNodes := OrderedCollection new.
	dastNodes := OrderedCollection new.
	btcdOperandStacks := OrderedCollection new.
	dastOperandStacks := OrderedCollection new.
	btcdContextStacks := OrderedCollection new.
	dastContextStacks := OrderedCollection new.
	
	[ btcdStepper executionFinished ] whileFalse: [
		btcdNodes add: btcdStepper node.
		btcdOperandStacks add: btcdStepper operandStack copy.
		btcdContextStacks add: btcdStepper contextStack copy.
		btcdStepper step ].
	[ dastStepper executionFinished ] whileFalse: [
		dastNodes add: dastStepper node.
		dastOperandStacks add: dastStepper operandStack copy.
		dastContextStacks add: dastStepper contextStack copy.
		dastStepper step ].

	^ self
	
	
]
