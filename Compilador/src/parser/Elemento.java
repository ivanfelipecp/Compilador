package parser;

import javax.xml.bind.Element;
import java.util.ArrayList;

/**
 * Created by ivanfelipecp on 22/5/2017.
 */
public class Elemento {
    public String queSoy;
    public String id;
    public String tipo;
    public String valorInicial;
    public ArrayList<Elemento> parametros;
    public boolean formal;
    public String pertenece;
    public int pos;
    public ArrayList<Elemento> campos;
    public int tam;

    public Elemento(String queSoy, String id, String tipo, String valorInicial) {
        this.queSoy = queSoy;
        this.id = id;
        this.tipo = tipo;
        this.valorInicial = valorInicial;
        this.parametros = null;
        this.formal = false;
        this.pertenece = "";
        this.pos = -1;
        this.campos = null;
        this.tam = -1;
    }

    public Elemento(String queSoy, String id, String tipo){
        this.queSoy = queSoy;
        this.id = id;
        this.tipo = tipo;
        this.valorInicial = null;
        this.parametros = new ArrayList<>();
        this.formal = false;
        this.pertenece = "";
        this.pos = -1;
        this.campos = null;
        this.tam = -1;
    }

    public Elemento(String queSoy, String id){
        this.queSoy = queSoy;
        this.id = id;
        if(queSoy.equals("PR")) {
            this.parametros = null;
            //System.out.println("entro aca");
        }
        else if(queSoy.equals("U")) {
            this.campos = new ArrayList<>();
            //System.out.println("entro aca");
        }
        else {
            this.parametros = new ArrayList<>();
            //System.out.println("creo parametros");
        }
        this.valorInicial = null;
        this.formal = false;
        this.pertenece = "";
        this.pos = -1;
        this.tam = -1;
    }

    public Elemento(String queSoy, String id, String tipo, boolean formal, String pertenece, int pos) {
        this.queSoy = queSoy;
        this.id = id;
        this.tipo = tipo;
        this.formal = formal;
        this.pertenece = pertenece;
        this.pos = pos;
        this.valorInicial = null;
        this.parametros = null;
        this.campos = null;
        this.tam = -1;
    }
}
