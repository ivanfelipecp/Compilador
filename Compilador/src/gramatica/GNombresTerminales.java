/*
 * GNombresTerminales.java
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
 * Esta clase contiene los nombres de los terminales
 * y los m�todos necesarios para acceder a ella
 */
abstract class GNombresTerminales
{
	/**
	 * Contiene los nombres de los terminales
	 */
	private static final String[] NombresTerminales =
	{
		"id",
		"$$",
		"$+",
		"$?",
		"&!",
		"&+",
		"&++",
		"&-",
		"&--",
		"(",
		")",
		"*",
		"*=",
		"+",
		"++",
		"+=",
		",",
		"-",
		"--",
		"-=",
		"/",
		"//",
		"//=",
		"/=",
		":",
		":=",
		"<",
		"<<",
		"<=",
		"<>",
		"==",
		">",
		">=",
		">>",
		"@#?",
		"@$?",
		"@<<",
		"@>>",
		"[",
		"]",
		"^",
		"{",
		"}",
		"|+=",
		"|++=",
		"|+++=",
		"|#|",
		"|##|",
		"|###|",
		"\'ej",
		"Be\'",
		"Bup",
		"Chen",
		"Choh",
		"Chu\'",
		"Chugh",
		"Degh",
		"Duh",
		"Ghap",
		"&-=",
		"Gho\'",
		"Ghom",
		"Ghor",
		"Ghu",
		"Ghun",
		"Hegh",
		"Hijol",
		"Hoch",
		"Jaj",
		"Jog",
		"$+=",
		"Latlh",
		"Leq",
		"Lo\'",
		"Meh",
		"Mi\'",
		"Miw",
		"Mo\'",
		"Morgh",
		"Mu\'",
		"Nagh",
		"Nawlogh",
		"Ngeb",
		"Ni\'",
		"Pigh",
		"Pong",
		"Qa\'",
		"Qap",
		"Qo\'",
		"Qod",
		"Qonos",
		"Sar",
		"Segh",
		"Suq",
		"Ta",
		"Tadmoh",
		"Tagh",
		"Tah",
		"Teh",
		"Vaj",
		"Vey",
		"Vis",
		"Vit",
		"<%:",
		":%>",
		"|<?",
		"|>?",
		"|",
		"literalEntero",
		"literalChar",
		".",
		"literalCadena",
		"&+=",
		"~",
		"$",
		" EOF "
	};

	/**
	 * M�todo getNombresTerminales
			Obtiene el nombre del terminal
	 * @param numTerminal
			N�mero del terminal
	 */
	static final String getNombresTerminales(int numTerminal)
	{
		return NombresTerminales[numTerminal];
	}
}
