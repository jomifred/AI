import java.util.*;


/**
 *   Algoritmos de MiniMax (geral, qquer problema)
 *   com poda alpha/beta
 *
 *   (baseado no Russel & Norvig)
 *
 *   obs.: no jogo da velha, segunda jogada, 
 *   o MiniMax (sem alpha/beta) visita 59704
 *   nodos, enquanto o MiniMaxAB (com poda)
 *   visita 2337 nodos.
 *
 *   @author Jomi Fred H�bner
 */
public class MiniMaxAB {
    
    public static boolean parar = false;
    
    private int profMax = Integer.MAX_VALUE;
    int visitados = 0;
    
    public MiniMaxAB() {
    }
    
    public MiniMaxAB(int profundidadeMaxima) {
        profMax = profundidadeMaxima;
    }
    
    public double max(EstadoUtilidade estadoCorrente) {
        visitados = 0;
        return max(estadoCorrente, -10000, 10000, 1);
    }
    
    /**
     *
     * MiniMax, retorna a utilidade m�xima de um estado
     *
     * alpha: a melhor utilidade at� o momento para MAX
     * beta: a melhor utilidade at� o momento para MIN
     */
    public double max(EstadoUtilidade estadoCorrente, double alpha, double beta, int p) {
        
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            return estadoCorrente.calculaUtilidade();
        }
        
        Iterator i = estadoCorrente.sucessores().iterator();
        while (i.hasNext()) {
            visitados++;
            
            EstadoUtilidade sucessor = (EstadoUtilidade)i.next();
            double vlSucessor = min( sucessor, alpha, beta, p+1);
            
            if (vlSucessor > alpha) {
                alpha = vlSucessor;
                
                // poda alpha
                if (alpha >= beta) {
                    return beta;
                }
                
                estadoCorrente.setUtilidade( alpha );
                estadoCorrente.setProxJogada( sucessor );
            }
        }
        
        return alpha;
    }
    
    /**
     *
     * MiniMax, retorna a utilidade m�nima de um estado
     *
     */
    public double min(EstadoUtilidade estadoCorrente, double alpha, double beta, int p) {
        
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            return estadoCorrente.calculaUtilidade();
        }
        
        Iterator i = estadoCorrente.sucessores().iterator();
        while (i.hasNext()) {
            visitados++;
            
            EstadoUtilidade sucessor = (EstadoUtilidade)i.next();
            double vlSucessor = max( sucessor, alpha, beta, p+1);
            
            if (vlSucessor < beta) {
                beta = vlSucessor;
                
                if (beta <= alpha) {
                    return alpha;
                }
                
                estadoCorrente.setUtilidade( beta );
                estadoCorrente.setProxJogada( sucessor );
                
            }
        }
        return beta;
    }
    
    
    /*

    // c�digo em teste para tirar o setProxJogada
    // (ainda n�o funciona)

    public EstadoUtilidade max(EstadoUtilidade estadoCorrente, double alpha, double beta, int p) {
     
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            estadoCorrente.calculaUtilidade();
            return estadoCorrente;
        }
     
        EstadoUtilidade maxSucessor = null;
        Iterator i = estadoCorrente.sucessores().iterator();
        while (i.hasNext()) {
            visitados++;
     
            EstadoUtilidade sucessor = (EstadoUtilidade)i.next();
            EstadoUtilidade proxJogada = min( sucessor, alpha, beta, p+1);
     
            if (proxJogada != null) {
                if (sucessor.utilidade() > alpha) {
                    alpha = sucessor.utilidade();
                    maxSucessor = sucessor;
     
                    // poda alpha
                    if (alpha >= beta) {
                        return null;
                    }
     
                    maxSucessor.setUtilidade( alpha );
                    //estadoCorrente.setProxJogada( sucessor );
                }
            }
        }
     
        estadoCorrente.setUtilidade( alpha );
        return maxSucessor;
    }
     
     
     public EstadoUtilidade min(EstadoUtilidade estadoCorrente, double alpha, double beta, int p) {
     
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            estadoCorrente.calculaUtilidade();
            return estadoCorrente;
        }
     
        EstadoUtilidade minSucessor = null;
        Iterator i = estadoCorrente.sucessores().iterator();
        while (i.hasNext()) {
            visitados++;
     
            EstadoUtilidade sucessor = (EstadoUtilidade)i.next();
            EstadoUtilidade proxJogada = max( sucessor, alpha, beta, p+1);
     
            if (proxJogada != null) {
                if (sucessor.utilidade() < beta) {
                    beta = sucessor.utilidade();
                    minSucessor = sucessor;
     
                    if (beta <= alpha) {
                        return null;
                    }
     
                    minSucessor.setUtilidade( beta );
                    //estadoCorrente.setProxJogada( sucessor );
     
                }
            }
        }
        estadoCorrente.setUtilidade( beta );
        return minSucessor;
    }
     */
    
    
    
}
