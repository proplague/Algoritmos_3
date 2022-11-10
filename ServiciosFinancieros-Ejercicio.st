!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:51:51'!
test01
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:51:51'!
test02
	| portfolio |
	
	portfolio := Portfolio new.
	
	portfolio addAccount: ReceptiveAccount new.
	
	self assert: portfolio  balance equals: 0*peso . ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:51:51'!
test03
	| portfolio anAccount |
	
	portfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	Withdraw register: 50  * peso on: anAccount.
	portfolio addAccount: anAccount .
	
	self assert: portfolio  balance equals: 50 * peso. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 23:29:40'!
test04
	| portfolio anAccount deposit |
	
	portfolio := Portfolio new.

	anAccount := ReceptiveAccount new.

	deposit := Deposit register: 100 * peso on: anAccount.
	portfolio addAccount: anAccount .

	self assert: ( 	portfolio includesTransaction: deposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 23:34:42'!
test05PortfolioInPortfolio
	| portfolio portfolio2 anAccount anAccount2 deposit deposit2|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.

	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 * peso on: anAccount.
	deposit2 := Deposit register: 1000 * peso on: anAccount2.
	
	portfolio addAccount: anAccount .
	portfolio2 addAccount: anAccount2 .
	
	portfolio addAccount: portfolio2.
	
	self assert: ( 	portfolio includesTransaction: deposit2 ).
	self assert: ( 	portfolio includesTransaction: deposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'KG 11/10/2022 00:02:43'!
test06PortfolioInPortfolio
	| portfolio portfolio2 anAccount anAccount2 deposit deposit2|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.

	anAccount := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.
	
	deposit := Deposit register: 100 * peso on: anAccount.
	deposit2 := Deposit register: 1000 * peso on: anAccount2.
	
	portfolio addAccount: anAccount .
	portfolio2 addAccount: anAccount2 .
	
	portfolio addAccount: portfolio2.
	
	self assert: (portfolio obtenerTodasLasTransaccionesDe: anAccount2) equals: anAccount2 transactions.! !

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

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 21:32:01'!
test02

	
	"self should: [manager transferFrom: accountA to: accountB  withValue: 300*peso.]
	raise: Error
	withExceptionDo: [: anError |self assert: anError messageText equals: Withdraw errorInsufficientBalance ] "

	! !

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 21:44:07'!
test03

	manager transferFrom: accountA to: accountB  withValue: 50*peso.	
	
	self assert: (accountA valueOfTx: 1) equals: 50*peso.! !

!TransferenciasTest methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 23:35:53'!
test04
	"quitar el mensaje contraParteOfTx reemplazandolo por un mensaje que reciba la transacción"
	
	manager transferFrom: accountA to: accountB  withValue: 50*peso.	
	
	self assert: (accountA contraParteOfTx: 1) equals: accountB.! !


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
	instanceVariableNames: 'value txID contraParte'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'initialization' stamp: 'KG 11/9/2022 22:01:09'!
initializeFor: aValue withTX: aTx

	value := aValue. 
	txID _ aTx.! !

!Deposit methodsFor: 'initialization' stamp: 'KG 11/9/2022 22:44:31'!
initializeFor: aValue withTX: aTx conContraParte: cParte

	value := aValue. 
	txID _ aTx.
	contraParte _ cParte.! !


!Deposit methodsFor: 'value' stamp: 'MMeichtri 11/4/2022 19:31:19'!
balance: aReceptiveAccount

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:40:34'!
contraParte
	^contraParte.! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:18:45'!
tieneTxID: aTx
	^txID = aTx.! !

!Deposit methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/7/2022 21:08:35'!
updateBalance: aBalance

	^ aBalance  + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: 'txID'!

!Deposit class methodsFor: 'instance creation' stamp: 'AER 11/9/2022 19:53:59'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 21:53:57'!
for: aValue tx: aTx

	^ self new initializeFor: aValue withTX: aTx.! !

!Deposit class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 22:37:36'!
for: aValue tx: aTx  conContraParte: contraParte

	^ self new initializeFor: aValue withTX: aTx conContraParte: contraParte.! !

!Deposit class methodsFor: 'instance creation' stamp: 'AER 11/9/2022 20:36:16'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !

!Deposit class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 21:55:50'!
register: aValue on: account withTX: aTxId

	| transaction |
	
	transaction := self for: aValue tx: aTxId.
	account register: transaction.
		
	^ transaction! !

!Deposit class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 22:35:30'!
register: aValue on: account withTX: aTxId other: contraParte

	| transaction |
	
	transaction := self for: aValue tx: aTxId conContraParte: contraParte.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value txID contraParte'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'KG 11/9/2022 21:49:39'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'KG 11/9/2022 22:00:29'!
initializeFor: aValue withTX: aTx

	value := aValue. 
	txID _ aTx.! !

!Withdraw methodsFor: 'initialization' stamp: 'KG 11/9/2022 22:44:06'!
initializeFor: aValue withTX: aTx conContraParte: cParte 

	value := aValue. 
	txID _ aTx.
	contraParte _ cParte.! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:31:40'!
balance: aReceptiveAccount

	^ value! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:40:59'!
contraParte
	^contraParte.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:19:19'!
tieneTxID: aTx
	^txID = aTx.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/7/2022 21:09:00'!
updateBalance: aBalance

	^ aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: 'txID'!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 21:52:04'!
for: aValue tx: aTx

	^ self new initializeFor: aValue withTX: aTx.! !

!Withdraw class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 22:37:23'!
for: aValue tx: aTx conContraParte: contraParte

	^ self new initializeFor: aValue withTX: aTx conContraParte: contraParte.! !

!Withdraw class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 21:30:32'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.	"(account balance < aValue ) ifTrue:[ self error: Withdraw errorInsufficientBalance ]."
	account register: transaction.
		
	^ transaction! !

!Withdraw class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 21:53:12'!
register: aValue on: account withTX: aTxId

	| transaction |
	
	transaction := self for: aValue tx: aTxId.	(account balance < aValue ) ifTrue:[ self error: Withdraw errorInsufficientBalance ].
	account register: transaction.
	^ transaction! !

!Withdraw class methodsFor: 'instance creation' stamp: 'KG 11/9/2022 22:38:08'!
register: aValue on: account withTX: aTxId other: contraParte

	| transaction |
	
	transaction := self for: aValue tx: aTxId  conContraParte: contraParte.	(account balance < aValue ) ifTrue:[ self error: Withdraw errorInsufficientBalance ].
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

!Manager methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:26:42'!
transferFrom: oneSender to: oneReciver withValue: aValue
 	
	Withdraw register: aValue on: oneSender withTX: self nextId other: oneReciver. 
	"onesender := oneSender balance."
	Deposit register: aValue on: oneReciver withTX: self nextId other: oneSender. 
	"onesender := oneReciver balance."
	
	^aValue ."an Id"! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:27:59'!
addAccount: anAccount
	accounts add: anAccount .
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:30:30'!
balance
	^accounts sum: [:anAccount | anAccount balance ] ifEmpty: [^0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'KG 11/10/2022 00:11:15'!
equalTo: anAccount
	"tenemos un problema de recursión, donde devuelve las transacciones y se comparan en obtenerTodasLasTrasaccionesDe (se espera un bool) y eso explota".
	"hay que anidar bien la recursión".
	
	^(self obtenerTodasLasTransaccionesDe: anAccount).! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 23:33:40'!
hasRegistered: aTransaction

	^self includesTransaction: aTransaction.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 23:18:16'!
includesTransaction: aTransaction	accounts do:
		[: anAccount |
		(anAccount hasRegistered: aTransaction) ifTrue:
			[^true]].
	^false! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/8/2022 20:32:18'!
initialize
	accounts := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'KG 11/10/2022 00:07:22'!
obtenerTodasLasTransaccionesDe: unaCuenta
	accounts do:
		[: anAccount |
		(anAccount equalTo: unaCuenta) ifTrue:
			[^anAccount transactions.]].
	^nil.
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 23:50:21'!
transactions

	"no tiene transacciones Portfolio - assert"! !


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

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'KG 11/9/2022 22:56:12'!
hasRegistered: aTransaction
	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MMeichtri 11/7/2022 20:47:57'!
register: aTransaction
		
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'KG 11/9/2022 23:47:47'!
transactions 
	^ transactions copy! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:30:02'!
balanceDeposit

	^ Deposit  value! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MMeichtri 11/4/2022 19:30:12'!
balanceWithdraw

	^ Withdraw  value! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:42:17'!
contraParteOfTx: txID
	
	^(transactions detect: [ :elem | elem tieneTxID: txID]) contraParte.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'KG 11/10/2022 00:05:52'!
equalTo: anAccount
	^(self = anAccount)! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'KG 11/9/2022 22:41:35'!
valueOfTx: txID
	
	^(transactions detect: [ :elem | elem tieneTxID: txID]) value.! !
