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
	instanceVariableNames: 'emptyStack finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'AM 10/7/2020 18:59:58'!
pushElemtentsFrom: array into: stack

	array do: [:element | stack push: element]! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'AM 10/7/2020 18:55:30'!
setUp

	finder := SentenceFinderByPrefix new.
	emptyStack := OOStack new.
! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:04:37'!
test01FindsSentence

	|stack expectedResult|
	
	stack := OOStack new.
	self pushElemtentsFrom: #('uno dos' 'tres') into: stack. 
	expectedResult := OrderedCollection with: 'uno dos'.
	
	self assert: expectedResult equals: (finder find: 'u' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:04:44'!
test02FindDoesntModifyStack

	|stack|
	
	stack := OOStack new.
	self pushElemtentsFrom: #('uno' 'dos') into: stack.
	finder find: 'u' in: stack.
	
	self assert: stack size equals: 2.
	self assert: stack pop equals: 'dos'.
	self assert: stack pop equals: 'uno'
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:04:47'!
test03EmptyPrefixIsInvalid

	
	|stack|
	
	stack := OOStack new.
	stack push: 'uno'.
	
	self 
		should: [finder find: '' in: stack]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (SentenceFinderByPrefix invalidPrefixErrorDescription)]. ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:04:51'!
test04PrefixWithSpaceIsInvalid

	|stack|
	
	stack := OOStack new.
	stack push: 'uno dos'.
	
	self 
		should: [finder find: 'uno dos' in: stack]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (SentenceFinderByPrefix invalidPrefixErrorDescription)]. ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:04:54'!
test05FinderIsCaseSensitive

	|stack expectedResult|
	
	stack := OOStack new.
	self pushElemtentsFrom: #('uno' 'Uno') into: stack.
	expectedResult := OrderedCollection with: 'Uno'.
	
	self assert: expectedResult equals: (finder find: 'Uno' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:14:41'!
test06FindsMultipleInstances

	|stack expectedResult|
	
	stack := OOStack new.
	self pushElemtentsFrom: #('uno dos' 'dos tres' 'dos') into: stack.
	expectedResult := OrderedCollection with: 'dos' with: 'dos tres'.
	
	self assert: expectedResult equals: (finder find: 'dos' in: stack).
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/8/2020 15:12:02'!
test07PrefixLongerThanSentencesDoesntFail

	|stack expectedResult|
	
	stack := OOStack new.
	stack push: 'uno'. 
	expectedResult := OrderedCollection new.
	
	self assert: expectedResult equals: (finder find: 'unos' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/8/2020 15:08:55'!
test08PrefixNotPresentReturnsEmptyCollection

	|stack expectedResult|
	
	stack := OOStack new.
	stack push: 'uno'.
	expectedResult := OrderedCollection new.
	
	self assert: expectedResult equals: (finder find: 'dos' in: stack).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:05:07'!
test09FinderOnEmptyStackReturnsEmptyCollection

	|expectedResult|
	
	expectedResult := OrderedCollection new.
	
	self assert: expectedResult equals: (finder find: 'tres' in: emptyStack).! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'AM 10/7/2020 20:05:10'!
test10FindsSentencesWithSpaces

	|stack expectedResult|
	
	stack := OOStack new.
	stack push: 'uno dos'. 
	expectedResult := OrderedCollection with: 'uno dos'.
	
	self assert: expectedResult equals: (finder find: 'uno' in: stack).! !


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


!classDefinition: #RootNode category: 'Stack-Exercise'!
Node subclass: #RootNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RootNode methodsFor: 'testing' stamp: 'AM 10/4/2020 19:02:27'!
isEmpty

	^true.! !


!RootNode methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:20:56'!
previousIfNone: blockToExecuteIfNone

	^blockToExecuteIfNone value.

	! !

!RootNode methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:21:54'!
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

!OOStack methodsFor: 'initialization' stamp: 'AM 10/6/2020 16:01:07'!
initialize
	
	top := RootNode new.
	size := 0.! !


!OOStack methodsFor: 'testing' stamp: 'AM 10/4/2020 19:03:37'!
isEmpty
	
	^top isEmpty.! !


!OOStack methodsFor: 'error raising' stamp: 'AM 10/5/2020 16:29:23'!
raiseEmptyStackError

	^self error: self class stackEmptyErrorDescription.! !


!OOStack methodsFor: 'accessing' stamp: 'AM 10/5/2020 16:24:50'!
size 

	^size.! !

!OOStack methodsFor: 'accessing' stamp: 'AM 10/5/2020 17:26:54'!
top
	
	^top storedObjectIfNone: [self raiseEmptyStackError].! !


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

!SentenceFinderByPrefix methodsFor: 'private operations' stamp: 'AM 10/7/2020 20:15:08'!
add: sentence to: resultCollection ifPrefixIs: prefix

	((prefix size <= sentence size) and: [(sentence copyFrom: 1 to: prefix size) = prefix]) 
	ifTrue: [resultCollection add: sentence].! !

!SentenceFinderByPrefix methodsFor: 'private operations' stamp: 'AM 10/7/2020 20:16:20'!
addSentencesFrom: stack withPrefix: prefix to: resultCollection
	
	|stackElements|
	
	stackElements := OrderedCollection new.
	1 to: stack size do: [:a | self add: stack top to: resultCollection ifPrefixIs: prefix.
					stackElements addFirst: (stack pop)].
				
	stackElements do: [:sentence | stack push: sentence].
	! !

!SentenceFinderByPrefix methodsFor: 'private operations' stamp: 'AM 10/6/2020 17:26:36'!
isValidPrefix: prefix

	^(prefix isEmpty not & (prefix allSatisfy: [:char | char ~= $ ])).! !


!SentenceFinderByPrefix methodsFor: 'error raising' stamp: 'AM 10/6/2020 16:38:40'!
raiseInvalidPrefixError

	^self error: self class invalidPrefixErrorDescription.! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AM 10/7/2020 20:03:37'!
find: prefix in: stackToSearch

	|resultCollection|
	
	resultCollection := OrderedCollection new.
	
	(self isValidPrefix: prefix) ifFalse: [self raiseInvalidPrefixError].
	
	self addSentencesFrom: stackToSearch withPrefix: prefix to: resultCollection.
	
	^resultCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 16:37:40'!
invalidPrefixErrorDescription
	
	^'Prefix cannot be empty or contain spaces'! !
