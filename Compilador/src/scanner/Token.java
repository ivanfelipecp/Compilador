package scanner;

public class Token {
    private String lexema;
    private int familia;
    private int fila;
    private int columna;

    public Token(String lexema, int familia, int fila, int columna) {
        this.lexema = lexema;
        this.familia = familia;
        this.fila = fila;
        this.columna = columna;
    }

    public String getLexema() {
        return lexema;
    }

    public void setLexema(String lexema) {
        this.lexema = lexema;
    }

    public int getFamilia() {
        return familia;
    }

    public void setFamilia(int familia) {
        this.familia = familia;
    }

    public int getFila() {
        return fila;
    }

    public void setFila(int fila) {
        this.fila = fila;
    }

    public int getColumna() {
        return columna;
    }

    public void setColumna(int columna) {
        this.columna = columna;
    }
    
    @Override
    public String toString(){
        String s = "|";
        s += String.valueOf(this.familia) + "|";
        s += this.lexema;
        return s;
    }
    
    private String space(int i){
        String s = "";
        for(int x = 0; x < i; x++){
            s+= " ";
        }
        return s;
    }
}
