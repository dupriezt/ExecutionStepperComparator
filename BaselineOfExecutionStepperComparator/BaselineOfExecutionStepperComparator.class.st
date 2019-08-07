Class {
	#name : #BaselineOfExecutionStepperComparator,
	#superclass : #BaselineOf,
	#category : #BaselineOfExecutionStepperComparator
}

{ #category : #baselines }
BaselineOfExecutionStepperComparator >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'DebuggableASTInterpreter'
					with:
						[ spec repository: 'github://dupriezt/DebuggableASTInterpreter' ];
				package: 'ExecutionStepperComparator' ]
]
