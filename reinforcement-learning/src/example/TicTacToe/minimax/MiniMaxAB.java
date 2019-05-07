package example.TicTacToe.minimax;


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
 *   @author Jomi Fred Hübner
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
     * MiniMax, retorna a utilidade máxima de um estado
     *
     * alpha: a melhor utilidade até o momento para MAX
     * beta: a melhor utilidade até o momento para MIN
     */
    public double max(EstadoUtilidade estadoCorrente, double alpha, double beta, int p) {
        
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            return estadoCorrente.calculaUtilidade();
        }
        
        for (EstadoUtilidade sucessor: estadoCorrente.sucessores()) {
            visitados++;
            
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
     * MiniMax, retorna a utilidade mínima de um estado
     *
     */
    public double min(EstadoUtilidade estadoCorrente, double alpha, double beta, int p) {
        
        if (p > profMax || estadoCorrente.ehFim() || parar) {
            return estadoCorrente.calculaUtilidade();
        }
        
        for (EstadoUtilidade sucessor: estadoCorrente.sucessores()) {
            visitados++;
            
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
}
