!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:01:46'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:01:31'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:01:59'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:06'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:14'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 

	! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.

	! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:29'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:35'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:40'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'AM 10/4/2020 18:02:45'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Node category: 'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #EmptyNode category: 'Stack-Exercise'!
Node subclass: #EmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:02:27'!
isEmpty

	^true.! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:31:36'!
previous

	! !


!classDefinition: #ValidNode category: 'Stack-Exercise'!
Node subclass: #ValidNode
	instanceVariableNames: 'previousNode storedObject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidNode methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 18:52:59'!
initializeWith: objectToStore asChildOf: parentNode

	storedObject  := objectToStore.
	previousNode := parentNode.! !

!ValidNode methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:02:08'!
isEmpty
	
	^false.! !

!ValidNode methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:01:11'!
previous
	
	^previousNode.! !

!ValidNode methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:07:51'!
storedObject

	^storedObject copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidNode class' category: 'Stack-Exercise'!
ValidNode class
	instanceVariableNames: ''!

!ValidNode class methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:17:15'!
with: objectToStore asChildOf: parentNode

	^self new initializeWith: objectToStore asChildOf: 	parentNode. ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:28:58'!
initialize
	
	top := EmptyNode new.
	size := 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:03:37'!
isEmpty
	
	^top isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:57:20'!
pop
	
	|poppedTop|
	
	top isEmpty ifTrue: [^self error: self class stackEmptyErrorDescription].
	
	poppedTop := top.
	top := poppedTop previous.
	size := size - 1.
	
	^poppedTop storedObject. ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:28:52'!
push: objectToStore

	|newTop|
	
	newTop := ValidNode with: objectToStore asChildOf: top.
	
	top := newTop. 
	size := size + 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:30:10'!
size 

	^size copy.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'AM 10/4/2020 19:46:19'!
top
	
	top isEmpty ifTrue: [^self error: self class stackEmptyErrorDescription].
	^top storedObject. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'AM 10/4/2020 18:09:29'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
