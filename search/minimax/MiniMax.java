import java.util.*;


/**
 *   Algoritmos de MiniMax (geral, qquer problema)
 *   (baseado no Russel & Norvig)
 *
 *   @author Jomi Fred Hübner
 */
public class MiniMax {
    
    public static boolean parar = false;
    
    private int profMax = Integer.MAX_VALUE;
    private Random random = new Random();
    int visitados = 0;
    
    public MiniMax() {
    }
    
    public MiniMax(int profundidadeMaxima) {
        profMax = profundidadeMaxima;
    }
    
    public double max(EstadoUtilidade estadoCorrente) {
        visitados = 0;
        return max(estadoCorrente, 1);
    }    
    
    
    /**
     *
     * MiniMax, retorna a utilidade máxima de um estado
     *
     */
    public double max(EstadoUtilidade estadoCorrente, int p) {
        
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            return estadoCorrente.calculaUtilidade();
        }
        
        double maximo = -10000; // Double.MIN_VALUE não funciona!;
        Iterator i = estadoCorrente.sucessores().iterator();
        while (i.hasNext()) {
            visitados++;
            EstadoUtilidade sucessor = (EstadoUtilidade)i.next();
            double minSucessor = min( sucessor, p+1);

            if (minSucessor > maximo || (minSucessor == maximo && random.nextBoolean())) {
                maximo = minSucessor;
                estadoCorrente.setUtilidade( maximo );
                estadoCorrente.setProxJogada( sucessor );
            }
            
        }
        return maximo;
    }
    
    /**
     *
     * MiniMax, retorna a utilidade mínima de um estado
     *
     */
    public double min(EstadoUtilidade estadoCorrente, int p) {
        
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            return estadoCorrente.calculaUtilidade();
        }
        
        double minimo = 100000;
        Iterator i = estadoCorrente.sucessores().iterator();
        while (i.hasNext()) {
            visitados++;
            EstadoUtilidade sucessor = (EstadoUtilidade)i.next();
            double maxSucessor = max( sucessor, p+1);
            
            if (maxSucessor < minimo || (maxSucessor == minimo && random.nextBoolean())) {
                minimo = maxSucessor;
                estadoCorrente.setUtilidade( minimo );
                estadoCorrente.setProxJogada( sucessor );
            }
        }
        return minimo;
    }
    
}
