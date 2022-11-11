!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio anAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'MMeichtri 11/10/2022 20:53:15'!
test01PortfolioHaveZeroAsBalanceWhenCreated
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MMeichtri 11/10/2022 22:49:10'!
test02PortfolioAddAnAccountAndIncreaseHerBalance

	Deposit register: 100 * peso on: anAccount.
	Withdraw register: 50  * peso on: anAccount.
	
	portfolio addAccount: anAccount .
	
	self assert: portfolio  balance equals: 50 * peso. ! !

!PortfolioTest methodsFor: 'tests' stamp: 'MMeichtri 11/10/2022 22:48:22'!
test03PortfolioAddAnAccountAndValidateIfInclude

	| deposit |
	
	deposit := Deposit register: 100 * peso on: anAccount.
	portfolio addAccount: anAccount .
	
	self assert: ( portfolio includesTransaction: deposit ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MMeichtri 11/10/2022 22:43:15'!
test04PortfolioAddAPortfolioAndValidateInclude
	|  portfolio2 anAccount2 deposit2|
	

	portfolio2 := Portfolio new.

	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	
	deposit2 := Deposit register: 1000 * peso on: anAccount2.
	
	portfolio addAccount: anAccount .
	portfolio2 addAccount: anAccount2 .
	
	portfolio addAccount: portfolio2.
	
	self assert: (portfolio includesPortfolio: portfolio2).! !


!PortfolioTest methodsFor: 'setUp' stamp: 'MMeichtri 11/10/2022 22:43:55'!
setUp

	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTest class' category: 'ServiciosFinancieros-Ejercicio'!
PortfolioTest class
	instanceVariableNames: ''!

!PortfolioTest class methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:45:15'!
APortfolio
"	^Portofolio new."! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:01:24'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 
	| account |
	account := ReceptiveAccount new.
	
	self assert: 0 equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:01:37'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
	
	self assert: 100 * peso equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:01:48'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
	
	self assert: 50 * peso equals: account balance! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:02:00'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:02:14'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
	
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:02:35'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:02:52'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 * peso on: account.
	
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).! !


!classDefinition: #TransfersTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransfersTest
	instanceVariableNames: 'accountA accountB accountManagment'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransfersTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:19:59'!
test01AccountATransferAccountBAndBalanceIsCorrect

	accountManagment transferFrom: accountA to: accountB  withValue: 50*peso.
	
	self assert: accountA balance equals: 50*peso.
	self assert: accountB balance equals: 200*peso.

	! !

!TransfersTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:14:03'!
test02AccountATransferAccountBAndValueOfTransIdSavedIsCorrect

	accountManagment transferFrom: accountA to: accountB  withValue: 50*peso.	
	
	self assert: (accountA includesTransactionId: 1) equals: 50*peso.! !

!TransfersTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:14:52'!
test03AccountATransferAccountBAndAgainstaOfAccountAIsAccountB
	
	accountManagment transferFrom: accountA to: accountB  withValue: 50*peso.	
	
	self assert: (accountA againstTransactionId: 1) equals: accountB.! !

!TransfersTest methodsFor: 'tests' stamp: 'MMeichtri 11/11/2022 16:23:58'!
test04AccountAWantsDoATransferToAccountBWith0ValueAndRaisedError

	self 
	should: [accountManagment transferFrom: accountA to: accountB  withValue: 0*peso]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: AccountManagment errorTransferLessOrEqualTo0 ].! !


!TransfersTest methodsFor: 'setUp' stamp: 'MMeichtri 11/10/2022 20:58:49'!
setUp 
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	Deposit register: 100*peso on: accountA.
	Deposit register: 150*peso on: accountB.
	accountManagment := AccountManagment new. ! !


!classDefinition: #AccountManagment category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountManagment
	instanceVariableNames: 'lastID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountManagment methodsFor: 'initialization' stamp: 'AER 11/9/2022 21:01:07'!
initialize
	lastID _ 0.! !


!AccountManagment methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 21:18:50'!
nextId

	lastID _ lastID + 1.
	^lastID! !

!AccountManagment methodsFor: 'operations' stamp: 'MMeichtri 11/11/2022 16:18:57'!
transferFrom: oneSender to: oneReciver withValue: aValue
 	
	(aValue <= 0) ifTrue: [ self error: AccountManagment errorTransferLessOrEqualTo0].
	Withdraw register: aValue on: oneSender withTX: self nextId other: oneReciver. 
	Deposit register: aValue on: oneReciver withTX: self nextId other: oneSender. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountManagment class' category: 'ServiciosFinancieros-Ejercicio'!
AccountManagment class
	instanceVariableNames: ''!

!AccountManagment class methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/11/2022 16:19:34'!
errorTransferLessOrEqualTo0

	^ 'Transfer must be greater than 0'! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 20:40:51'!
balance: aReceptiveAccount

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 20:41:58'!
updateBalance: aBalance

	self  subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/10/2022 23:08:40'!
againstTransId
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/10/2022 23:06:11'!
includesTransactionId: aTransactionId

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instanceCreation' stamp: 'MMeichtri 11/11/2022 15:48:45'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instanceCreation' stamp: 'MMeichtri 11/11/2022 15:47:53'!
for: aValue tx: aTx  conContraParte: contraParte
	^ self new initializeFor: aValue withTX: aTx conContraParte: contraParte.! !

!AccountTransaction class methodsFor: 'instanceCreation' stamp: 'MMeichtri 11/11/2022 15:49:45'!
register: aValue on: account

	| transaction |
	transaction := self for: aValue.
	account register: transaction.
	
	^ transaction! !

!AccountTransaction class methodsFor: 'instanceCreation' stamp: 'MMeichtri 11/11/2022 15:46:51'!
register: aValue on: account withTX: aTxId other: contraParte

	| transaction |
	transaction := self for: aValue tx: aTxId conContraParte: contraParte.
	account register: transaction.
	
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value transId againstTransId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'MMeichtri 11/11/2022 15:50:41'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'initialization' stamp: 'MMeichtri 11/10/2022 23:11:23'!
initializeFor: aValue withTX: aTransactionId conContraParte: anAgainstTransId

	value := aValue. 
	transId _ aTransactionId .
	againstTransId _ anAgainstTransId.! !


!Deposit methodsFor: 'value' stamp: 'MMeichtri 11/11/2022 15:52:18'!
value
	^ value! !


!Deposit methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 23:09:43'!
againstTransId

	^ againstTransId .! !

!Deposit methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 20:42:11'!
updateBalance: aBalance

	^ aBalance  + self value! !


!Deposit methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 23:10:18'!
includesTransactionId: aTransactionId
	^transId = aTransactionId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: 'txID'!


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value transId againstTransId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'MMeichtri 11/10/2022 23:12:35'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'MMeichtri 11/10/2022 23:14:41'!
initializeFor: aValue withTX: aTransactionId conContraParte: anAgainstTransactionId 

	value := aValue. 
	transId _ aTransactionId.
	againstTransId _ anAgainstTransactionId.! !


!Withdraw methodsFor: 'value' stamp: 'MMeichtri 11/10/2022 23:14:30'!
value

	^ value! !


!Withdraw methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 23:11:59'!
againstTransId
	^ againstTransId .! !

!Withdraw methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 20:42:19'!
updateBalance: aBalance

	^ aBalance - self value! !


!Withdraw methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 23:12:21'!
includesTransactionId: aTransactionId
	^transId = aTransactionId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: 'txID'!


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'MMeichtri 11/11/2022 16:05:24'!
balance

	^accounts sum: [:anAccount | anAccount balance ] ifEmpty: [^0].! !

!Portfolio methodsFor: 'testing' stamp: 'MMeichtri 11/11/2022 16:05:24'!
findTransaction: aTransaction

	accounts do:
		[: anAccount |
		(anAccount includes: aTransaction) ifTrue:
			[^true]].
	^false! !

!Portfolio methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 22:18:29'!
hasRegistered: aTransaction

	^self includes: aTransaction.! !

!Portfolio methodsFor: 'testing' stamp: 'MMeichtri 11/11/2022 15:57:33'!
includes: aTransaction

	^ self findTransaction: aTransaction ! !

!Portfolio methodsFor: 'testing' stamp: 'MMeichtri 11/11/2022 16:05:24'!
includesPortfolio: aPortfolio

	^ accounts includes: aPortfolio! !

!Portfolio methodsFor: 'testing' stamp: 'MMeichtri 11/11/2022 15:57:41'!
includesTransaction: aTransaction
		
	^ self findTransaction: aTransaction.
! !


!Portfolio methodsFor: 'initialization' stamp: 'MMeichtri 11/11/2022 16:05:24'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'operations' stamp: 'MMeichtri 11/11/2022 16:05:24'!
addAccount: anAccount

	accounts add: anAccount .	! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MMeichtri 11/10/2022 22:57:14'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/10/2022 22:56:04'!
balance

	| parcialBalance |
	parcialBalance := 0.
	
	^ transactions sum: [ : aTransaction | aTransaction updateBalance: parcialBalance ] ifEmpty: [ 0 ].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/10/2022 21:35:11'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/10/2022 22:57:26'!
register: aTransaction

	transactions add: aTransaction ! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/10/2022 22:57:40'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 23:33:14'!
againstTransactionId: aTransactionId
	
	^(self findAccountTransactionWithId: aTransactionId) againstTransId.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 22:28:28'!
includes: aTransaction

	^ transactions includes: aTransaction ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 22:34:22'!
includesTransaction: aTransaction

	^ transactions includes: aTransaction ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'MMeichtri 11/10/2022 23:35:03'!
includesTransactionId: aTransactionId
	
	^(self findAccountTransactionWithId: aTransactionId) value.! !


!ReceptiveAccount methodsFor: 'operations' stamp: 'MMeichtri 11/10/2022 23:32:01'!
findAccountTransactionWithId: txID
	
	^(transactions detect: [ :elem | elem includesTransactionId: txID]) .! !
