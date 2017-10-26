package scanner;

import java.io.FileReader;
import java.io.RandomAccessFile;
import static java.lang.Math.toIntExact;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class Scanner {
    private int tabla[][];
    private int buffer[];
    private int fila;
    private int columna;
    private int len;
    private int index;
    
   
    public Scanner(){}
   
    public void InicializarScanner(String programa, String automata){
        try{
            
            RandomAccessFile r = new RandomAccessFile(programa, "r");
            this.len = toIntExact(r.length());
            this.buffer = new int[this.len];
            this.index = 0;
            this.fila = 1;
            this.columna = 0;
            //Llena el buffer con el archivo de entrada
            for(int i = 0; i < len; i++){
                this.buffer[i] = r.read();
            }
            
            //Objetos necesarios para llenar la tabla de transiciones
            JSONParser parser = new JSONParser();
            JSONArray array = (JSONArray) parser.parse(new FileReader(automata));
            this.tabla = new int[array.size()+1][130];
            //Llena las transiciones
            for(int i = 0; i < 129; i++){
                this.tabla[0][i+1] = i;
            }
            
            //crea la tabla de transiciones leyendo el json
            int q;
            JSONObject e;
            for(Object o: array){
                e = (JSONObject) o;
                q = toIntExact((Long) e.get("estado")) + 1;
                this.tabla[q][0] = q;
                for(int i = 0; i < 129; i++){
                    this.tabla[q][i+1] = toIntExact((Long)e.get(String.valueOf(i))) + 1;
                }
            }   
        }
        catch(Exception e){System.out.println(e.toString()+"");}
    }
    
    public Token DemeToken(){
        
        if(this.index >= this.len){
            return null;
        }
        int chr;
        int estado = 1;
        this.columna = 0;
        int idlen = 1;
        String lexema = "";
        while((estado < 300)){
            chr = this.DemeCaracter();
            estado = this.tabla[estado][chr + 1];
            if(chr == 10){
                this.fila++;
            }
            if((estado>1) && (estado!=7) &&(estado!=37) && (estado!=39)){
               if(estado == 2)
                   idlen++;
               lexema += String.valueOf((char)(chr));
            }
            else
                if((chr!=9) && (chr!=10) && (chr!=13) && (chr!=32))
                    lexema = String.valueOf((char)(chr));
                else
                    lexema = "";
            
            if(this.index == this.len){
                //System.out.println("entroxxx con estado"+String.valueOf(estado-1));
                if(lexema.length()>1)
                    lexema = lexema.substring(0, lexema.length()-1);

                if(idlen==17)
                    estado = 804;
                //estado = this.tabla[estado][33];
                //System.out.println(this.buffer[this.index-2]);
                if(this.buffer[this.index-2] != 32){
                    
                    if(estado==53){
                        estado = this.tabla[estado][33];
                        this.index += 10;
                    }
                    this.index--;
                    if(estado < 500)
                        return null;
                                    
                    return new Token(lexema, estado - 501, this.fila, this.columna);
                    //estado = this.tabla[estado][33];
                    //
                }
                else{
                    //System.out.println("elseeee");
                    estado = this.tabla[estado][33];
                   // this.TomeCaracter();
                    this.index++;
                    return new Token(lexema, estado - 501, this.fila, this.columna);
                }
                  //  this.index++;
                //if(estado >= 500)
                
                //else
                  //  return new Token("bug", -2, this.fila, this.columna);
            }
            //System.out.println("Estado "+String.valueOf(estado)+" va a col "+String.valueOf((char) chr));
            //estado estaba aqui
            if(idlen==17)
                estado = 805;
        }
        if(this.index < this.len)
            this.TomeCaracter();
        lexema = lexema.substring(0, lexema.length() - 1);
        //System.out.println("retonado aca ->"+lexema);
        return new Token(lexema, estado - 501, this.fila, this.columna);
    }
    
    public void TomeToken(){
        
    }
    
    public int DemeCaracter(){
        if(this.index == this.len)
            return 32;
        int i = buffer[this.index];
        if(i > 127)
            i = 128;
        this.index++;
        return i;
    }
    
    public void TomeCaracter(){
        if(this.index > 1)
            this.index--;
    }
    
    public int[] getBuffer(){
        return this.buffer;
    }
}
