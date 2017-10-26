package com.company;
import parser.Parser;
import parser.Elemento;
import scanner.Scanner;
import scanner.Token;

import java.util.Hashtable;

public class Main {

    public static void main(String[] args) {
        String ruta = "src/files/";
        String programa = ruta+"prueba1.kpl";
        String automata = ruta+"machine.json";
        parser(programa, automata);
    }

    public static void parser(String pr, String a){
        Parser p = new Parser();
        p.Parsing(pr, a);
    }

    public static void scanner(String pr, String a){
        Scanner s = new Scanner();
        s.InicializarScanner(pr, a);

        Token t = null;
        t = s.DemeToken();
        while((t!=null) && (t.getFamilia()<800)){
            System.out.println(t.toString());
            t = s.DemeToken();
        }
        try{
            System.out.println(t.toString());}
        catch(Exception e){}
    }
}
