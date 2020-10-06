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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:03:39'!
setUp

	finder := SentenceFinderByPrefix new.
	
	emptyStack := OOStack new.
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:34:34'!
test01FindsSentence

	|stack|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos'.
	
	self assert:((OrderedCollection with: 'uno dos') = (finder findSentencesPrefixedBy: 'uno' on: stack)).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:12:12'!
test02FindDoesntModifyStack

	|stack stackCopy|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos'.
	stackCopy := stack copy.
	finder findSentencesPrefixedBy: 'uno' on: stack.
	
	self assert: (stack size = stackCopy size).
	
	1 to: stack size do: [:a | self assert: (stack pop = stackCopy pop)]
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:26:49'!
test03EmptyPrefixIsInvalid

	
	|stack|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos'.
	
	self 
		should: [finder findSentencesPrefixedBy: '' on: stack]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (SentenceFinderByPrefix invalidPrefixErrorDescription)]. ! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:28:00'!
test04PrefixWithSpaceIsInvalid

	|stack|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos'.
	
	self 
		should: [finder findSentencesPrefixedBy: 'uno dos' on: stack]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (SentenceFinderByPrefix invalidPrefixErrorDescription)]. ! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:30:08'!
test05FinderIsCaseSensitive

	|stack|
	stack := OOStack new.
	stack push: 'uno'; push: 'UNO'; push: 'Uno'.
	
	self assert: ((OrderedCollection with: 'Uno') = (finder findSentencesPrefixedBy: 'Uno' on: stack))! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:33:44'!
test06FindsMultipleInstances

	|stack|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos'; push: 'dos'.
	
	self assert: ((OrderedCollection with: 'dos' with: 'dos') = (finder findSentencesPrefixedBy: 'dos' on: stack)).
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:37:19'!
test07PrefixLongerThanSentencesDoesntFail

	|stack|
	stack := OOStack new.
	stack push: 'uno'; push: 'dos'.
	
	self assert: ((	OrderedCollection new) = (finder findSentencesPrefixedBy: 'tres' on: stack))! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:39:18'!
test08PrefixNotPresentReturnsEmptyCollection

	|stack|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos'.
	
	self assert: ((OrderedCollection new) = (finder findSentencesPrefixedBy: 'tres' on: stack))! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:40:53'!
test09FinderOnEmptyStackReturnsEmptyCollection
	
	self assert: ((OrderedCollection new) = (finder findSentencesPrefixedBy: 'tres' on: emptyStack))! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:43:10'!
test10FindsSentencesWithSpaces

	|stack|
	stack := OOStack new.
	stack push: 'uno dos'; push: 'dos uno'.
	
	self assert:((OrderedCollection with: 'uno dos') = (finder findSentencesPrefixedBy: 'uno' on: stack)).! !


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


!OOStack methodsFor: 'error messages' stamp: 'AM 10/5/2020 16:29:23'!
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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 16:42:05'!
filter: collectionOfSentences by: prefix
	
	|resultCollection|
	resultCollection := collectionOfSentences select: [:sentence | (prefix size <= sentence size)].
														
	^resultCollection select: [:sentence | (sentence copyFrom: 1 to: prefix size) = prefix].
													! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 16:39:09'!
findSentencesPrefixedBy: prefix on: stackToSearch

	|stackElements|
	(self isValidPrefix: prefix) ifFalse: [self raiseInvalidPrefixError].
	
	stackElements := self getElements: stackToSearch.
	
	^self filter: stackElements by: prefix.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'AM 10/5/2020 20:47:50'!
getElements: stack
	
	|stackElements|
	stackElements := OrderedCollection new.
	
	1 to: stack size do: [:a | stackElements addFirst: (stack pop)].
	
	stackElements do: [:sentence | stack push: sentence].
	
	^stackElements.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 17:26:36'!
isValidPrefix: prefix

	^(prefix isEmpty not & (prefix allSatisfy: [:char | char ~= $ ])).! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 16:38:40'!
raiseInvalidPrefixError

	^self error: self class invalidPrefixErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'AM 10/6/2020 16:37:40'!
invalidPrefixErrorDescription
	
	^'Prefix cannot be empty or contain spaces'! !
