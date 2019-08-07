Class {
	#name : #ExampleExecutions,
	#superclass : #Object,
	#category : #ExecutionStepperComparator
}

{ #category : #'as yet unclassified' }
ExampleExecutions >> exCallMethodWithArgumentsAndTemporaryVariables [
	^ [ ExampleExecutions new method1: 4 with: 5 ]
]

{ #category : #'as yet unclassified' }
ExampleExecutions >> exPointNew [
	^ [ Point new ]
]

{ #category : #'as yet unclassified' }
ExampleExecutions >> method1: arg1 with: arg2 [
	|temp1 temp2|
	temp1 := arg1.
	temp2 := arg2.
	Point new.
]

{ #category : #'as yet unclassified' }
ExampleExecutions >> setUpExCallMethodWithArgumentsAndTemporaryVariables [
	| block bs ds |
	block := ExampleExecutions new exCallMethodWithArgumentsAndTemporaryVariables.

	bs := BytecodeStepper startOn: block.
	ds := DASTStepper startOn: block.

	[bs selector = #method1:with:] whileFalse: [ bs step ].
	[ds selector = #method1:with:] whileFalse: [ ds step ].
	^ { bs. ds. }
]

{ #category : #'as yet unclassified' }
ExampleExecutions >> setUpExPointNew [
	| block bs ds |
	block := ExampleExecutions new exPointNew.

	bs := BytecodeStepper startOn: block.
	ds := DASTStepper startOn: block.

	^ { bs. ds. }
]
