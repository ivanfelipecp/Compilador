/*
 * Gramatica.java
 *
 * 2017/05/29 14:50:12
 *
 * Archivo generado por GikGram 2.0
 *
 * Copyright � Olminsky 2011 Derechos reservados
 * Reproducci�n sin fines de lucro permitida
 */

package gramatica;

/**
 * Esta clase contiene:
 * - Constantes necesarias para el driver de parsing
 * - Constantes con las rutinas sem�nticas
 * - Y los m�todos necesarios para el driver de parsing
 */
public abstract class Gramatica
{
	/* Esta es la �nica clase que se accede fuera del paquete Gramatica */

	/**
	 * Constante que contiene el c�digo de familia del terminal de fin de archivo
	 */
	public static final int MARCA_DERECHA = 115;

	/**
	 * Constante que contiene el n�mero del no-terminal inicial
	 * (el primer no-terminal que aparece en la gram�tica)
	 */
	public static final int NO_TERMINAL_INICIAL = 116;

	/**
	 * Constante que contiene el n�mero m�ximo de columnas que tiene los lados derechos
	 */
	public static final int MAX_LADO_DER = 12;

	/**
	 * Constante que contiene el n�mero m�ximo de follows
	 */
	public static final int MAX_FOLLOWS = 76;

	/* Constantes con las rutinas sem�nticas */
	public static final int idPrograma = 212;
	public static final int tipoMu = 213;
	public static final int tipoMi = 214;
	public static final int tipoVit = 215;
	public static final int tipoVey = 216;
	public static final int tipoJaj = 217;
	public static final int tipoDegh = 218;
	public static final int tipoMorgh = 219;
	public static final int tipoUsuario = 220;
	public static final int idTipos = 221;
	public static final int idFuncion = 222;
	public static final int tipoFuncion = 223;
	public static final int setVarRutinas = 224;
	public static final int sotVarRutinas = 225;
	public static final int idProcedimiento = 226;
	public static final int idProtoFuncion = 227;
	public static final int tipoProto = 228;
	public static final int idProtoProcedimiento = 229;
	public static final int reiniciarLista = 230;
	public static final int reiniciarParametro = 231;
	public static final int incrementarPos = 232;
	public static final int tipoParametro = 233;
	public static final int idParametro = 234;
	public static final int parametroFormal = 235;
	public static final int idDeclaracion = 236;
	public static final int agregarVariableNI = 237;
	public static final int agregarVariable = 238;
	public static final int declaracionUsuario = 239;
	public static final int setTipoUsuario = 240;
	public static final int agregarUsuario = 241;
	public static final int idAtributo = 242;
	public static final int agregarAtributo = 243;
	public static final int idConstante = 244;
	public static final int agregarConstante = 245;
	public static final int idAux = 246;
	public static final int arreglo1 = 247;
	public static final int checkConstantes = 248;
	public static final int checkUsuarios = 249;
	public static final int checkProtos = 250;
	public static final int checkRutinas = 251;
	public static final int checkProgramaP = 252;

	/**
	 * M�todo esTerminal
			Devuelve true si el s�mbolo es un terminal
			o false de lo contrario
	 * @param numSimbolo
			N�mero de s�mbolo
	 */
	public static final boolean esTerminal(int numSimbolo)
	{
		return ((0 <= numSimbolo) && (numSimbolo <= 115));
	}

	/**
	 * M�todo esNoTerminal
			Devuelve true si el s�mbolo es un no-terminal
			o false de lo contrario
	 * @param numSimbolo
			N�mero de s�mbolo
	 */
	public static final boolean esNoTerminal(int numSimbolo)
	{
		return ((116 <= numSimbolo) && (numSimbolo <= 211));
	}

	/**
	 * M�todo esSimboloSemantico
			Devuelve true si el s�mbolo es un s�mbolo sem�ntico
			(incluyendo los s�mbolos de generaci�n de c�digo)
			o false de lo contrario
	 * @param numSimbolo
			N�mero de s�mbolo
	 */
	public static final boolean esSimboloSemantico(int numSimbolo)
	{
		return ((212 <= numSimbolo) && (numSimbolo <= 252));
	}

	/**
	 * M�todo getTablaParsing
			Devuelve el n�mero de regla contenida en la tabla de parsing
	 * @param numNoTerminal
			N�mero del no-terminal
	 * @param numTerminal
			N�mero del terminal
	 */
	public static final int getTablaParsing(int numNoTerminal, int numTerminal)
	{
		return GTablaParsing.getTablaParsing(numNoTerminal, numTerminal);
	}

	/**
	 * M�todo getLadosDerechos
			Obtiene un s�mbolo del lado derecho de la regla
	 * @param numRegla
			N�mero de regla
	 * @param numColumna
			N�mero de columna
	 */
	public static final int getLadosDerechos(int numRegla, int numColumna)
	{
		return GLadosDerechos.getLadosDerechos(numRegla, numColumna);
	}

	/**
	 * M�todo getNombresTerminales
			Obtiene el nombre del terminal
	 * @param numTerminal
			N�mero del terminal
	 */
	public static final String getNombresTerminales(int numTerminal)
	{
		return GNombresTerminales.getNombresTerminales(numTerminal);
	}

	/**
	 * M�todo getTablaFollows
			Obtiene el n�mero de terminal del follow del no-terminal
	 * @param numNoTerminal
			N�mero de no-terminal
	 * @param numColumna
			N�mero de columna
	 */
	public static final int getTablaFollows(int numNoTerminal, int numColumna)
	{
		return GTablaFollows.getTablaFollows(numNoTerminal, numColumna);
	}
}
