

import java.util.*;

/**
 * Estado que tem c�lculo de utilidade 
 * (para MiniMax)
 *
 * @author  Jomi
 */
public interface EstadoUtilidade {

    /** calcula a utilidade de um estado */
    public double calculaUtilidade();

    /** informa a utilidade de um estado */
    public void setUtilidade(double u);

    /** seta a jogada que ser� feita qdo este estado for o corrente
      * (o algoritmo de minimax que seta este valor)
      */
    public void setProxJogada(EstadoUtilidade jogada);
    public EstadoUtilidade getProxJogada();
    
    
    /** retorna a utilidade do estado (qto maior melhor) */
    public double utilidade();

    /** verifica se � o fim do jogo */
    public boolean ehFim();

   /**
     * gera uma lista de sucessores do nodo.
     */
    public List sucessores();

    /**
     * retorna uma descri��o do problema que esta representa��o
     * de estado resolve
     */
    public String getDescricao();
}
