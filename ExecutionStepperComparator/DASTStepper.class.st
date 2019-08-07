Class {
	#name : #DASTStepper,
	#superclass : #Object,
	#instVars : [
		'dastInterpreter'
	],
	#category : #ExecutionStepperComparator
}

{ #category : #public }
DASTStepper class >> startOn: aBlock [
	^ self new startOn: aBlock
]

{ #category : #accessing }
DASTStepper >> context [
	^ dastInterpreter currentContext
]

{ #category : #'debugger access' }
DASTStepper >> contextStack [
	| cStack |
	cStack := self context senders copy.
	cStack addFirst: self.
	^ cStack
]

{ #category : #accessing }
DASTStepper >> executionFinished [
	^ dastInterpreter isTerminated
]

{ #category : #accessing }
DASTStepper >> node [
	^ dastInterpreter currentNode 
]

{ #category : #accessing }
DASTStepper >> operandStack [
	^ dastInterpreter currentContext stack
]

{ #category : #accessing }
DASTStepper >> selector [
	^ self context selector
]

{ #category : #public }
DASTStepper >> startOn: aBlock [
	dastInterpreter := DASTInterpreter new.
	dastInterpreter initializeWithProgram: (RBParser parseExpression: aBlock sourceNode sourceCode, ' value').
	dastInterpreter stepOver; stepInto. 
	^ self
]

{ #category : #accessing }
DASTStepper >> step [
	dastInterpreter stepInto
]
