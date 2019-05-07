package example.TicTacToe;
import java.util.ArrayList;
import java.util.List;

import qlearning.State;
import example.TicTacToe.minimax.EstadoUtilidade;

/**
 * TicTacToe state
 *
 * @author  jomi
 */

public class StateTTT implements State, EstadoUtilidade {
    
    byte m[][];
    
    /** initial state */
    public StateTTT() {
        m = new byte[][] 
            { { 0, 0, 0 },
              { 0, 0, 0 },
              { 0, 0, 0 } };
    }
    
    /** create a new state from previous one */
    StateTTT(byte p[][]) {
        m = new byte[3][3];
        for (int l=0; l<3; l++) 
            for (int c=0; c<3; c++)
                m[l][c] = p[l][c];
    }
    
    public int getState(int l, int c) {
        return m[l][c];
    }
    
    public boolean isTerminal() {
        return !hasPlaceForPlay() || wins(1) || wins(-1);
    }
    
    public boolean hasPlaceForPlay() {
        for (int l=0; l<3; l++) 
            for (int c=0; c<3; c++)
                if (m[l][c] == 0)
                    return true;
        return false;
    }

    /** player is 1 or -1 */
    public int getReward(int player) {
        if (wins(player))
            return 1;
        if (wins(player * -1))
            return -1;
        return 0;
    }
    
    boolean wins(int player) {
        for (int l=0; l<3; l++) {
            int s=0;
            for (int c=0; c<3; c++)
                s += m[l][c];
            if (s == player*3) // some column sums 3 (wins)
                return true;            
        }

        for (int c=0; c<3; c++) {
            int s=0;
            for (int l=0; l<3; l++) 
                s += m[l][c];
            if (s == player*3) // some line sums 3 (wins)
                return true;            
        }
        
        if (m[0][0]+m[1][1]+m[2][2] == player*3) // (wins)
            return true;
        if (m[0][2]+m[1][1]+m[2][0] == player*3) // (wins)
            return true;
        return false;
    }
    
    public StateTTT simulateAction(int player, String action) {
        int av = new Integer(action).intValue();
        int line = (av / 3);
        int col  = (av % 3);
        return simulateAction(player, line, col);
    }

    public StateTTT simulateAction(int player, int line, int col) {
        StateTTT news = new StateTTT(m);
        news.foiJogadaDe = player;
        if (m[line][col] == 0)
            news.m[line][col] = (byte)player;
        return news;
    }
    
    public boolean isEmpty(int l, int c) {
        return m[l][c] == 0;
    }
        
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        StateTTT os = (StateTTT)o;
        for (int l=0; l<3; l++) 
            for (int c=0; c<3; c++)
                if (m[l][c] != os.m[l][c])
                    return false;
        return true;//foiJogadaDe == os.foiJogadaDe;
    }
    
    @Override
    public int hashCode() {
        int sum = 0;        
        for (int l=0; l<3; l++) 
            for (int c=0; c<3; c++)
                if (m[l][c] == 0)
                    sum += 7 * (l*3+c);
                else if (m[l][c] == 1)
                    sum += 11 * (l*3+c);
                else
                    sum += 17 * (l*3+c);
        return sum;
        
        // compare performance against 
        /*
        for (int l=0; l<3; l++) 
            for (int c=0; c<3; c++)
               sum += m[l][c];
         */
    }
    
    public String toString() {
        StringBuilder s = new StringBuilder("[ ");
        for (int l=0; l<3; l++) { 
            s.append("[ ");
            for (int c=0; c<3; c++) { 
                s.append(m[l][c]+" ");
            }
            s.append("]");
        }
        return s + " ]";
    }

    // Metodos para o MiniMax
    
    EstadoUtilidade proxJogada = null; // a jogada que sera feita depois deste estado
    double utilidade = 0;
    int foiJogadaDe = 0; // indica quem (x ou o) fez este estado
    
    public void setProxJogada(EstadoUtilidade jogada) {
        proxJogada = jogada;
    }
    public EstadoUtilidade getProxJogada() {
        return proxJogada;
    }
    public double calculaUtilidade() {
        if (wins(-1)) {
            utilidade =  1;
        } else if (wins(1)) {
            utilidade = -1;
        } else {
            utilidade = 0;
        }
        return utilidade;
    }
    public void setUtilidade(double u) {
        utilidade = u;
    }
    public double utilidade() {
        return utilidade;
    }
    public boolean ehFim() { 
        return isTerminal(); 
    }
    public List<EstadoUtilidade> sucessores() {
        List<EstadoUtilidade> suc = new ArrayList<EstadoUtilidade>();
        
        int seraJodagaDe = this.foiJogadaDe * -1;
        
        // try to play in all available locations
        for (int l=0;l<3;l++) {
            for (int c=0;c<3;c++) {
                if (isEmpty(l,c)) {
                    StateTTT novo = new StateTTT(this.m);
                    novo.foiJogadaDe = seraJodagaDe;
                    novo.m[l][c] = (byte)seraJodagaDe;
                    suc.add( novo );
                }
            }
        }        
        return suc;
    }
    public String getDescricao() {
        return "bla";
    }

}
