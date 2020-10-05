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

!Node methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:41:06'!
previousIfNone: blockToExecuteIfNone
	
	self subclassResponsibility.! !

!Node methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:40:35'!
storedObjectIfNone: blockToExecuteIfNone

	self subclassResponsibility.! !


!Node methodsFor: 'testing' stamp: 'AM 10/5/2020 16:40:03'!
isEmpty
	
	self subclassResponsibility. ! !


!classDefinition: #EmptyNode category: 'Stack-Exercise'!
Node subclass: #EmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyNode methodsFor: 'testing' stamp: 'AM 10/4/2020 19:02:27'!
isEmpty

	^true.! !


!EmptyNode methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:20:56'!
previousIfNone: blockToExecuteIfNone

	^blockToExecuteIfNone value.

	! !

!EmptyNode methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:21:54'!
storedObjectIfNone: blockToExecuteIfNone

	^blockToExecuteIfNone value.! !


!classDefinition: #ValidNode category: 'Stack-Exercise'!
Node subclass: #ValidNode
	instanceVariableNames: 'previousNode storedObject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidNode methodsFor: 'initialization' stamp: 'AM 10/4/2020 18:52:59'!
initializeWith: objectToStore asChildOf: parentNode

	storedObject  := objectToStore.
	previousNode := parentNode.! !


!ValidNode methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:20:13'!
previousIfNone: blockToExecuteIfNone
	
	^previousNode.! !

!ValidNode methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:21:36'!
storedObjectIfNone: blockToExecuteIfNone

	^storedObject copy.! !


!ValidNode methodsFor: 'testing' stamp: 'AM 10/4/2020 19:02:08'!
isEmpty
	
	^false.! !

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

!OOStack methodsFor: 'initialization' stamp: 'AM 10/4/2020 19:28:58'!
initialize
	
	top := EmptyNode new.
	size := 0.! !


!OOStack methodsFor: 'testing' stamp: 'AM 10/4/2020 19:03:37'!
isEmpty
	
	^top isEmpty.! !


!OOStack methodsFor: 'error messages' stamp: 'AM 10/5/2020 16:29:23'!
raiseEmptyStackError

	^self error: self class stackEmptyErrorDescription.! !


!OOStack methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:24:50'!
size 

	^size.! !

!OOStack methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:30:04'!
top
	
	^top storedObjectIfNone: [self raiseEmptyStackError]. ! !


!OOStack methodsFor: 'operations' stamp: 'AM 10/5/2020 16:35:43'!
pop
	
	|poppedTop|
	
	poppedTop := top.
	top := poppedTop previousIfNone: [self raiseEmptyStackError].
	size := size - 1.
	
	^poppedTop storedObjectIfNone: [self raiseEmptyStackError]. ! !

!OOStack methodsFor: 'operations' stamp: 'AM 10/4/2020 19:28:52'!
push: objectToStore

	|newTop|
	
	newTop := ValidNode with: objectToStore asChildOf: top.
	
	top := newTop. 
	size := size + 1.! !

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
