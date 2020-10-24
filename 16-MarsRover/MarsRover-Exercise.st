!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 15:18:32'!
test01

	| marsRover |
	
	marsRover := MarsRover atCoordinates: 1@1.
	
	self assert: marsRover position equals: 1@1. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:58:28'!
test02

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@1.
	
	self assert: marsRover directionSymbol equals: #N. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:30:26'!
test03

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@1.
	
	marsRover recieveCommands: 'f'.
	
	self assert: marsRover position equals: 1@2. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:52:26'!
test04

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'f'.
	
	self assert: marsRover position equals: 1@3. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:55:02'!
test05

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'b'.
	
	self assert: marsRover position equals: 1@1. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:00:44'!
test06

	| marsRover |
	
	marsRover := MarsRover facingSouthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'f'.
	
	self assert: marsRover position equals: 1@1. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:02:14'!
test07

	| marsRover |
	
	marsRover := MarsRover facingSouthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'l'.
	
	self assert: marsRover directionSymbol equals: #E. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:09:24'!
test08

	| marsRover |
	
	marsRover := MarsRover facingSouthAtCoordinates: 1@2.
	
	marsRover recieveCommands: 'r'.
	
	self assert: marsRover directionSymbol equals: #W. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:17:01'!
test09

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 0@0.
	
	marsRover recieveCommands: 'ffrf'.
	
	self assert: marsRover directionSymbol equals: #E.
	self assert: marsRover position equals: 1@2.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:55:06'!
test10

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 0@0.
	
	self 
		should: [marsRover recieveCommands: 'a']
		raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.
		! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:57:22'!
test11

	| marsRover |
	
	marsRover := MarsRover facingNorthAtCoordinates: 0@0.
	
	self 
		should: [marsRover recieveCommands: 'fflafl']
		raise: Error
		withMessageText: MarsRover invalidCommandErrorDescription.
		
	self assert: 0@2 equals: marsRover position.
	self assert: #W equals: marsRover directionSymbol.
		! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'initialization' stamp: 'AM 10/24/2020 15:21:21'!
initializeAtCoordinates: aPoint 

	position := aPoint.! !

!MarsRover methodsFor: 'initialization' stamp: 'AM 10/24/2020 16:18:46'!
initializeAtCoordinates: aCoordinate facing: aDirection
	
	position := aCoordinate.
	direction := aDirection.! !


!MarsRover methodsFor: 'accessing' stamp: 'AM 10/24/2020 16:58:50'!
direction
	
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'AM 10/24/2020 15:22:02'!
position
	
	^position! !


!MarsRover methodsFor: 'actions' stamp: 'AM 10/24/2020 17:54:37'!
recieveCommands: aCommandsString
	
	aCommandsString do: [:command | self assertValidCommand: command. 
								direction perform: (command asSymbol)].! !


!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:04:11'!
turnEast
	
	direction := E for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:12:21'!
turnNorth
	
	direction := N for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:12:48'!
turnSouth
	
	direction := S for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:10:24'!
turnWest
	
	direction := W for: self.! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:07:53'!
xCoordinateMinusOne
	
	position := position - (1@0).! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 17:07:44'!
xCoordinatePlusOne
	
	position := position + (1@0).! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 16:53:51'!
yCoordinateMinusOne
	
	position := position - (0@1).! !

!MarsRover methodsFor: 'actions private' stamp: 'AM 10/24/2020 16:16:20'!
yCoordinatePlusOne
	
	position := position + (0@1).! !


!MarsRover methodsFor: 'exeptions' stamp: 'AM 10/24/2020 17:44:35'!
signalInvalidCommand

	^self error: self class invalidCommandErrorDescription.! !


!MarsRover methodsFor: 'testing' stamp: 'AM 10/24/2020 17:54:16'!
assertValidCommand: aCommandChar

	| validCommands validFlag|
	
	validCommands := 'fblr'.
	validFlag := false.
	
	validCommands do: [:validChar | (validChar = aCommandChar) ifTrue: [validFlag := true]].
	
	validFlag ifFalse: [^self signalInvalidCommand].
	
		! !

!MarsRover methodsFor: 'testing' stamp: 'AM 10/24/2020 16:57:41'!
directionSymbol

	^direction asSymbol. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 15:20:22'!
atCoordinates: aPoint 

	^self new initializeAtCoordinates: aPoint.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 17:05:48'!
facingEastAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (E for: aMarsRover). 
	
	^aMarsRover.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 16:36:20'!
facingNorthAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (N for: aMarsRover). 
	
	^aMarsRover.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 17:00:22'!
facingSouthAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (S for: aMarsRover). 
	
	^aMarsRover.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 17:05:54'!
facingWestAtCoordinates: aCoordinate
	
	| aMarsRover |
	
	aMarsRover := MarsRover new.
	
	aMarsRover initializeAtCoordinates: aCoordinate facing: (W for: aMarsRover). 
	
	^aMarsRover.! !


!MarsRover class methodsFor: 'error messages' stamp: 'AM 10/24/2020 17:24:59'!
invalidCommandErrorDescription
	
	^'Commands string contains an invalid command'! !


!classDefinition: #MarsRoverDirection category: 'MarsRover-Exercise'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverDirection methodsFor: 'initialization' stamp: 'AM 10/24/2020 16:07:12'!
initializeFor: aMarsRover

	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: 'MarsRover-Exercise'!
MarsRoverDirection class
	instanceVariableNames: ''!

!MarsRoverDirection class methodsFor: 'instance creation' stamp: 'AM 10/24/2020 16:05:51'!
for: aMarsRover

	^self new initializeFor: aMarsRover.! !


!classDefinition: #E category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #E
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!E methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:04:35'!
asSymbol
	
	^#E.! !

!E methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:07:27'!
b
	
	marsRover xCoordinateMinusOne.! !

!E methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:07:03'!
f

	marsRover xCoordinatePlusOne.! !

!E methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:11:03'!
l

	marsRover turnNorth.! !

!E methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:11:14'!
r

	marsRover turnSouth.! !


!classDefinition: #N category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #N
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!N methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:58:04'!
asSymbol

	^#N! !

!N methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:53:39'!
b

	marsRover yCoordinateMinusOne.! !

!N methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:15:22'!
f 

	marsRover yCoordinatePlusOne.! !

!N methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:11:33'!
l

	marsRover turnWest.! !

!N methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:11:44'!
r

	marsRover turnEast.! !


!classDefinition: #S category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #S
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!S methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:01:33'!
asSymbol

	^#S! !

!S methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:54:30'!
b

	marsRover yCoordinatePlusOne.! !

!S methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 16:54:20'!
f

	marsRover yCoordinateMinusOne.! !

!S methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:03:23'!
l
	marsRover turnEast.! !

!S methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:09:55'!
r
	
	marsRover turnWest.! !


!classDefinition: #W category: 'MarsRover-Exercise'!
MarsRoverDirection subclass: #W
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!W methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:08:47'!
asSymbol

	^#W! !

!W methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:12:10'!
b

	marsRover turnSouth.! !

!W methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:08:10'!
f

	marsRover xCoordinateMinusOne.! !

!W methodsFor: 'as yet unclassified' stamp: 'AM 10/24/2020 17:12:00'!
r

	marsRover turnNorth.! !
