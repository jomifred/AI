package example.TicTacToe.minimax;


import java.util.List;

/**
 * Estado que tem cálculo de utilidade 
 * (para MiniMax)
 *
 * @author  Jomi
 */
public interface EstadoUtilidade {

    /** calcula a utilidade de um estado */
    public double calculaUtilidade();

    /** informa a utilidade de um estado */
    public void setUtilidade(double u);

    /** seta a jogada que será feita qdo este estado for o corrente
      * (o algoritmo de minimax que seta este valor)
      */
    public void setProxJogada(EstadoUtilidade jogada);
    public EstadoUtilidade getProxJogada();
    
    
    /** retorna a utilidade do estado (qto maior melhor) */
    public double utilidade();

    /** verifica se é o fim do jogo */
    public boolean ehFim();

   /**
     * gera uma lista de sucessores do nodo.
     */
    public List<EstadoUtilidade> sucessores();

    /**
     * retorna uma descrição do problema que esta representação
     * de estado resolve
     */
    public String getDescricao();
}
