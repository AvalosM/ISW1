!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operaciones' stamp: 'MA 9/15/2020 15:23:02'!
* unNumero
	^unNumero.
! !

!I class methodsFor: 'operaciones' stamp: 'MA 9/14/2020 22:03:23'!
+ unNumero

	^unNumero next.! !

!I class methodsFor: 'operaciones' stamp: 'MA 9/15/2020 23:49:07'!
-unNumero

	self error: 'descripcionDeErrorDeNumerosNegativosNoSoportados'.! !

!I class methodsFor: 'operaciones' stamp: 'MA 9/16/2020 00:07:58'!
/unNumero
	
	unNumero == I ifTrue: [^I.].
	self error: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'.! !

!I class methodsFor: 'operaciones' stamp: 'MA 9/15/2020 23:06:33'!
next
	
	^self createChildNamed: self name, 'I'.
	

	
	! !

!I class methodsFor: 'operaciones' stamp: 'MA 9/15/2020 15:33:52'!
previous 

	^self.! !


!classDefinition: #II category: #'Numeros de Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'operaciones' stamp: 'MA 9/15/2020 16:24:01'!
*unNumero

	^(self previous * unNumero) + unNumero.
! !

!II class methodsFor: 'operaciones' stamp: 'MA 9/14/2020 22:04:25'!
+ unNumero

	^self previous + unNumero next.! !

!II class methodsFor: 'operaciones' stamp: 'MA 9/15/2020 16:09:01'!
-unNumero

	(unNumero == I) ifTrue: [^self previous.].
	^self previous - unNumero previous.! !

!II class methodsFor: 'operaciones' stamp: 'MA 9/16/2020 00:01:08'!
/unNumero

	(unNumero isDescendantOf: self) ifTrue: [self error: 'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'].
	
	(unNumero == self) ifTrue:[^I].
	(unNumero isDescendantOf: (self - unNumero)) ifTrue:[^I].
	^self - unNumero/unNumero + I.! !

!II class methodsFor: 'operaciones' stamp: 'MA 9/14/2020 21:56:46'!
previous
	
	^self parent.! !


!classDefinition: #III category: #'Numeros de Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIII category: #'Numeros de Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIII category: #'Numeros de Peano'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #IIIIII category: #'Numeros de Peano'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!


!classDefinition: #NumerosDePeanoTest category: #'Numeros de Peano'!
DenotativeObject subclass: #NumerosDePeanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!
