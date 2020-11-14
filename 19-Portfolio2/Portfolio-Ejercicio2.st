!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:43:14'!
test01AccountSummaryForEmptyAccountIsZeroBalance

	| account accountSummary |
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: accountSummary report. ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:05:11'!
test02AccountSummaryForAccountWithOneTransactionMatchesBalanceAndTransaction

	| account accountSummary expectedReport |
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 100).
	accountSummary := AccountSummary for: account.
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Balance = 100'.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AM 11/14/2020 15:22:31'!
test03AccountSummaryForAccountWithMultipleTransactionsShowsAllTransactions

	| account1 account2 accountSummary expectedReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account1 register: (Deposit for: 100).
	Transfer from: account1 to: account2 for: 50. 
	accountSummary := AccountSummary for: account1.
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Transfer withdraw for 50' with: 'Balance = 50'.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:09:42'!
test04SummaryForEmptyPorfolioIsZeroBalance

	| portfolio expectedReport accountSummary|
	
	portfolio := Portfolio new.
	expectedReport := OrderedCollection with: 'Balance = 0'.
	accountSummary := AccountSummary for: portfolio.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:14:30'!
test05SummaryForPorfolioWithOneAccountMatchesAccountTransactionsAndBalance

	| portfolio account expectedReport accountSummary|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 100); register: (Withdraw for: 100) .
	portfolio := Portfolio new.
	portfolio add: account.
	
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Withdraw for 100' with: 'Balance = 0'.
	accountSummary := AccountSummary for: portfolio.
	
	self assert: (expectedReport) equals: accountSummary report. ! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:15:58'!
test06SummaryForPorfolioWithOnePortfolioMatchesPortfolioTransactionsAndBalance

	| portfolioChild portfolio account expectedReport accountSummary|
	
	account := ReceptiveAccount new.
	account register: (Deposit for: 100); register: (Withdraw for: 100) .
	portfolioChild := Portfolio new.
	portfolioChild add: account.
	portfolio := Portfolio new.
	portfolio add: portfolioChild.
	
	expectedReport := OrderedCollection with: 'Deposit for 100' with: 'Withdraw for 100' with: 'Balance = 0'.
	accountSummary := AccountSummary for: portfolio.
	
	self assert: (expectedReport) equals: accountSummary report. ! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:29:43'!
test01EmptyAccountTransferNetIsZero

	| account transferNetReport |
	
	account := ReceptiveAccount new.
	transferNetReport := TransferNet for: account.
	
	self assert: (transferNetReport report) equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:36:25'!
test02TransferNetReportForAccountWithTransferWithdrawMatchesWithdrawAmount

	| account1 account2 transferNetReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer from: account1 to: account2 for: 500. 
	
	transferNetReport := TransferNet for: account1.
	
	self assert: (transferNetReport report) equals: -500.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:43:39'!
test03TransferNetReportForAccountWithTransferDepositMatchesDepositAmount

	| account1 account2 transferNetReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer from: account1 to: account2 for: 500. 
	
	transferNetReport := TransferNet for: account2.
	
	self assert: (transferNetReport report) equals: 500.! !

!TransferNetTest methodsFor: 'tests' stamp: 'AM 11/14/2020 17:44:19'!
test04NonTransferTransactionsDontAffectTrasferNet

	| account1 account2 transferNetReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account1 register: (Deposit for: 600).
	account1 register: (Withdraw for: 100).
	
	Transfer from: account1 to: account2 for: 500. 
	
	transferNetReport := TransferNet for: account1.
	
	self assert: (transferNetReport report) equals: -500.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 20:55:49'!
test01TransferKnowsTransferorAndTransferee

	| transfer transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	transfer := Transfer from: transferor to: transferee for: 500.
	
	self assert: transferor equals: (transfer transferor).
	self assert: transferee equals: (transfer transferee).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 20:55:50'!
test02TransferAmountReturnedCorrectly

	| transfer transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	transfer := Transfer from: transferor to: transferee for: 500.
	
	self assert: 500 equals: (transfer amount).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:16:14'!
test03TransferAffectsTransferorBalanceCorrectly

	| transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	Transfer from: transferor to: transferee for: 500.
	
	self assert: -500 equals: (transferor balance).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:16:06'!
test04TransferAffectsTransfereeBalanceCorrectly

	|  transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	Transfer from: transferor to: transferee for: 500.
	
	self assert: 500 equals: (transferee balance).! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:15:56'!
test05TransferMustBeAPositiveNumber

	| transferor transferee|
	
	transferor := ReceptiveAccount new.
	transferee := ReceptiveAccount new.
	
	self 
		should: [Transfer from: transferor to: transferee for: -100]
		raise: Error
		withMessageText: Transfer invalidAmountErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'AM 11/9/2020 21:26:39'!
test06TransfersToAndFromTheSameAccountNotAllowed

	| account |
	
	account := ReceptiveAccount new.
	
	self 
		should: [Transfer from: account to: account for: 100]
		raise: Error
		withMessageText: Transfer cantTransferToSelfErrorDescription.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'AM 11/14/2020 15:14:58'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions sentTransfers recievedTransfers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AM 11/9/2020 20:11:59'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	sentTransfers := OrderedCollection new.
	recievedTransfers := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'AM 11/14/2020 15:50:13'!
reportTo: aReport

	aReport perform: ('handle', self class asString,':') asSymbol with: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'AM 11/14/2020 15:16:11'!
stringRep

	^'Deposit for ', value asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransactions category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransactions
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransactions methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:05:06'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!TransferTransactions methodsFor: 'value' stamp: 'AM 11/14/2020 15:25:50'!
value

	^transfer amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransactions class' category: 'Portfolio-Solucion'!
TransferTransactions class
	instanceVariableNames: ''!

!TransferTransactions class methodsFor: 'instance creation' stamp: 'AM 11/9/2020 21:04:06'!
for: aTransfer

	^self new initializeFor: aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferTransactions subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AM 11/9/2020 21:11:46'!
affectBalance: aBalance

	^aBalance + transfer amount.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 15:26:44'!
stringRep

	^'Transfer deposit for ', self value asString. ! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferTransactions subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AM 11/9/2020 21:12:45'!
affectBalance: aBalance

	^aBalance - transfer amount.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 15:26:40'!
stringRep

	^'Transfer withdraw for ', self value asString. ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 15:26:48'!
stringRep

	^'Withdraw for ', value asString. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reports category: 'Portfolio-Solucion'!
Object subclass: #Reports
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reports methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:42:04'!
initializeFor: anAccount

	account := anAccount.! !

!Reports methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:43:01'!
report

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reports class' category: 'Portfolio-Solucion'!
Reports class
	instanceVariableNames: ''!

!Reports class methodsFor: 'as yet unclassified' stamp: 'AM 11/9/2020 21:40:53'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Reports subclass: #AccountSummary
	instanceVariableNames: 'summaryCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'report' stamp: 'AM 11/14/2020 17:24:57'!
addStringRepresentationToSummary: aTransaction

	summaryCollection add: (aTransaction class asString), ' for ', aTransaction value asString.! !

!AccountSummary methodsFor: 'report' stamp: 'AM 11/14/2020 17:25:19'!
handleDeposit: aDeposit

	self addStringRepresentationToSummary: aDeposit.! !

!AccountSummary methodsFor: 'report' stamp: 'AM 11/14/2020 17:25:35'!
handleTransferDeposit: aTransferDeposit

	self addStringRepresentationToSummary: aTransferDeposit.! !

!AccountSummary methodsFor: 'report' stamp: 'AM 11/14/2020 17:25:49'!
handleTransferWithdraw: aTransferWithdraw

	self addStringRepresentationToSummary: aTransferWithdraw.! !

!AccountSummary methodsFor: 'report' stamp: 'AM 11/14/2020 17:25:59'!
handleWithdraw: aWithdraw

	self addStringRepresentationToSummary: aWithdraw.! !

!AccountSummary methodsFor: 'report' stamp: 'AM 11/14/2020 17:19:22'!
report

	account transactions do: [:aTransaction | aTransaction reportTo: self].
	summaryCollection add: 'Balance = ', account balance asString.
	^summaryCollection.! !


!AccountSummary methodsFor: 'initialization' stamp: 'AM 11/14/2020 17:19:22'!
initializeFor: anAccount

	account := anAccount.
	summaryCollection := OrderedCollection new.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Reports subclass: #TransferNet
	instanceVariableNames: 'netTotal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'AM 11/14/2020 17:39:03'!
initializeFor: anAccount

	account := anAccount.
	netTotal := 0.! !


!TransferNet methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 17:45:13'!
handleDeposit: aDepositTransaction
	
	"Deposits dont affect transfer net"! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 17:39:56'!
handleTransferDeposit: aTransferWithdraw

	netTotal := netTotal + aTransferWithdraw value.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 17:37:37'!
handleTransferWithdraw: aTransferWithdraw

	netTotal := netTotal - aTransferWithdraw value.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 17:45:04'!
handleWithdraw: aWithdrawTransaction
	
	"Withdraws dont affect transfer net"! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'AM 11/14/2020 17:34:12'!
report

	account transactions do: [:aTransaction | aTransaction reportTo: self].
	^netTotal.! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'transferor transferee amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'AM 11/9/2020 21:22:15'!
initializeFrom: aTransferor to: aTransferee for: anAmount 
	
	transferor := aTransferor.
	transferee := aTransferee.
	amount := anAmount.
	
	transferor register: (TransferWithdraw for: self).
	transferee register: (TransferDeposit for: self).
	
	! !


!Transfer methodsFor: 'accessing' stamp: 'AM 11/9/2020 19:55:19'!
amount
	
	^amount! !

!Transfer methodsFor: 'accessing' stamp: 'AM 11/9/2020 19:51:32'!
transferee
	
	^transferee! !

!Transfer methodsFor: 'accessing' stamp: 'AM 11/9/2020 19:51:23'!
transferor
	
	^transferor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AM 11/9/2020 21:28:04'!
from: aTransferor to: aTransferee for: anAmount 
	
	(anAmount > 0) ifFalse: [ self signalInvalidTransferAmount ].
	(aTransferor == aTransferee) ifTrue: [self signalTransactionToSelfErrorDescription].
	
	^self new initializeFrom: aTransferor to: aTransferee for: anAmount.! !


!Transfer class methodsFor: 'error descriptions' stamp: 'AM 11/9/2020 21:29:10'!
cantTransferToSelfErrorDescription

 	^'Cant transfer from and to the same account'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'AM 11/9/2020 21:17:21'!
invalidAmountErrorDescription
	
	^'Transfer amount must be greater than zero'! !


!Transfer class methodsFor: 'error signals' stamp: 'AM 11/9/2020 21:24:42'!
signalInvalidTransferAmount
	
	^self error: self invalidAmountErrorDescription.! !

!Transfer class methodsFor: 'error signals' stamp: 'AM 11/9/2020 21:30:11'!
signalTransactionToSelfErrorDescription

	^self error: self cantTransferToSelfErrorDescription.! !
