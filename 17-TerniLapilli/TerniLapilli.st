!classDefinition: #TerniLapilliTest category: 'TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 17:37:44'!
test01NewGameIsNotOver

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self deny: terniLapilli isOver.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:12:50'!
test02XStartsPlaying

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self deny: terniLapilli isPlayingO.
	self assert: terniLapilli isPlayingX.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:46'!
test03OPlaysAfterX

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@2.
	
	self deny: terniLapilli isPlayingX.
	self assert: terniLapilli isPlayingO.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:41'!
test04XPlaysAfterO

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@2.
	terniLapilli putOat: 1@3.
	
	self deny: terniLapilli isPlayingO.
	self assert: terniLapilli isPlayingX.	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:30'!
test05CantPlayOnOtherPlayersTurn

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self
		should: [ terniLapilli putOat: 1@2]
		raise: Error
		withMessageText: TerniLapilli incorrectPlayerTurnErrorDescription.
		
	terniLapilli putXat: 1@2.
	
	self
		should: [ terniLapilli putXat: 1@3]
		raise: Error
		withMessageText: TerniLapilli incorrectPlayerTurnErrorDescription.
		
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:17'!
test06XCanPlaceCorrectly

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	
	self assert: (terniLapilli atPosition: 1@1)	 equals: #X.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 18:54:08'!
test07OCanPlaceCorrectly

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	terniLapilli putOat: 2@2.
	
	self assert: (terniLapilli atPosition: 2@2)	 equals: #O.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:09:52'!
test08OCantPlaceOnOccupiedPostition

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	
	self 
		should: [terniLapilli putOat: 1@1]
		raise: Error
		withMessageText: TerniLapilli invalidPlacePositionErrorDescription.
		
	self assert: (terniLapilli atPosition: 1@1) equals: #X.	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:10:46'!
test09XCantPlaceOnOccupiedPostition

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1.
	terniLapilli putOat: 2@2.
	self 
		should: [terniLapilli putXat: 2@2]
		raise: Error
		withMessageText: TerniLapilli invalidPlacePositionErrorDescription.
		
	self assert: (terniLapilli atPosition: 2@2) equals: #O.	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:47:36'!
test10XCantPlaceOutOfBounds

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	self 
		should: [terniLapilli putXat: 4@4]
		raise: Error
		withMessageText: TerniLapilli outOfBoundsPlacePositionErrorDescription.
			! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:48:34'!
test11OCantPlaceOutOfBounds

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	terniLapilli putXat: 1@1.
	
	self 
		should: [terniLapilli putOat: 4@4]
		raise: Error
		withMessageText: TerniLapilli outOfBoundsPlacePositionErrorDescription.
			! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 19:49:33'!
test12CantPlaceMoreThanSixPieces

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 1@2; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 2@3.
	
	self 
		should: [terniLapilli putXat: 3@1]
		raise: Error
		withMessageText: TerniLapilli maxAmountOfPiecesOnBoardErrorDescription.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'AM 10/29/2020 20:58:58'!
test13XCanWinOnMove6

	| terniLapilli |
	
	terniLapilli := TerniLapilli new. 
	
	terniLapilli putXat: 1@1; putOat: 1@2; putXat: 1@3; putOat: 2@1; putXat: 2@2; putOat: 2@3.
	
	terniLapilli moveXFrom: 2@2 to: 3@2.
	
	self assert: (terniLapilli atPosition: 3@2) equals: #X.
	self assert: (terniLapilli atPosition: 2@2) equals: #E.! !


!classDefinition: #TerniLapilli category: 'TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playerTurn board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 20:50:17'!
hasWon: aPlayerSymbol

	| hasWon |
	
	hasWon := false.
	
	"Horizontales"
	
	1 to: 3 do: [:row | hasWon := hasWon or: 
									[aPlayerSymbol = (board at: row@1) 
											and: [(board at: row@1) = (board at: row@2) 
												and: [(board at: row@2) = (board at: row@3)]]]].
	
	"Verticales"
	
	1 to: 3 do: [:column | hasWon := hasWon or: 
									[aPlayerSymbol = (board at: 1@column)
											and: [(board at: 1@column) = (board at: 2@column) 
												and: [(board at: 2@column) = (board at: 3@column)]]]].
	
	"Diagonal1"
	
	hasWon := hasWon or: 
					[aPlayerSymbol = (board at: 1@1) 
							and: [(board at: 1@1) = (board at: 2@2)
								and: [(board at: 2@2) = (board at: 3@3)]]].
						
	"Diagonal2"
	
	hasWon := hasWon or: 
					[aPlayerSymbol = (board at: 1@3) 
							and: [(board at: 1@3) = (board at: 2@2)
								and: [(board at: 2@2) = (board at: 3@1)]]].
						
	^hasWon.! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 20:53:42'!
isOver
	
	^(self hasWon: #X) or: [self hasWon: #O].! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 18:17:45'!
isPlayingO
	
	^(playerTurn = #O).! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 18:18:04'!
isPlayingX
	
	^(playerTurn = #X).! !

!TerniLapilli methodsFor: 'testing' stamp: 'AM 10/29/2020 20:17:33'!
isTied

	| sum |
	
	sum := 0.
	
	board do: [:piece | ((piece = #X) or: [piece = #O]) ifTrue: [sum := sum + 1]].
	
	^(6 = sum).! !


!TerniLapilli methodsFor: 'initialization' stamp: 'AM 10/29/2020 19:09:29'!
initialize
	
	board := Array2D newSize: 3@3.
	board fillWithArrayOfArrays: #(#(#E #E #E) #(#E #E #E) #(#E #E #E)).
	playerTurn := #X.! !


!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 18:36:36'!
signalIncorrectPlayerTurn

	^self error: self class incorrectPlayerTurnErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 21:17:03'!
signalInvalidMoveDestination

	^self error: self class invalidMoveDestinationErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 21:15:11'!
signalInvalidMoveOrigin

	^self error: self class invalidMoveOriginErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 19:05:43'!
signalInvalidPlacePosition

	^self error: self class invalidPlacePositionErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 19:38:34'!
signalMaxAmountOfPieces

 	^self error: self class maxAmountOfPiecesOnBoardErrorDescription.! !

!TerniLapilli methodsFor: 'error signals' stamp: 'AM 10/29/2020 19:23:17'!
signalOutOfBoundsPlacePosition

	^self error: self class outOfBoundsPlacePositionErrorDescription.! !


!TerniLapilli methodsFor: 'assertions' stamp: 'AM 10/29/2020 21:09:21'!
assertBoardAt: aPoint has: aPlayerSymbol ifNone: failureBlock

	(((aPoint x) between: 1 and: 3) and: [(aPoint y) between: 1 and: 3]) ifFalse:[self signalOutOfBoundsPlacePosition].
	(board at: aPoint) = aPlayerSymbol ifFalse: failureBlock.! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 10/29/2020 19:23:36'!
assertPointIsInRange: aPoint

	(((aPoint x) between: 1 and: 3) and: [(aPoint y) between: 1 and: 3]) ifFalse:[self signalOutOfBoundsPlacePosition].
	! !

!TerniLapilli methodsFor: 'assertions' stamp: 'AM 10/29/2020 21:01:38'!
assertValidPlacePostition: aPoint

	(((aPoint x) between: 1 and: 3) and: [(aPoint y) between: 1 and: 3]) ifFalse:[self signalOutOfBoundsPlacePosition].
	(board at: aPoint) = #E ifFalse: [self signalInvalidPlacePosition].! !


!TerniLapilli methodsFor: 'actions' stamp: 'AM 10/29/2020 21:13:53'!
moveXFrom: anOriginPoint to: aDestinationPoint
	
	self assertBoardAt: anOriginPoint has: #X ifNone: [self signalInvalidMoveOrigin].
	self assertBoardAt: aDestinationPoint has: #E ifNone: [self signalInvalidMoveDestination].
	
	board at: anOriginPoint put: #E.
	board at: aDestinationPoint put: #X.
	
	
	! !

!TerniLapilli methodsFor: 'actions' stamp: 'AM 10/29/2020 21:10:28'!
putOat: aPoint 
	
	self isPlayingO ifFalse: [self signalIncorrectPlayerTurn].
	self assertBoardAt: aPoint has: #E ifNone: [self signalInvalidPlacePosition].
	self isTied ifTrue:[self signalMaxAmountOfPieces].
	board at: aPoint put: #O.
	playerTurn := #X.! !

!TerniLapilli methodsFor: 'actions' stamp: 'AM 10/29/2020 21:11:03'!
putXat: aPoint 
	
	self isPlayingX ifFalse: [self signalIncorrectPlayerTurn].
	self assertBoardAt: aPoint has: #E ifNone: [self signalInvalidPlacePosition].
	self isTied ifTrue:[self signalMaxAmountOfPieces].
	board at: aPoint put: #X.
	playerTurn := #O.! !


!TerniLapilli methodsFor: 'accessing' stamp: 'AM 10/29/2020 18:58:08'!
atPosition: aPoint 
	
	^board at: aPoint.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: 'TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 18:32:14'!
incorrectPlayerTurnErrorDescription
	
	^'Its not players turn' ! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 21:17:34'!
invalidMoveDestinationErrorDescription

	^'Move destination contains a piece'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 21:16:22'!
invalidMoveOriginErrorDescription

	^'Trying to move an invalid piece'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 19:02:26'!
invalidPlacePositionErrorDescription
	
	^'Postition already occupied'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 19:29:43'!
maxAmountOfPiecesOnBoardErrorDescription
	
	^'No more pieces can be place, a piece should be moved'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'AM 10/29/2020 19:13:49'!
outOfBoundsPlacePositionErrorDescription
	
	^'Position is out of bounds'! !
