!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:19'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook millisecondsBeforeRunning millisecondsAfterRunning |
	
	customerBook := CustomerBook new.
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook addCustomerNamed: 'John Lennon'.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook millisecondsBeforeRunning millisecondsAfterRunning paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook removeCustomerNamed: paulMcCartney.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/3/2019 10:50:28'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/30/2020 09:08:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!classDefinition: #Customer category: 'CodigoRepetido-Ejercicio'!
Object subclass: #Customer
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Customer methodsFor: 'as yet unclassified' stamp: 'Kevin 9/26/2022 23:21:52'!
initialize: aName
	
	self subclassResponsibility.! !

!Customer methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:57:57'!
isName: aName
	
	^aName = name.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CodigoRepetido-Ejercicio'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 01:22:29'!
named: aName as: aState
	|aInstance|.

	aInstance _ aState new.
	aInstance initialize: aName.
	^aInstance.
! !


!classDefinition: #Active category: 'CodigoRepetido-Ejercicio'!
Customer subclass: #Active
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Active methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 01:25:38'!
initialize: aName
	name _ aName.! !

!Active methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:34:38'!
isActive
	^true.! !

!Active methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:15:17'!
isInvalid
	^false.! !

!Active methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:35:37'!
isSuspended
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Active class' category: 'CodigoRepetido-Ejercicio'!
Active class
	instanceVariableNames: ''!

!Active class methodsFor: 'as yet unclassified' stamp: 'Kevin 9/26/2022 23:49:11'!
named: aName
	|aClient|.
	aClient _ self new.
	aClient initialize: aName.
	^aClient.! !


!classDefinition: #Invalid category: 'CodigoRepetido-Ejercicio'!
Customer subclass: #Invalid
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Invalid methodsFor: 'as yet unclassified' stamp: 'Kevin 9/26/2022 23:27:52'!
initialize

	name _ ''.! !

!Invalid methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:12:44'!
initialize: aString
	self initialize.! !

!Invalid methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:35:10'!
isActive
	^false.! !

!Invalid methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:15:27'!
isInvalid
	^true.! !

!Invalid methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:35:34'!
isSuspended
	^false! !


!classDefinition: #Suspended category: 'CodigoRepetido-Ejercicio'!
Customer subclass: #Suspended
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!Suspended methodsFor: 'as yet unclassified' stamp: 'Kevin 9/26/2022 23:21:27'!
initialize: aName

	name _ aName.! !

!Suspended methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:35:19'!
isActive
	^false.! !

!Suspended methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:15:35'!
isInvalid
	^false.! !

!Suspended methodsFor: 'as yet unclassified' stamp: 'Kevin 9/27/2022 00:34:54'!
isSuspended
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Suspended class' category: 'CodigoRepetido-Ejercicio'!
Suspended class
	instanceVariableNames: ''!

!Suspended class methodsFor: 'as yet unclassified' stamp: 'Kevin 9/26/2022 23:49:36'!
named: aName
	|aClient|.
	aClient _ self new.
	aClient initialize: aName.
	^aClient.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customer activeCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'Kevin 9/26/2022 22:42:19'!
includesCustomerNamed: aName
	^customer includes: aName
	"^(active includes: aName) or: [ suspended includes: aName ]"! !

!CustomerBook methodsFor: 'testing' stamp: 'Kevin 9/26/2022 22:41:37'!
isEmpty
	^customer isEmpty.
	"^active isEmpty and: [ suspended isEmpty ]"! !


!CustomerBook methodsFor: 'initialization' stamp: 'Kevin 9/27/2022 00:43:07'!
initialize

	super initialize.
	"status _ OrderedCollection new."
	customer _ OrderedCollection new.
	activeCount _ customer size.
	"active := OrderedCollection new."
	"suspended:= OrderedCollection new."! !


!CustomerBook methodsFor: 'customer management' stamp: 'Kevin 9/27/2022 01:27:59'!
addCustomerNamed: aName
	|aCustomer|.
	
	(aName isEmpty) ifTrue: [self signalCustomerNameCannotBeEmpty].
	aCustomer _ Customer named: aName as: Active.
	(customer includes: aCustomer) ifTrue: [ self signalCustomerAlreadyExists ].
	customer add: aCustomer.
	activeCount _ activeCount + 1.! !

!CustomerBook methodsFor: 'customer management' stamp: 'Kevin 9/27/2022 00:44:40'!
numberOfActiveCustomers

	^activeCount.! !

!CustomerBook methodsFor: 'customer management' stamp: 'Kevin 9/27/2022 00:45:00'!
numberOfCustomers
	
	^ customer size.! !

!CustomerBook methodsFor: 'customer management' stamp: 'Kevin 9/27/2022 00:46:04'!
numberOfSuspendedCustomers

	^self numberOfCustomers - self numberOfActiveCustomers. ! !

!CustomerBook methodsFor: 'customer management' stamp: 'Kevin 9/27/2022 01:16:24'!
removeCustomerNamed: aName 
 	"|removeCustomer|."
	
	"removeCustomer _ customer detect: [:client | client isName: aName.]."
	
	
	customer do: [:client | (client isName: aName) ifTrue: [customer remove: client. ^client].].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: 'customer'!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
