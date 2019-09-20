package exemplos;

import busca.AEstrela;
import busca.Estado;
import busca.MostraStatusConsole;
import busca.Nodo;


public class EstadoElevadorDificil extends EstadoElevador {
	
    public EstadoElevadorDificil(int[] e, String o) {
    	super(e,o);
    }
    
    public String getDescricao() {
        return "http://www.plastelina.net/games/game5.html (versao DIFICIL)";
    }

    @Override
    protected int getObjetivoMax() {
    	return 23;
    }

    @Override
    public EstadoElevador clone(String op) {
    	return new EstadoElevadorDificil(elevadores, op);
    }
    
    public static void main(String[] a) {
        Estado inicial  = new EstadoElevadorDificil(new int[] {17,26,20,19,31}, "inicial");

        AEstrela ae = new AEstrela(new MostraStatusConsole());
        //ae.setPodar(true);
        //ae.usarFechados(true);
        Nodo n = ae.busca(inicial);
        if (n == null) {
            System.out.println("sem solucao!");
        } else {
            System.out.println("solucao:\n" + n.montaCaminho() + "\n\n");
        }
    }
}

