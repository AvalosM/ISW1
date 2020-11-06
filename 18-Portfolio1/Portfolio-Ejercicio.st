!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/2/2020 19:29:45'!
test01EmptyPortfolioHasZeroBalance

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/2/2020 20:43:26'!
test02PortfolioWithOneAccountMatchesAccountBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 300).
	
	portfolio add: account.
	
	self assert: (account balance) equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/2/2020 20:43:42'!
test03PortfolioWithOnePortfolioMatchesPortFolioBalance

	| portfolioChild portfolioParent account |
	
	portfolioChild := Portfolio new.
	account := ReceptiveAccount new.
	account register: (Deposit for: 300).
	portfolioChild add: account.
	
	portfolioParent := Portfolio new.
	
	portfolioParent add: portfolioChild.
	
	self assert: (portfolioChild balance) equals: (portfolioParent balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/2/2020 20:43:36'!
test04FindsTransactionCorrectly

	| portfolio account transaction|
	
	portfolio := Portfolio new.
	transaction := (Deposit for: 300).
	account := ReceptiveAccount new.
	account register: transaction.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/2/2020 20:44:23'!
test05CantRegisterDuplicateAccounts

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account register: (Deposit for: 300).
	
	portfolio add: account.
	
	self
	should: [portfolio add: account.]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/6/2020 16:06:20'!
test06CantAddAccountPresentInChildPortfolio

	| portfolioChild portfolioParent account|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 300).
	
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	
	portfolioParent := Portfolio new.
	portfolioParent add: portfolioChild.
	
	self
	should: [portfolioParent add: account.]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/6/2020 15:51:22'!
test07TransactionsReturnsAllAccountsInPortfolio

	| portfolio account accountTransactions transactions |
	
	account := ReceptiveAccount new.
	accountTransactions := OrderedCollection with: (Deposit for: 300) with: (Withdraw for: 150).
	account register: (accountTransactions at: 1); register: (accountTransactions at: 2).
	
	transactions := OrderedCollection with: accountTransactions.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: transactions equals: portfolio transactions.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/6/2020 16:06:52'!
test08CantAddAccountPresentInChildPortfolio

	| portfolioChild portfolioParent portfolioToAdd account|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 300).
	
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	
	portfolioParent := Portfolio new.
	portfolioParent add: portfolioChild.
	
	portfolioToAdd:= Portfolio new.
	portfolioToAdd add: account.
	
	self
	should: [portfolioParent add: portfolioToAdd ]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'tests' stamp: 'AM 11/6/2020 16:25:54'!
test09

	| portfolioChild portfolioParent account|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 300).
	
	portfolioChild := Portfolio new.
	
	portfolioParent := Portfolio new.
	portfolioParent add: portfolioChild.
	portfolioParent add: account.
	
	self
	should: [portfolioChild add: account]
	raise: Error
	withMessageText: Portfolio duplicateAccountErrorDescription.! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'AM 11/2/2020 20:31:48'!
applyToBalance: aBalanceValue

	^ aBalanceValue + self value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'AM 11/2/2020 20:30:54'!
applyToBalance: aBalanceValue

	^ aBalanceValue - self value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'AM 11/2/2020 19:34:23'!
balance
	
	^accountsAndPortfolios sum: [:anAccountOrPorfolio | anAccountOrPorfolio balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initialization' stamp: 'AM 11/6/2020 16:28:06'!
initialize 

	accountsAndPortfolios := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'AM 11/6/2020 16:27:22'!
add: aReceptiveAccountOrPortfolio 
	
	self assertNotDuplicate: aReceptiveAccountOrPortfolio.
	aReceptiveAccountOrPortfolio addParent: self.
	accountsAndPortfolios add: aReceptiveAccountOrPortfolio.! !

!Portfolio methodsFor: 'adding' stamp: 'AM 11/6/2020 16:11:28'!
addAccountTo: anAccountCollection
	
	accountsAndPortfolios do: [:accountOrPortfolio | accountOrPortfolio addAccountTo: anAccountCollection].! !

!Portfolio methodsFor: 'adding' stamp: 'AM 11/6/2020 16:27:52'!
addParent: aPortfolio

	parents add: aPortfolio.! !


!Portfolio methodsFor: 'assertions' stamp: 'AM 11/6/2020 16:34:03'!
assertNotDuplicate: anAccountOrPortfolio
	
	| accountsInHierachy |
	accountsInHierachy := OrderedCollection new.
	
	parents do: [:parent | accountsInHierachy add: ((parent searchParents) accounts)].
	
	(anAccountOrPortfolio accounts) detect: [:anAccount | accountsInHierachy includes: anAccount] ifNone: [^false].
	self signalDuplicateAccount.! !

!Portfolio methodsFor: 'assertions' stamp: 'AM 11/6/2020 16:35:05'!
searchParents

	parents ! !


!Portfolio methodsFor: 'testing' stamp: 'AM 11/2/2020 19:56:22'!
hasRegistered: aTransaction
	
	| foundTransaction |
	foundTransaction := false.
	
	accountsAndPortfolios do: [
						:accountOrPortfolio | foundTransaction := foundTransaction or: [accountOrPortfolio  hasRegistered: aTransaction]
						].
	
	^foundTransaction.! !


!Portfolio methodsFor: 'signals' stamp: 'AM 11/2/2020 20:40:09'!
signalDuplicateAccount

	^self error: self class duplicateAccountErrorDescription.! !


!Portfolio methodsFor: 'accessing' stamp: 'AM 11/6/2020 16:11:52'!
accounts

	| accounts |
	
	accounts := OrderedCollection new.
	
	accountsAndPortfolios do: [:accountOrPortfolio | accountOrPortfolio addAccountTo: accounts].
	
	^accounts.! !

!Portfolio methodsFor: 'accessing' stamp: 'AM 11/6/2020 15:45:23'!
addTransactionTo: transactionCollection
	
	accountsAndPortfolios do: [:anAccountOrPortFolio | anAccountOrPortFolio addTransactionTo: transactionCollection].! !

!Portfolio methodsFor: 'accessing' stamp: 'AM 11/6/2020 15:46:42'!
transactions
	| transactionCollection |
	
	transactionCollection := OrderedCollection new.
	
	accountsAndPortfolios do: [:anAccountOrPortFolio | anAccountOrPortFolio addTransactionTo: transactionCollection].
	
	^transactionCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'AM 11/2/2020 20:35:45'!
duplicateAccountErrorDescription
	
	^'Account is duplicate'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'AM 11/6/2020 16:10:56'!
addAccountTo: anAccountCollection

	anAccountCollection add: self.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AM 11/6/2020 15:50:04'!
addTransactionTo: transactionsCollection

	transactionsCollection add: self transactions.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AM 11/2/2020 20:34:02'!
balance
	| balance |
	
	balance := 0.
	transactions do: [:aTransaction | balance := aTransaction applyToBalance: balance].
	
	^balance.
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'AM 11/6/2020 16:21:31'!
accounts

 	^OrderedCollection with: self.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'AM 11/2/2020 20:54:34'!
assertNotDuplicate: aReceptiveAccount

	^(self = aReceptiveAccount).! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AM 11/6/2020 16:28:37'!
addParent: aPortfolio

	! !
