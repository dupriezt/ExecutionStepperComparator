Class {
	#name : #BytecodeStepper,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : #ExecutionStepperComparator
}

{ #category : #public }
BytecodeStepper class >> startOn: aBlock [
	^ self new startOn: aBlock
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> context [
	^ process suspendedContext
]

{ #category : #public }
BytecodeStepper >> executionFinished [
	^ self context method selector = #newProcess.
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> methodBytecode [
	^ process suspendedContext method bytecode
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> node [
	"Current ast node the execution is at"
	^ process suspendedContext method sourceNodeForPC: process suspendedContext pc.
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> operandStack [
	| stack |
	stack := OrderedCollection new.
	(self context tempNames size + 1) to: self context size do: [:int | stack add: (self context at: int)  ].
	^ stack.
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> pc [
	^ process suspendedContext pc
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> process [
	^ process
]

{ #category : #accessing }
BytecodeStepper >> selector [
	^ self context method selector
]

{ #category : #public }
BytecodeStepper >> startOn: aBlock [
	process := aBlock newProcess name: 'BytecodeExecProcess'.
	self step; step. "To leave method #newProcess and reach the start of the execution of the code inside aBlock"
	^ self
]

{ #category : #'stepping and presenter' }
BytecodeStepper >> step [
	process step
]
