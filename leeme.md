README PARA USAR EL PROGRAMA:

ANTES DE CORRERLO:
+ Antes de abrir el proyecto debe modificarse la extensión del archivo en las direcciones:
	* Compilador/src/libs/  
	* Compilador/out/production/Compilador/libs/

	Llamado json-simple.xxx a json.simple.jar

PARA CORRERLO:
+ La carpeta "Compilador" es un proyecto de java programando en IntellliJ, se recomienda abrir con este, no se si Netbeans lo abre pero supongo que si

+ En el main(src/com/company/Main) viene una variable llamada "programa",
  por defecto el string que se le adjunta es "prueba1.kpl",
  este string puede ser modificado por "pruenaN" donde N es un numero entre el 1 y 18(incluyendo estos).

+ Las pruebas vienen en el paquete src/files/

	prueba1 -> bloque de constantes repetido
	prueba2 -> bloque de tipos definidos por el usuario repetidos
	prueba3 -> tipos de datos definidos por el usuario repetidos
	prueba4 -> atributos de un registro repetido
	prueba5 -> variables repetidas
	prueba6 -> warnings de tipos de datos
	prueba7 -> bloque de prototipos repetidas
	prueba8 -> parametros en un prototipo repetidos
	prueba9 -> prototipo repetido
	prueba10 -> constantes repetidas
	prueba11 -> funcion sin prototipo previo
	prueba12 -> funcion con parametros diferentes
	prueba13 -> funcion con parametros diferentes 2
	prueba14 -> funcion con tipo de retorno diferente al del prototipo
	prueba15 -> variables declaradas en el sector de variables de la funcion repetidas
	prueba16 -> declaración de variable en la función pero con un parametro con el mismo nombre
	prueba17 -> tipo de usuario no existente
	prueba18 -> variable no existente

	Una vez modificado este string con el numero de prueba a realizar, se debe ejecutar el proyecto común y silvestre.