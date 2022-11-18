!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: 'anAccount accountSummaryReportForAnAccount reportDetail accountSummaryReportForAPortfolio aPortfolio pepeAccount marioAccount anEmptyReceptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'AER 11/18/2022 17:02:20'!
test01SummaryOfReceptiveAccountWithNoTransactionsIncludesJustZeroBalance
	reportDetail add: 'Cuenta de sin nombre'.
	reportDetail add: '	Balance = 0'.
	self assert: accountSummaryReportForAnAccount printReport equals: reportDetail.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AER 11/18/2022 17:03:21'!
test02SummaryOfPortfolioWithNoTransactionsIncludesJustZeroBalance
	reportDetail add: 'Portfolio de sin nombre'.
	reportDetail add: '	Cuenta de sin nombre'.
	reportDetail add: '		Balance = 0'.
	reportDetail add: '	Balance = 0'.	
	self assert: accountSummaryReportForAPortfolio printReport equals: reportDetail.
	! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AER 11/18/2022 17:19:36'!
test03SummaryOfReceptiveAccountWithNames
	
	|reportPepeAcc|
	Deposit register: 1000 * peso on: pepeAccount. 
	Withdraw register: 123 * peso on: pepeAccount.
	reportDetail add: 'Cuenta de Pepe'.
	reportDetail add: '	Depósito por 1000 * pesos'.
	reportDetail add: '	Extracción por 123 * pesos'.
	reportDetail add: '	Balance = 877 * pesos'.
	reportPepeAcc := AccountSummaryReport for: pepeAccount .
	
	self assert: reportPepeAcc printReport equals: reportDetail .
	 ! !


!AccountSummaryTest methodsFor: 'setUp' stamp: 'AER 11/18/2022 16:38:03'!
setUp

	anAccount := ReceptiveAccount new.
	reportDetail := OrderedCollection new.
	aPortfolio := Portfolio with: anAccount.
	accountSummaryReportForAPortfolio := 	AccountSummaryReport for: aPortfolio.
	accountSummaryReportForAnAccount := AccountSummaryReport for: anAccount.
	pepeAccount := ReceptiveAccount named:  'Pepe'.
	marioAccount := ReceptiveAccount named:  'Mario'.
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
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


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: 'aPortfolio anAccount transferNetForPortfolio transferNetForReceptiveAccount destinationAccount originAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:56:05'!
setUp

	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	aPortfolio := Portfolio with: originAccount .
	transferNetForReceptiveAccount := TransferNetReport for: originAccount .
	transferNetForPortfolio := TransferNetReport for: aPortfolio ! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:43:31'!
test01TransferNetOfPortfolioIsZeroWhenThereIsNoTransferTransactions
	self assert: transferNetForPortfolio printReport equals: '0 pesos'.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:43:57'!
test02TransferNetOfReceptiveAccountIsZeroWhenThereIsNoTransferTransactions
	self assert: transferNetForReceptiveAccount printReport equals: '0 pesos'.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:54:08'!
test03
	Transfer amount: 20*peso from: destinationAccount to: originAccount.
	Transfer amount: 30*peso from: originAccount to: destinationAccount.
	self assert: transferNetForPortfolio printReport equals: '10 pesos'.! !


!classDefinition: #Account category: 'ServiciosFinancieros'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/16/2022 17:15:11'!
accept: aReport

	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/14/2022 20:16:17'!
traverse: aBlock

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents accountName portfolioName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Portfolio methodsFor: 'initialization' stamp: 'AER 11/13/2022 19:12:20'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	portfolioName := 'sin nombre'. ! !

!Portfolio methodsFor: 'initialization' stamp: 'AER 11/13/2022 19:11:57'!
initializeWithName: aName
	portfolioName := aName .! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


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


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'AER 11/13/2022 19:33:37'!
accountSummary
	|delimiter resume header footer tabulation|
	delimiter := String with: Character lf. "newline: Podria ser cr tambien"
	tabulation := String with: Character tab.
	
	header := 'Cuenta de ', portfolioName.
	
	footer := 'Balance = ', (self balance) asString.
	
	resume := ''.
	
	accounts do: [:account | resume _ resume, tabulation, account accountSummary.].
	

	^header, delimiter, resume, footer, delimiter .
	
	! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 21:48:22'!
accept: aReport

	^ aReport handleAccountAsAPortfolio: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 16:35:38'!
name 
	^portfolioName ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 21:53:59'!
toAllAccountsDo: aBlock

	
	 accounts do: [:account | aBlock value: account].
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'AER 11/13/2022 20:05:58'!
transferNet
	
	^accounts sum: [ :anAccount | anAccount transferNet ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/14/2022 20:17:03'!
traverse: aBlock

	^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AER 11/13/2022 19:11:29'!
named: aName
	^self new initializeWithName: aName. 
	 ! !

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


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AER 11/13/2022 18:18:30'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	accountName _ 'sin nombre'.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AER 11/13/2022 18:16:43'!
initializeWithName: aName

	accountName := aName ! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'AER 11/13/2022 19:36:06'!
accountSummary
	|delimiter resume header footer tabulator|
	delimiter := String with: Character lf. "newline: Podria ser cr tambien"
	tabulator := String with: Character tab.
	header := 'Cuenta de ', accountName.
	
	footer := '	Balance = ', (self balance) asString.
	
	resume := ''.
	
	transactions do: [:transaction | resume _ (resume, tabulator, transaction print, delimiter).].
	
	
	^header, delimiter, resume, footer, delimiter .
	
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 21:48:43'!
accept: aReport

	^ aReport handleAccountAsAReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AER 11/13/2022 18:35:13'!
name

	^accountName.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AER 11/13/2022 20:09:42'!
transferNet

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectTransfer: currentBalance ]! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 21:53:14'!
withTransactionsDo: aBlock

	 transactions do: [:aTransaction | aBlock value: aTransaction].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instanceCreation' stamp: 'AER 11/13/2022 18:24:49'!
named: aName

	^self new initializeWithName: aName.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'transfer' stamp: 'AER 11/13/2022 20:12:54'!
affectTransfer: aalue

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'Prints' stamp: 'MMeichtri 11/14/2022 21:29:12'!
print
	
	^'Depósito por ', (self value) asString! !


!Deposit methodsFor: 'transferNet' stamp: 'AER 11/13/2022 20:10:52'!
asd! !


!Deposit methodsFor: 'transfer' stamp: 'AER 11/14/2022 01:38:56'!
affectTransfer: aValue

	^aValue! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:52:18'!
accept: aReport

	^aReport handleTransactionAsDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'transfer' stamp: 'AER 11/14/2022 01:45:05'!
affectTransfer: aValue
^self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'Prints' stamp: 'AER 11/13/2022 18:37:43'!
print
	
	^'Entrada por transferencia de ', (self value) asString.
	! !


!TransferDepositLeg methodsFor: 'transfer' stamp: 'AER 11/14/2022 01:40:20'!
affectTransfer: aValue

	^aValue  + self value .! !


!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:56:32'!
accept: aReport

	^ aReport handleTransactionAsDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'Prints' stamp: 'AER 11/13/2022 18:37:38'!
print
	
	^'Salida por transferencia de ', (self value) asString.
	! !


!TransferWithdrawLeg methodsFor: 'transfer' stamp: 'AER 11/14/2022 01:40:48'!
affectTransfer: aValue

	^ aValue - self value .! !


!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:58:27'!
accept: aReport
	
	^ aReport handleTransactionAsWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'Prints' stamp: 'MMeichtri 11/14/2022 21:44:09'!
print
	
	^'Extracción por ', (self value) asString! !


!Withdraw methodsFor: 'transfer' stamp: 'AER 11/13/2022 20:16:14'!
affectTransfer: aValue

	^ aValue ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 15:47:03'!
accept: aReport "aVisitor"
	^aReport handleTransactionAsWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Reports category: 'ServiciosFinancieros'!
Object subclass: #Reports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Reports methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/16/2022 17:12:26'!
initializeFor: anAccount

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Reports class' category: 'ServiciosFinancieros'!
Reports class
	instanceVariableNames: ''!

!Reports class methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/16/2022 17:08:43'!
for: anAccount

	self subclassResponsibility ! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancieros'!
Reports subclass: #AccountSummaryReport
	instanceVariableNames: 'account balance accountSummaryReport tabDelimiter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 16:57:50'!
handleAccountAsAPortfolio: aPortfolio
	accountSummaryReport add: 'Portfolio de ', aPortfolio name. 
	aPortfolio toAllAccountsDo: [:acc | (acc accept: self)]. "Aca hay que agregar una indentacion de alguna forma. "
	accountSummaryReport add: tabDelimiter ,'Balance = ', aPortfolio balance asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 16:58:31'!
handleAccountAsAReceptiveAccount: aReceptiveAccount
	accountSummaryReport add: 'Cuenta de ', aReceptiveAccount name.
	aReceptiveAccount withTransactionsDo: [:transaction | accountSummaryReport add: tabDelimiter,( transaction accept:self)].
	accountSummaryReport add: tabDelimiter,'Balance = ', aReceptiveAccount balance asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 16:04:37'!
handleTransactionAsDeposit: aDeposit

	^'Depósito por ', aDeposit value asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:57:04'!
handleTransactionAsDepositLeg:  aDepositLeg


	^'Entrada por transferencia de ', aDepositLeg value asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 16:01:59'!
handleTransactionAsWithdraw: aWithdraw

	^'Extracción por ', aWithdraw value asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:59:53'!
handleTransactionAsWithdrawLeg: aWithdrawLeg

	^'Salida por transferencia de ', aWithdrawLeg value asString. ! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 17:01:25'!
initializeFor: anAccount 

	account := anAccount. 
	
	accountSummaryReport := OrderedCollection new.
	
	tabDelimiter := '	'.
	
	account accept: self. 
	
	 
	
! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'AER 11/18/2022 15:42:13'!
printReport
	"Esto deberia transformarse en un método que transforme la ordered collection de Strings en un String con todo el reporte indentado."	
	^ accountSummaryReport! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'ServiciosFinancieros'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/16/2022 17:08:29'!
for: anAccount

	^ self new initializeFor: anAccount ! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros'!
Reports subclass: #TransferNetReport
	instanceVariableNames: 'account balance transferNetReport'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 21:51:29'!
handleAccountAsAPortfolio: aPortfolio

	aPortfolio toAllAccountsDo: [: anAccount |  (anAccount accept: self)]! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 21:51:09'!
handleAccountAsAReceptiveAccount: aReceptiveAccount

	aReceptiveAccount withTransactionsDo: [:transaction |  balance := (transaction accept: self)].! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:57:56'!
handleTransactionAsDepositLeg: aDepositLeg


	^ aDepositLeg affectBalance: transferNetReport. ! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:59:34'!
handleTransactionAsWithdrawLeg: aWithdrawLeg


	^ aWithdrawLeg affectBalance: transferNetReport . 
	! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:04:37'!
initializeFor: anAccount

	account := anAccount.

	transferNetReport := 0*peso.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/17/2022 22:05:35'!
printReport

	account accept: self.
	
	^ transferNetReport asString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'ServiciosFinancieros'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/16/2022 17:09:16'!
for: anAccount

	^ self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'ServiciosFinancieros'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
