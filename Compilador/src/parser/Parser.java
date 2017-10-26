package parser;

import scanner.Scanner;
import scanner.Token;
import gramatica.Gramatica;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Stack;
import java.util.Set;

public class Parser {
        
        public Parser(){
        }
        
        public void Parsing(String programa, String automata){

            // Variables auxiliares
            int simboloInicial = Gramatica.NO_TERMINAL_INICIAL;
            int EAP;
            int regla;
            int i;
            int pos = 0;
            String nombreAux = "";
            String tipoAux = "";
            String literalAux = "";



            // Objetos auxiliares
            Scanner scanner = new Scanner();
            Stack pila = new Stack();
            Hashtable<String, Elemento> th = new Hashtable<String, Elemento>();
            Hashtable<String, Elemento> t = new Hashtable<String, Elemento>();
            Elemento e = null;
            Elemento funcionAux = null;
            Elemento protoAux = null;
            Elemento rutinaAux = null;
            Elemento parametroAux = null;
            Elemento usuarioAux = null;
            Elemento atributoAux = null;
            Elemento constAux = null;
            Elemento varAux = null;
            Elemento idAux = null;
            ArrayList<Elemento> parametrosAux = new ArrayList<>();

            // Pre configs
            scanner.InicializarScanner(programa, automata);
            Token TA = scanner.DemeToken();
            pila.push(simboloInicial);

            // Banderas y stacks para el parsing
            boolean banderaSemantica = true;
            boolean banderaPrograma = false;
            boolean banderaConstantes = false;
            boolean banderaUsuarios = false;
            boolean banderaVariables = false;
            boolean banderaPrototipos = false;
            boolean banderaRutinas = false;
            boolean banderaPrincipal = false;
            boolean banderaParametroFormal = false;
            boolean banderaMorgh = false;
            boolean banderaReturn = false;
            boolean banderaVarRutinas = false;


            // Algoritmo de parsing y semantico
            while((TA != null) && banderaSemantica){
                 if(pila.empty()) break;
                 EAP = (int) pila.pop();
                 if(Gramatica.esTerminal(EAP)){
                     if(EAP == TA.getFamilia()) {
                         TA = scanner.DemeToken();
                         if(TA != null) {
                             if (TA.getFamilia() >= 300) {
                                 System.out.println("Error Léxico detectado por el parser");
                                 System.out.println("En la linea " + String.valueOf(TA.getFila()) + " con "+TA.getLexema());
                                 System.out.println("Puede que la gramática lo esperaba o el error es con ese lexema");
                                 break;
                             }
                         }
                     }
                     else{
                         System.out.println("Error sintactico, token esperado");
                         System.out.println("En la linea "+String.valueOf(TA.getFila())+" columna "+String.valueOf(TA.getColumna()));
                         System.out.println("Se esperaba "+Gramatica.getNombresTerminales(EAP)+ " y recibio "+Gramatica.getNombresTerminales(TA.getFamilia()));
                         System.out.println("Revise el lexema "+TA.getLexema());
                         break;
                     }
                 }
                 else if (Gramatica.esNoTerminal(EAP)){
                     regla = Gramatica.getTablaParsing(EAP - simboloInicial, TA.getFamilia());

                     if(regla < 0){
                         System.out.println("ERROR SINTACTICO");
                         System.out.println("En la linea "+String.valueOf(TA.getFila()));
                         System.out.println(TA.getLexema()+" fuera de lugar");
                         break;
                     }
                     else{
                         i = 0;
                         while((Gramatica.getLadosDerechos(regla, i) > -1) && (i < Gramatica.MAX_LADO_DER)){
                             pila.push(Gramatica.getLadosDerechos(regla, i));
                             i++;
                             if(i == Gramatica.MAX_LADO_DER)
                                 break;
                         }
                     }
                 }
                 else{ //es simbolo semantico
                     switch (EAP){
                         case Gramatica.idPrograma:
                             if(!banderaPrograma){
                                 th.put(TA.getLexema(), new Elemento("PR",TA.getLexema()));
                                 banderaPrograma = true;
                             }
                             else {
                                 banderaSemantica = false;
                                 System.out.println("Ya existe la seccion del nombre del programa");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                             }
                             break;
                         case Gramatica.idTipos:
                             e = th.get(TA.getLexema());
                             if(e==null){
                                 banderaSemantica = false;
                                 System.out.println("Tipo de dato de usuario no existente");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                             }
                             else if(!e.queSoy.equals("U")){
                                 banderaSemantica = false;
                                 System.out.println("Tipo de dato de usuario no existente");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                             }
                             break;
                         case Gramatica.idFuncion:
                             e = th.get(TA.getLexema());
                             if(e==null){
                                 System.out.println("No existe el prototipo previo de la función");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }
                             else{
                                 if(e.queSoy.equals("PF") && (e.id.equalsIgnoreCase(TA.getLexema()))){
                                     funcionAux = new Elemento("F",TA.getLexema());
                                     rutinaAux = funcionAux;
                                     //th.put(TA.getLexema(), funcionAux);
                                 }
                                 else{
                                     System.out.println("El nombre en uso no es el prototipo de la función");
                                     System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                     banderaSemantica = false;
                                 }
                             }
                             break;
                         case Gramatica.tipoFuncion:
                             //System.out.println("entro a tipoFuncion");
                             //funcionAux.tipo = TA.getLexema();
                             //funcionAux = null;
                             int l = parametrosAux.size();
                             e = th.get(funcionAux.id); //jalamos el prototipo
                             funcionAux = e;
                             if(e==null){
                                 System.out.println("La funcion no esta previamente definida");
                                 banderaSemantica = false;
                             }

                             //si los parametros son diferentes o el tipo
                             else if((l != e.parametros.size()) || (!TA.getLexema().equalsIgnoreCase(e.tipo))){
                                 System.out.println("La funcion tiene un error con la diferencia de parametros o tipo del retorno");
                                 banderaSemantica = false;
                             }
                             else{ //pasa a comparar los parametros
                                 boolean b = true;
                                 //System.out.println(parametrosAux.size());
                                 for(int j = 0; j < parametrosAux.size(); j++){
                                     if((parametrosAux.get(j).pos != e.parametros.get(j).pos) ||
                                     !(parametrosAux.get(j).id.equalsIgnoreCase(e.parametros.get(j).id)) ||
                                     !(parametrosAux.get(j).tipo.equalsIgnoreCase((e.parametros.get(j).tipo)))){
                                         b = false;
                                         break;
                                     }
                                     //System.out.println("+"+String.valueOf(parametrosAux.get(j).pos));
                                     //System.out.println("-"+String.valueOf(e.parametros.get(j).pos));
                                 }
                                 if (b){
                                     e.queSoy = "F";
                                 }
                                 else{
                                     System.out.println("La funcion tiene los parametros diferentes o en desorden");
                                     banderaSemantica = false;
                                 }
                                //hay que probar esta madre
                                 e = null;
                             }
                             break;
                         case Gramatica.idProtoFuncion:
                             e = th.get(TA.getLexema());
                             if(e==null){
                                 protoAux = new Elemento("PF",TA.getLexema());
                                 rutinaAux = protoAux;
                                 th.put(TA.getLexema(), protoAux);
                             }
                             else{
                                 System.out.println("Ya está en uso ese nombre");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }
                             break;
                         case Gramatica.tipoProto:
                             protoAux.tipo = TA.getLexema();
                             break;
                         case Gramatica.idProcedimiento:
                             e = th.get(TA.getLexema());
                             if(e==null){
                                 System.out.println("No existe el prototipo previo del procedimiento");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }
                             else{
                                 if(e.queSoy.equals("PP")){
                                     funcionAux = new Elemento("P",TA.getLexema());
                                     rutinaAux = funcionAux;
                                     th.put(TA.getLexema(), funcionAux);
                                 }
                                 else{
                                     System.out.println("El nombre en uso no es el prototipo de la función");
                                     System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                     banderaSemantica = false;
                                 }
                             }
                             break;
                         case Gramatica.idProtoProcedimiento:
                             e = th.get(TA.getLexema());
                             if(e==null){
                                 protoAux =  new Elemento("PP",TA.getLexema());
                                 th.put(TA.getLexema(),protoAux);
                                 rutinaAux = protoAux;
                             }
                             else{
                                 System.out.println("Ya está en uso ese nombre");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }
                             break;
                         // vas por el case del parametro
                         case Gramatica.reiniciarLista:
                             parametrosAux.clear();
                             pos = 0;
                             break;
                         case Gramatica.parametroFormal:
                             banderaParametroFormal = true;
                             break;
                         case Gramatica.tipoParametro:
                             tipoAux = TA.getLexema();

                             break;
                         case Gramatica.idParametro:
                             nombreAux = TA.getLexema();
                             if(rutinaAux.queSoy.equals("PP") || rutinaAux.queSoy.equals("PF")) {
                                 e = th.get(nombreAux);
                                 if(e!=null){
                                     if(e.queSoy.equalsIgnoreCase("PA") && (e.id.equalsIgnoreCase(nombreAux)) && e.pertenece.equalsIgnoreCase(rutinaAux.id)){
                                         System.out.println("Ya existe un parametro con ese nombre en la funcion/rutina");
                                         System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                         banderaSemantica = false;
                                     }
                                 }
                                 parametroAux = new Elemento("PA",nombreAux,tipoAux,banderaParametroFormal,rutinaAux.id,pos);
                                 th.put(TA.getLexema(), parametroAux);

                                 th.get(rutinaAux.id).parametros.add(parametroAux);
                             }
                             else if (rutinaAux.queSoy.equals("P")|| rutinaAux.queSoy.equals("F")){
                                 // voy por la parte de validar si existe el parametro al otro lado y si esta en la pos correcta
                                 //no pierdas la esperanza!!!
                                 parametrosAux.add(new Elemento("PA",nombreAux,tipoAux,banderaParametroFormal,rutinaAux.id,pos));

                             }
                             else{
                                 System.out.println("Intenta asignar parametros a una funcion u otra cosa random");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }

                             break;
                         case Gramatica.reiniciarParametro:
                             banderaParametroFormal = false;
                             break;
                         case Gramatica.incrementarPos:
                             pos++;
                             break;
                         case Gramatica.declaracionUsuario:
                             e = th.get(TA.getLexema());
                             if(e!=null){
                                 System.out.println("Intenta crear un tipo de dato que ya existe");
                                 System.out.println("Error detectado en la linea "+String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }
                             else {
                                 usuarioAux = new Elemento("U", TA.getLexema());
                                 //System.out.println(usuarioAux.id+"--");
                             }
                             break;
                         case Gramatica.setTipoUsuario:
                             usuarioAux.tipo = TA.getLexema();
                             //th.put(usuarioAux.id,usuarioAux);
                             //usuarioAux = null;
                             break;
                         case Gramatica.agregarUsuario:
                             th.put(usuarioAux.id,usuarioAux);
                             usuarioAux = null;
                             break;
                         case Gramatica.idAtributo:
                             if(usuarioAux.campos.size()==0){
                                 atributoAux = new Elemento("AT",TA.getLexema(),tipoAux);
                             }
                             else{
                                 for(Elemento z:usuarioAux.campos){
                                     if(z.id.equalsIgnoreCase(TA.getLexema())){
                                         System.out.println("Intenta crear atributo ya existe en ese registro");
                                         System.out.println("Error detectado en la linea " + String.valueOf(TA.getFila()));
                                         banderaSemantica = false;
                                     }
                                 }
                                 atributoAux = new Elemento("AT",TA.getLexema(),tipoAux);
                             }

                            break;
                         case Gramatica.agregarAtributo:
                             usuarioAux.campos.add(atributoAux);
                             break;

                         case Gramatica.idConstante:
                             e = th.get(TA.getLexema());
                             if(e==null){
                                 constAux = new Elemento("C", TA.getLexema(),tipoAux);
                             }
                             else{
                                 System.out.println("Intenta crear un constante con un nombre ya existente");
                                 System.out.println("Error detectado en la linea " + String.valueOf(TA.getFila()));
                                 banderaSemantica = false;
                             }
                             break;
                         case Gramatica.agregarConstante:
                             //hay que validar la expresion
                             //constAux.valorInicial = pensando en que poner aqui
                             //System.out.println(literalAux);
                             //System.out.println(tipoAux);
                             if(!literalAux.equalsIgnoreCase(tipoAux))
                                 System.out.println("Warning de tipo diferente en la linea "+String.valueOf(TA.getFila())+" se va convertir de "+literalAux+" a "+tipoAux);
                             th.put(constAux.id ,constAux);
                             banderaMorgh = false;
                             break;
                         case Gramatica.tipoMi:
                             if(!banderaMorgh)
                             literalAux = "Mi'";
                             break;
                         case Gramatica.tipoMu:
                             if(!banderaMorgh)
                             literalAux = "Mu'";
                             break;
                         case Gramatica.tipoJaj:
                             if(!banderaMorgh)
                             literalAux = "Jaj";
                             break;
                         case Gramatica.tipoDegh:
                             if(!banderaMorgh)
                             literalAux = "Degh";
                             break;
                         case Gramatica.tipoVit:
                             if(!banderaMorgh)
                             literalAux = "Vit";
                             break;
                         case Gramatica.tipoVey:
                             if(!banderaMorgh)
                             literalAux = "Vey";
                             break;
                         case Gramatica.tipoMorgh:
                             if(banderaMorgh){
                                 literalAux = "Morgh";
                                 banderaMorgh = false;
                             }

                             break;
                         case Gramatica.tipoUsuario:
                             if(!banderaMorgh)
                             literalAux = TA.getLexema();
                             break;
                         case Gramatica.setVarRutinas:
                             banderaVarRutinas = true;
                             t.clear();
                             break;
                         case Gramatica.sotVarRutinas:
                             banderaVarRutinas = false;
                             break;
                         case Gramatica.idDeclaracion:
                             //t y th, en tipo aux está el tipo
                             nombreAux = TA.getLexema();
                             e = th.get(nombreAux);
                             if(e!=null){
                                 System.out.println("Intenta crear una variable ya existente en la seccion de variables");
                                 banderaSemantica = false;
                             }
                             e = t.get(nombreAux);
                             if(e!=null){
                                 System.out.println("Intenta crear una variable ya existente en el bloque de variables local");
                                 banderaSemantica = false;
                             }
                             else{
                                 //if(banderaVarRutinas){
                                 varAux = new Elemento("V", nombreAux, tipoAux);
                                 //}
                             }
                             break;

                         case Gramatica.agregarVariableNI:
                             if(banderaVarRutinas)
                                 t.put(varAux.id, varAux);
                             else
                                 th.put(varAux.id, varAux);
                             break;
                         case Gramatica.agregarVariable:
                             if(!literalAux.equalsIgnoreCase(tipoAux))
                                 System.out.println("Warning de tipo diferente en la linea "+String.valueOf(TA.getFila())+" se va convertir de "+literalAux+" a "+tipoAux);
                             if(banderaVarRutinas)
                                 t.put(varAux.id, varAux);
                             else
                                 th.put(varAux.id, varAux);
                             banderaMorgh = false;
                             break;
                         case Gramatica.idAux:
                             idAux = t.get(TA.getLexema());
                             if(idAux==null){
                                 idAux = th.get(TA.getLexema());
                                 if(idAux == null){
                                     System.out.println("La variable/funcion no existe");
                                     banderaSemantica = false;
                                 }
                             }
                             break;
                         case Gramatica.checkConstantes:
                             if(banderaConstantes){
                                 System.out.println("La seccion de constantes ya existe");
                                 banderaSemantica = false;
                             }
                             else
                                 banderaConstantes = true;
                             break;
                         case Gramatica.checkProtos:
                             if(banderaPrototipos){
                                 System.out.println("La seccion de prototipos ya existe");
                                 banderaSemantica = false;
                             }
                             else
                                 banderaPrototipos = true;
                             break;
                         case Gramatica.checkRutinas:
                             if(banderaRutinas){
                                 System.out.println("La seccion de rutinas ya existe");
                                 banderaSemantica = false;
                             }
                             else
                                 banderaRutinas = true;
                             break;
                         case Gramatica.checkUsuarios:
                             if(banderaUsuarios){
                                 System.out.println("La seccion de usuarios ya existe");
                                 banderaSemantica = false;
                             }
                             else
                                 banderaUsuarios = true;
                             break;
                         case Gramatica.checkProgramaP:
                             if(banderaPrincipal){
                                 System.out.println("La seccion del programa principal ya existe");
                                 banderaSemantica = false;
                             }
                             else
                                 banderaPrincipal = true;
                             break;
                     }

                 }
            }
            if(pila.empty()){
                System.out.println("Parsiado correctamente");
            }
            if(!banderaSemantica){
                System.out.println("Error semántico");
                System.out.println("Con "+TA.getLexema()+", linea "+String.valueOf(TA.getFila()));
            }


            /*Set<String> keys = th.keySet();
            String id;
            String queSoy;
            String tipo;
            String campos = "";
            String parametros;
            Elemento temp;
            ArrayList<Elemento> lest;
            System.out.println("id"+"\t"+"tipo"+"\t"+"queSoy"+"\t"+"campos");
            for (String s: keys) {
                //System.out.println(s)
                campos = "";
                temp = th.get(s);
                id = temp.id;
                queSoy = temp.queSoy;
                tipo = temp.tipo;
                if(temp.parametros!=null){

                    for(Elemento es:temp.parametros){
                        campos += es.id+"-"+es.tipo+" ,";
                    }
                }
                System.out.println(id+"\t"+tipo+"\t"+queSoy+"\t"+campos);
            }*/
        }


}
