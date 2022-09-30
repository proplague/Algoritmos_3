# Respuestas ejercicios

## Preguntas teóricas

 

1. En un double dispatch ()DD), ¿qué información aporta cada uno de los dos llamados?

 

    En un double dispatch se delega el llamado de un método a dos métodos distíntos dependiendo el objeto al cual se lo llama. En este caso, la información que aporta el objeto es el tipo, porque si el numero es un entero el mensaje se trata de una forma y si es fracción se lo trata de otra.

 

2. Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?

 

    La lógica de cómo instaciar un objeto conviene que esté presente en el objeto o la clase concreta, y no en la clase padre, porque un entero no se puede crear como una fracción por ejemplo, entonces necesitan tener métodos distintos de inicialización.

 

    En caso que se cree el objeto desde diferentes lugares y formas, cada objeto deberá tener su inicializador particular.

 

    Nosotros lo resolvimos delegando la responsabilidad de crear objeto en los hijos.

 

3.  Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?

   

    EL método para categorizar objetos es ordenarlos segun un modelo jerarquizado de la realidad.

4. Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?

 

    Tenemos que poner self subclassResponsability para aclarar que la clase es abstracta y que la implementación del objeto se da en sus subclases.

5. ¿Por qué está mal/qué problemas trae romper encapsulamiento?

 

    Está mal romper el encapsulamiento porque fuerza el acoplamiento de un objeto con cualquier cosa del exterior.
