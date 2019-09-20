package exemplos;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import busca.AEstrela;
import busca.BuscaIterativo;
import busca.Estado;
import busca.Heuristica;
import busca.MostraStatusConsole;
import busca.Nodo;


public class EstadoElevador implements Estado, Heuristica {
	
    final int[] elevadores;
    final String op; // operacao que gerou o estado
    
    public EstadoElevador(int[] e, String o) {
        elevadores = Arrays.copyOf(e, e.length);
        op = o;
    }

    protected int getObjetivoMax() {
    	return 25;
    }
    
    public String getDescricao() {
        return "http://www.plastelina.net/games/game5.html (versao FACIL)";
    }
    
    public boolean ehMeta() {
    	for (int e: elevadores)
    		if (e > getObjetivoMax() || e < 21) // versao facil
    			return false;
        return true;
    }
    
    @Override
    public int h() {
    	int h = 0;
    	for (int e: elevadores) {
    		// conta elevadores fora do lugar
    		//if (e > getObjetivoMax() || e < 21)
    		//	h++;
    		if (e > getObjetivoMax())
    			h += 1+((e-getObjetivoMax())/13);
    		if (e < 21)
    			h += 1+((21-e)/8);    		
    	}
    	return h;
    }
    
    public boolean equals(Object o) {
        if (o instanceof EstadoElevador) {
            EstadoElevador e = (EstadoElevador)o;
            for (int i=0; i<elevadores.length; i++)
            	if (elevadores[i] != e.elevadores[i])
            		return false;
            return true;
        }
        return false;
    }

    public int hashCode() {
    	int s = 37;
    	for (int i=0; i<elevadores.length; i++)
    		s += elevadores[i] * i;
        return s;
    }
    
    
    public List<Estado> sucessores() {
        List<Estado> suc = new LinkedList<Estado>(); // a lista de sucessores

        for (int i=0; i<elevadores.length; i++) {
        	for (int j=0; j<elevadores.length; j++) {
        		if (j>i) {
	        		// sobe 8
        			EstadoElevador n = clone("sobe");
	        		n.elevadores[i] += 8;
	        		n.elevadores[j] += 8;
	        		if (n.valido())
	        			suc.add(n);
	
	        		// desce 13
        			n = clone("desce");
	        		n.elevadores[i] -= 13;
	        		n.elevadores[j] -= 13;
	        		if (n.valido())
	        			suc.add(n);
        		}
        	}
        }
        return suc;
    }
    
    public EstadoElevador clone(String op) {
    	return new EstadoElevador(elevadores, op);
	}
    
    boolean valido() {
    	for (int i: elevadores)
    		if (i < 0 || i > 49)
    			return false;
    	return true;
    }
    
    public String toString() {
    	String s = "[ ";
    	for (int e: elevadores)
    		s += e + " ";
        return s+"]";
    }
    
    
    public int custo() {
        return 1;
    }
    
    public static void main(String[] a) {
        Estado inicial  = new EstadoElevador(new int[] {17,26,20,19,31}, "inicial");

        /*Nodo n = new BuscaLargura().busca(inicial);
        if (n == null) {
            System.out.println("sem solucao!");
        } else {
            System.out.println("solucao:\n" + n.montaCaminho() + "\n\n");
        }
        */
        
        System.out.println("busca em profundidade iterativo");
        Nodo n = new BuscaIterativo(new MostraStatusConsole()).busca(inicial);
        if (n == null) {
            System.out.println("sem solucao!");
        } else {
            System.out.println("solucao:\n" + n.montaCaminho() + "\n\n");
        }

        n = new AEstrela(new MostraStatusConsole()).busca(inicial);
        if (n == null) {
            System.out.println("sem solucao!");
        } else {
            System.out.println("solucao:\n" + n.montaCaminho() + "\n\n");
        }
}
}

