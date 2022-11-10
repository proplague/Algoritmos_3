!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:21:13'!
test01
	
	| portfolio |
	
	portfolio := Portofolio new.
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:41:06'!
test02
	| portfolio |
	
	portfolio := Portofolio new.
	
	portfolio addAccount: ReceptiveAccount new.
	
	self assert: portfolio  balance equals: 0*peso . ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:42:52'!
test03
	| portfolio anAccount |
	
	portfolio := Portofolio new.
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	Withdraw register: 50  * peso on: anAccount.
	portfolio addAccount: anAccount .
	
	self assert: portfolio  balance equals: 50 * peso. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 21:49:25'!
test04
	| portfolio anAccount deposit |
	
	portfolio := Portofolio new.

	anAccount := ReceptiveAccount new.

	deposit := Deposit register: 100 * peso on: anAccount.
	portfolio addAccount: anAccount .

	self assert: ( 	portfolio includesTransaction: deposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 21:08:30'!
test05
	| portfolio anAccount deposit |
	
	portfolio := Portofolio new.

	anAccount := ReceptiveAccount new.


	portfolio addAccount: anAccount .
	deposit := Deposit register: 50 * peso on: anAccount.
	self assert:( 	portfolio includesTransaction: deposit ).! !

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


!classDefinition: #TransferenciasTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenciasTest
	instanceVariableNames: 'accountA accountB manager'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 20:22:23'!
setUp 
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	Deposit register: 100*peso on: accountA.
	Deposit register: 150*peso on: accountB.
	manager := Manager new. ! !

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 20:31:16'!
test01
	manager transferFrom: accountA to: accountB  withValue: 50*peso.
	
	self assert: accountA balance equals: 50*peso.
	self assert: accountB balance equals: 200*peso.

	! !

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 20:45:23'!
test02

	
	self should: [manager transferFrom: accountA to: accountB  withValue: 300*peso.]
	raise: Error
	withExceptionDo: [: anError |self assert: anError messageText equals: Withdraw errorInsufficientBalance ] 

	! !

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 20:48:40'!
test03


	self assert: false! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'transactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:24:44'!
balance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/7/2022 21:08:13'!
updateBalance: aBalance

	self  subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MMeichtri 11/4/2022 19:31:19'!
balance: aReceptiveAccount

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/7/2022 21:08:35'!
updateBalance: aBalance

	^ aBalance  + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'AER 11/9/2022 19:53:59'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'AER 11/9/2022 20:36:16'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !

!Deposit class methodsFor: 'instance creation' stamp: 'AER 11/9/2022 21:11:23'!
register: aValue on: account withTX: aT

	| transaction |
	
	transaction := self for: aValue.	
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:31:40'!
balance: aReceptiveAccount

	^ value! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/7/2022 21:09:00'!
updateBalance: aBalance

	^ aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'AER 11/9/2022 20:41:32'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.	(account balance < aValue ) ifTrue:[ self error: Withdraw errorInsufficientBalance ].
	account register: transaction.
		
	^ transaction! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 20:40:27'!
errorInsufficientBalance
	^'error insufficient balance'! !


!classDefinition: #Manager category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Manager
	instanceVariableNames: 'lastID'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Manager methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 21:01:07'!
initialize
	lastID _ 0.! !

!Manager methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 21:01:36'!
nextId

	lastID _ lastID + 1.
	^lastID! !

!Manager methodsFor: 'as yet unclassified' stamp: 'AER 11/9/2022 21:02:23'!
transferFrom: oneSender to: oneReciver withValue: aValue
 	
	Withdraw register: aValue on: oneSender. 
	"onesender := oneSender balance."
	Deposit register: aValue on: oneReciver . 
	"onesender := oneReciver balance."
	
	^aValue ."an Id"! !


!classDefinition: #Portofolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portofolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portofolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:27:59'!
addAccount: anAccount
	accounts add: anAccount .
	! !

!Portofolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:30:30'!
balance
	^accounts sum: [:anAccount | anAccount balance ] ifEmpty: [^0].! !

!Portofolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 21:45:35'!
includesTransaction: aTransaction

	^accounts detect: [: anAccount | anAccount hasRegistered: aTransaction ]
	"[:anAccount | anAccount hasRegistered: aTransaction ]."! !

!Portofolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:32:18'!
initialize
	accounts := OrderedCollection new.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/8/2022 19:48:13'!
balance

	| parcialBalance |
	
	parcialBalance := 0.
	^ transactions sum: [ : aTransaction | aTransaction updateBalance: parcialBalance ] ifEmpty: [ 0 ].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/7/2022 20:47:57'!
register: aTransaction
		
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:30:02'!
balanceDeposit

	^ Deposit  value! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:30:12'!
balanceWithdraw

	^ Withdraw  value! !
