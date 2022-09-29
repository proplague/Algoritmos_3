!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:32'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'AER 9/28/2022 21:08:29'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:43'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'AER 9/28/2022 21:08:44'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:28'!
test10AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:42'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (twoFifth) * (fiveHalfs) ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:04:04'!
test14NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated! !

!NumeroTest methodsFor: 'tests' stamp: 'AER 9/28/2022 21:08:56'!
test15NegationOfFraccionIsCorrect

	self assert: (Fraccion with: negativeOne over: two) equals: oneHalf negated! !

!NumeroTest methodsFor: 'tests' stamp: 'AER 9/28/2022 21:09:04'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'AER 9/28/2022 21:09:10'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'AER 9/28/2022 21:04:41'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth := Fraccion with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: 'type value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 20:51:06'!
* aMultiplier
	self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 21:21:39'!
+ anAdder
	self subclassResponsibility .! !







"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'AER 9/28/2022 21:05:55'!
with: anInteger
	self subclassResponsibility .! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 20:48:10'!
* aMultiplier 

	(aMultiplier type = #Entero) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].	
		
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 21:20:32'!
+ anAdder 
	
	(anAdder type = #Entero) ifTrue:
		[^self class with: value + anAdder integerValue ].
	
	self error: 'Tipo de número no soportado'
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 21:13:32'!
negated
		^self * (self class with: -1).! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'AER 9/28/2022 21:23:56'!
// aDivisor 
		^self class with: value // aDivisor integerValue
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'AER 9/28/2022 21:26:51'!
greatestCommonDivisorWith: anEntero 
	^self class with: (value gcd: anEntero integerValue).! !


!Entero methodsFor: 'comparing' stamp: 'AER 9/28/2022 21:41:20'!
= anObject

	^(anObject isKindOf: self class) and: [ type = anObject type and: 
		[ value = anObject integerValue]]! !

!Entero methodsFor: 'comparing' stamp: 'AER 9/28/2022 21:27:50'!
hash
	^value hash .! !


!Entero methodsFor: 'testing' stamp: 'AER 9/28/2022 21:30:07'!
isNegative
	^value < 0 
	! !

!Entero methodsFor: 'testing' stamp: 'AER 9/28/2022 21:31:17'!
isOne

	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'AER 9/28/2022 21:35:05'!
isZero
	 ^value = 0.! !


!Entero methodsFor: 'accessing' stamp: 'AER 9/28/2022 21:43:03'!
integerValue
	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	^value! !

!Entero methodsFor: 'accessing' stamp: 'AER 9/28/2022 21:33:59'!
type

	^#Entero! !


!Entero methodsFor: 'printing' stamp: 'AER 9/28/2022 21:37:31'!
printOn: aStream
	aStream print: value.! !


!Entero methodsFor: 'initialization' stamp: 'AER 9/28/2022 22:28:27'!
initializeWith: aValue
	type := #Entero. 
	value := aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte1-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'AER 9/28/2022 22:27:28'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
		
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 20:48:50'!
* aMultiplier 
	(aMultiplier type = #Fraccion) ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ].
	self error: 'Tipo de número no soportado'
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 21:20:57'!
+ anAdder 
	
	(anAdder type = #Fraccion) ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ].
	
	self error: 'Tipo de número no soportado'
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AER 9/28/2022 21:19:27'!
negated

	 ^self class with: numerator * (Entero with: -1) over: denominator. ! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AER 9/28/2022 21:24:09'!
// aDivisor 
	self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'AER 9/28/2022 21:27:04'!
greatestCommonDivisorWith: anEntero 
	self error: 'Tipo de número no soportado'! !


!Fraccion methodsFor: 'comparing' stamp: 'AER 9/28/2022 21:42:03'!
= anObject

	^(anObject isKindOf: self class) and: [ type = anObject type and: 
		[  (numerator * anObject denominator) = (denominator * anObject numerator) ]].! !

!Fraccion methodsFor: 'comparing' stamp: 'AER 9/28/2022 21:28:14'!
hash
		 ^(numerator hash / denominator hash) hash.! !


!Fraccion methodsFor: 'testing' stamp: 'AER 9/28/2022 21:30:30'!
isNegative
		 ^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'AER 9/28/2022 21:31:45'!
isOne
		^false .! !

!Fraccion methodsFor: 'testing' stamp: 'AER 9/28/2022 21:35:29'!
isZero
	 ^false .! !


!Fraccion methodsFor: 'accessing' stamp: 'AER 9/28/2022 21:36:16'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'AER 9/28/2022 21:36:11'!
numerator

	^numerator! !

!Fraccion methodsFor: 'accessing' stamp: 'AER 9/28/2022 21:34:19'!
type

	^#Fraccion! !


!Fraccion methodsFor: 'printing' stamp: 'AER 9/28/2022 21:38:01'!
printOn: aStream
	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator.! !


!Fraccion methodsFor: 'initialization' stamp: 'AER 9/28/2022 22:29:14'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].	
	type := #Fraccion. 

	numerator := aNumerator.
	denominator := aDenominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte1-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'AER 9/28/2022 21:01:50'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !
