!classDefinition: #NodeTest category: 'StackPrimeraParte'!
TestCase subclass: #NodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!NodeTest methodsFor: 'tests' stamp: 'AER 10/8/2022 11:31:48'!
test01nodeIsCreated
	|aNode|
	aNode := Node new: 'soy un cinco'.
	self assert: ((aNode value ) = 'soy un cinco').! !

!NodeTest methodsFor: 'tests' stamp: 'AER 10/8/2022 12:22:40'!
test02AddingNodes
	|root child|
	root := Node new: 'soy Root'.
	child := Node new: 'soy Childish'.
	root linkSuccessor: child.
	self assert: (root successor value) = 'soy Childish'.
	
	! !


!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'as yet unclassified' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AER 10/8/2022 13:26:33'!
test02StackShouldBeAbleToPush
	|stack aCount|
	stack := Stack new.
	stack push: 'tiburoncin uh haha'.
	aCount := stack count .
	self assert: ((stack count) = 1).
	! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AER 10/8/2022 13:46:32'!
test03StackShouldBeAbleToPop
	|stack|
	stack := Stack new.
	stack push: 'tiburon 1'.
	stack push: 'tiburon 2'.
	stack push: 'tiburon 3'.
	
	self assert: ((stack pop = 'tiburon 3') and: [stack pop = 'tiburon 2'] and: [stack pop = 'tiburon 1'] and: [stack count = 0]).! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'AER 10/8/2022 13:48:36'!
test04StackShouldBeAbleToTop
	|stack|
	stack := Stack new.
	stack push: 'tiburon 1'.
	stack push: 'tiburon 2'.
	stack push: 'tiburon 3'.
	self assert: (( stack top = 'tiburon 3' ) and: [ stack count = 3]).! !


!classDefinition: #Node category: 'StackPrimeraParte'!
Object subclass: #Node
	instanceVariableNames: 'value predecessor successor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Node methodsFor: 'initializer' stamp: 'AER 10/8/2022 12:18:30'!
newValue: Value
	value := Value.
	successor := nil.
	^self.
	! !


!Node methodsFor: 'value' stamp: 'AER 10/8/2022 12:19:24'!
successor
	^successor.! !

!Node methodsFor: 'value' stamp: 'AER 10/8/2022 11:01:59'!
value
	^value. ! !


!Node methodsFor: 'links' stamp: 'AER 10/8/2022 12:21:48'!
linkSuccessor: aNode
	((aNode isKindOf: Node) or: [aNode = nil]) ifTrue: [
		successor := aNode.
		^self.	
	]. 

	^self error: 'Message linkSuccessor only accepts either Node or nil elements.'.! !

!Node methodsFor: 'links' stamp: 'AER 10/8/2022 11:48:57'!
unLinkSuccessor
	predecessor := nil. 
	^self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Node class' category: 'StackPrimeraParte'!
Node class
	instanceVariableNames: ''!

!Node class methodsFor: 'as yet unclassified' stamp: 'AER 10/8/2022 10:58:57'!
new: value
	| newNode |
	newNode := Node new. 
	newNode newValue: value.
	^newNode.! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'topNode numberOfElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'initialize' stamp: 'AER 10/8/2022 13:25:18'!
count
	^numberOfElements.
	! !

!Stack methodsFor: 'initialize' stamp: 'AER 10/8/2022 13:30:56'!
initialize
	topNode := nil.
	numberOfElements := 0.! !

!Stack methodsFor: 'initialize' stamp: 'AER 10/8/2022 13:29:00'!
newStack
	topNode := nil.
	numberOfElements := 0.! !


!Stack methodsFor: 'stackPrimitives' stamp: 'AER 10/8/2022 13:40:45'!
pop
	"En este metodo se borra el primer elemento del stack, y se devuelve el valor de dicho elemento."
	|successor|
	(topNode = nil) ifTrue: [
		^nil.
	].
	successor := 		topNode.
	topNode := successor successor.
	numberOfElements := numberOfElements -1.
	^successor value.! !

!Stack methodsFor: 'stackPrimitives' stamp: 'AER 10/8/2022 13:35:24'!
push: aValue
	|successor|
	( topNode = nil ) ifTrue: [
		topNode := Node new: aValue.
		numberOfElements := numberOfElements  + 1.
		^self.
	].
	
	successor := topNode.
	topNode := Node new: aValue.
	topNode linkSuccessor: successor. 
	numberOfElements := numberOfElements  + 1.
	^self.! !

!Stack methodsFor: 'stackPrimitives' stamp: 'AER 10/8/2022 12:29:45'!
top
	^topNode value.! !


!Stack methodsFor: 'checkings' stamp: 'AER 10/8/2022 13:13:57'!
isEmpty
	^topNode = nil.! !
