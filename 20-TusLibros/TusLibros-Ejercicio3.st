!classDefinition: #ApiRestTest category: 'TusLibros'!
TestCase subclass: #ApiRestTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clientValidationBehavior simulatedTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRestTest methodsFor: 'check out tests' stamp: 'AM 12/1/2020 18:11:57'!
test01cantCheckOutNonExistingCart

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	self 
		should:[api checkOutCart: 1 charging: testObjectsFactory notExpiredCreditCard]
		raise: Error 
		withMessageText: CartManager cartDoesntExistErrorDescription.
	
	! !

!ApiRestTest methodsFor: 'check out tests' stamp: 'AM 12/1/2020 18:12:02'!
test02checkOutReturnsSaleInformation

	| api cartID expected sale |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID item: (testObjectsFactory itemSellByTheStore) quantity: 1. 
	sale := api checkOutCart: cartID charging: testObjectsFactory notExpiredCreditCard.
	expected := OrderedCollection with: sale.
	
	self assert: expected equals: (api listPurchasesFor: 'client'). ! !


!ApiRestTest methodsFor: 'set up' stamp: 'AM 12/1/2020 17:01:13'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clientValidationBehavior := [:aClientID : aPassword | ].
	simulatedTime := DateAndTime now.! !


!ApiRestTest methodsFor: 'authentication protocol' stamp: 'AM 11/30/2020 18:11:22'!
authenticate: aClientID withPassword: aPassword

	clientValidationBehavior value: aClientID value: aPassword.! !


!ApiRestTest methodsFor: 'merchant processor protocol' stamp: 'AM 11/29/2020 15:35:33'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/1/2020 17:06:46'!
test01newCartShouldBeEmpty

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	expected := OrderedCollection new.
	
	self assert: expected equals: (api listCart: cartID).! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/1/2020 17:06:51'!
test02cantAddItemsToNonExistingCart

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	self 
		should:[api addToCart: 1 item: (testObjectsFactory itemSellByTheStore) quantity: 1]
		raise: Error 
		withMessageText: CartManager cartDoesntExistErrorDescription.
		
	self assert: (api hasNoActiveCarts).
	! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/1/2020 17:06:55'!
test03cantListItemsOfNonExistingCart

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	self 
		should:[api listCart: 1]
		raise: Error 
		withMessageText: CartManager cartDoesntExistErrorDescription.
	
	! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/1/2020 18:09:33'!
test04cantCreateCartForInvalidClientIDPasswordCombination

	| api |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	clientValidationBehavior := [:client :password | self error: ApiRest invalidIDOrPasswordErrorDescription].
	
	self
		should:[api createCartFor: 'client' withPassword: 'password']
		raise: Error
		withMessageText: ApiRest invalidIDOrPasswordErrorDescription.
		
	self assert: api hasNoActiveCarts.! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/1/2020 18:09:39'!
test05itemIsAddedToCartCorrectly

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID item: (testObjectsFactory itemSellByTheStore) quantity: 1. 
	
	expected := OrderedCollection with: testObjectsFactory itemSellByTheStore.
	
	self assert: expected equals: (api listCart: cartID).! !

!ApiRestTest methodsFor: 'cart management tests' stamp: 'AM 12/1/2020 18:14:50'!
test06cartIsDeletedAfterCheckOut

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	api addToCart: cartID item: (testObjectsFactory itemSellByTheStore) quantity: 1. 
	api checkOutCart: cartID charging: testObjectsFactory notExpiredCreditCard.
	
	self
		should: [api listCart: cartID]
		raise: Error
		withMessageText: CartManager cartDoesntExistErrorDescription.! !


!ApiRestTest methodsFor: 'clock protocol' stamp: 'AM 12/1/2020 17:46:02'!
leap15MinutesIntoTheFuture
	
	simulatedTime := simulatedTime + 15 minutes.! !

!ApiRestTest methodsFor: 'clock protocol' stamp: 'AM 12/1/2020 17:02:17'!
leap30MinutesIntoTheFuture
	
	simulatedTime := simulatedTime + 30 minutes.! !

!ApiRestTest methodsFor: 'clock protocol' stamp: 'AM 12/1/2020 16:58:53'!
now
	
	^simulatedTime.! !


!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/1/2020 18:03:59'!
test01cantCheckOutCart30MinutesAfterLastAction

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	api addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 1.
	
	self leap30MinutesIntoTheFuture.
	
	self
		should: [api checkOutCart: cartID charging: testObjectsFactory notExpiredCreditCard]
		raise: Error
		withMessageText: CartManager cartExpiredErrorDescription.
	
	self assert: (api listPurchasesFor: 'client') isEmpty.
	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/1/2020 18:03:50'!
test02cantListCart30MinutesAfterLastAction

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	self leap30MinutesIntoTheFuture.
	
	self
		should: [api listCart: cartID]
		raise: Error
		withMessageText: CartManager cartExpiredErrorDescription.

	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/1/2020 18:05:30'!
test03cantAddItemsToCart30MinutesAfterLastAction

	| api cartID |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	
	self leap30MinutesIntoTheFuture.
	
	self
		should: [api addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 1]
		raise: Error
		withMessageText: CartManager cartExpiredErrorDescription.

	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/1/2020 18:03:08'!
test04addingItemsToCartResetsExpirationDeadline

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	self leap15MinutesIntoTheFuture.
	
	api addToCart: cartID item: testObjectsFactory itemSellByTheStore quantity: 1.
	self leap15MinutesIntoTheFuture.
	
	expected := OrderedCollection with: (testObjectsFactory itemSellByTheStore).	
	self assert: (api listCart: cartID) equals: expected.
	
	! !

!ApiRestTest methodsFor: 'time keeping tests' stamp: 'AM 12/1/2020 18:03:15'!
test05listingCartResetsExpirationDeadline

	| api cartID expected |
	
	api := ApiRest withCatalogue: testObjectsFactory defaultCatalog salesThrough: self validatingClientsThrough: self keepingTimeWith: self.
	
	cartID := api createCartFor: 'client' withPassword: 'password'.
	self leap15MinutesIntoTheFuture.
	
	api listCart: cartID.
	self leap15MinutesIntoTheFuture.
	
	expected := OrderedCollection new.	
	self assert: (api listCart: cartID) equals: expected.
	
	! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #ApiRest category: 'TusLibros'!
Object subclass: #ApiRest
	instanceVariableNames: 'priceCatalogue activeCarts merchantProcessor clientPasswordValidator salesBook ownerForCart cartManager clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRest methodsFor: 'initialization' stamp: 'AM 12/1/2020 17:37:10'!
initializeWithCatalogue: aPriceCatalogue salesThrough: aMerchantProcessor validatingClientsThrough: aClientPasswordValidator keepingTimeWith: aClock  
	
	priceCatalogue := aPriceCatalogue.
	merchantProcessor := aMerchantProcessor.
	salesBook := Dictionary new.
	cartManager := CartManager for: self.
	clientPasswordValidator := aClientPasswordValidator.
	clock := aClock.! !


!ApiRest methodsFor: 'testing' stamp: 'AM 12/1/2020 16:29:21'!
hasNoActiveCarts
	
	^cartManager hasNoActiveCarts.! !


!ApiRest methodsFor: 'cart' stamp: 'AM 12/1/2020 16:21:40'!
addToCart: aCartID item: anItemID quantity: aQuantity

	cartManager addToCart: aCartID item: anItemID quantity: aQuantity.
	
	! !

!ApiRest methodsFor: 'cart' stamp: 'AM 12/1/2020 17:38:21'!
createCartFor: aClientID withPassword: aPassword
	
	clientPasswordValidator authenticate: aClientID withPassword: aPassword.
	^cartManager addCart: (Cart acceptingItemsOf: priceCatalogue) forClient: aClientID .
	
	
	
	! !

!ApiRest methodsFor: 'cart' stamp: 'AM 12/1/2020 16:29:45'!
listCart: aCartId
	
	^cartManager listCart: aCartId.! !


!ApiRest methodsFor: 'check out' stamp: 'AM 12/1/2020 18:17:04'!
checkOutCart: aCartID charging: aCreditCard 
	
	| cashier cartOwner clientSalesBook cartToCheckOut sale |
	
	cartToCheckOut := cartManager cartWithID: aCartID.
	cartOwner := cartManager ownerIDForCart: aCartID.
	clientSalesBook := salesBook at: cartOwner ifAbsent: [salesBook at: cartOwner put: OrderedCollection new].
	
	cashier := Cashier toCheckout: cartToCheckOut charging: aCreditCard throught: merchantProcessor on: (clock now) registeringOn: clientSalesBook.
	sale := cashier checkOut.
	
	cartManager removeCart: aCartID.
	
	^sale.
	 ! !


!ApiRest methodsFor: 'clients' stamp: 'AM 12/1/2020 17:43:44'!
listPurchasesFor: aClientID

	^salesBook at: aClientID ifAbsent: [salesBook at: aClientID put: OrderedCollection new.].! !


!ApiRest methodsFor: 'time keeping protocol' stamp: 'AM 12/1/2020 17:33:14'!
timeNow
	
	^clock now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApiRest class' category: 'TusLibros'!
ApiRest class
	instanceVariableNames: ''!

!ApiRest class methodsFor: 'instance creation' stamp: 'AM 12/1/2020 17:05:54'!
withCatalogue: aPriceCatalogue salesThrough: aMerchantProcessor validatingClientsThrough: aClientPasswordValidator keepingTimeWith: aClock 
	
	^self new initializeWithCatalogue: aPriceCatalogue salesThrough: aMerchantProcessor validatingClientsThrough: aClientPasswordValidator keepingTimeWith: aClock.! !


!ApiRest class methodsFor: 'error descriptions' stamp: 'AM 11/29/2020 16:16:24'!
invalidIDOrPasswordErrorDescription
	
	^'ID or password is invalid'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'item queries' stamp: 'AM 11/29/2020 16:04:39'!
addItemsTo: anItemCollection

	items do: [:item | anItemCollection add: item copy].! !

!Cart methodsFor: 'item queries' stamp: 'AM 11/30/2020 18:54:03'!
items

	^items copy.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartManager category: 'TusLibros'!
Object subclass: #CartManager
	instanceVariableNames: 'activeCarts cartLastActionTimestamp nextCartID api'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartManager methodsFor: 'time keeping protocol' stamp: 'AM 12/1/2020 17:42:18'!
removeIfExpiredAndRaiseExeption: aCartID

	((cartLastActionTimestamp at: aCartID) > ((api timeNow) - 30 minutes)) ifFalse: [ activeCarts removeKey: aCartID.
														     cartLastActionTimestamp removeKey: aCartID.
															self signalCartExpired.]! !

!CartManager methodsFor: 'time keeping protocol' stamp: 'AM 12/1/2020 18:01:55'!
updateTimeFor: aCartID

	^ cartLastActionTimestamp at: aCartID put: api timeNow.! !


!CartManager methodsFor: 'accessing' stamp: 'AM 12/1/2020 17:31:24'!
cartWithID: aCartID
	
	| cart |
	
	cart := (activeCarts at: aCartID ifAbsent: [self signalNonExistentCart]) value.
	self removeIfExpiredAndRaiseExeption: aCartID.
	^cart.! !

!CartManager methodsFor: 'accessing' stamp: 'AM 12/1/2020 18:00:58'!
listCart: aCartID
	
	| cartToList |
	
	cartToList := self cartWithID: aCartID.
	self updateTimeFor: aCartID.
	
	^cartToList items.! !

!CartManager methodsFor: 'accessing' stamp: 'AM 12/1/2020 16:49:16'!
ownerIDForCart: aCartID

	^(activeCarts at: aCartID ifAbsent: [self signalNonExistentCart]) key.! !


!CartManager methodsFor: 'adding/removing' stamp: 'AM 12/1/2020 18:01:25'!
addCart: aCart forClient: aClientID  

	| cartID |
	
	cartID := nextCartID.
	nextCartID := nextCartID + 1.
	
	self updateTimeFor: cartID.
	activeCarts at: cartID put: aClientID->aCart.
	^cartID.
	! !

!CartManager methodsFor: 'adding/removing' stamp: 'AM 12/1/2020 18:06:50'!
addToCart: aCartID item: anItemID quantity: aQuantity

	| cart |
	
	cart := (activeCarts at: aCartID ifAbsent: [self signalNonExistentCart]) value.
	self removeIfExpiredAndRaiseExeption: aCartID.
	self updateTimeFor: aCartID.
	cart add: aQuantity of: anItemID.! !

!CartManager methodsFor: 'adding/removing' stamp: 'AM 12/1/2020 18:18:32'!
removeCart: aCartID

	activeCarts removeKey: aCartID.
	cartLastActionTimestamp removeKey: aCartID.! !


!CartManager methodsFor: 'testing' stamp: 'AM 12/1/2020 16:29:10'!
hasNoActiveCarts
	
	^activeCarts isEmpty.! !


!CartManager methodsFor: 'initialization' stamp: 'AM 12/1/2020 18:19:23'!
initializeFor: anApi
	
	api := anApi.
	activeCarts := Dictionary new.
	cartLastActionTimestamp := Dictionary new.
	nextCartID := 0.! !


!CartManager methodsFor: 'error signaling' stamp: 'AM 12/1/2020 17:32:43'!
signalCartExpired

	self error: self class cartExpiredErrorDescription.! !

!CartManager methodsFor: 'error signaling' stamp: 'AM 12/1/2020 16:41:35'!
signalNonExistentCart

	self error: self class cartDoesntExistErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartManager class' category: 'TusLibros'!
CartManager class
	instanceVariableNames: ''!

!CartManager class methodsFor: 'error descriptions' stamp: 'AM 12/1/2020 16:40:10'!
cartDoesntExistErrorDescription

	^'There is no cart with provided ID'.! !

!CartManager class methodsFor: 'error descriptions' stamp: 'AM 12/1/2020 17:10:32'!
cartExpiredErrorDescription
	
	^'Cart is expired'! !


!CartManager class methodsFor: 'instance creation' stamp: 'AM 12/1/2020 17:24:16'!
for: anApi

	^self new initializeFor: anApi.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AM 11/30/2020 19:09:42'!
createSale
	
	
	^OrderedCollection with: (cart items) with: total.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'AM 11/30/2020 19:26:49'!
registerSale

	^salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'AM 11/30/2020 19:24:36'!
checkOut
	
	| sale |
	self calculateTotal.
	self debitTotal.
	sale := self registerSale.

	^ sale.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total soldItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'items' stamp: 'AM 11/30/2020 18:49:03'!
soldItems

	^soldItems copy.! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'AM 11/30/2020 18:48:51'!
initializeSaleOf: aSoldItemsCollection for: aSaleTotal

	total := aSaleTotal.
	soldItems := aSoldItemsCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'AM 11/30/2020 18:47:53'!
forCart: aCart
	
	^self new initializeSaleOf: aCart items for: aCart total.
	! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !

