
import java.util.*;

/**
 * Representa um estado do jogo da velha
 *
 * Computador é "x", usuário é "o"
 * Computador sempre começa
 *
 * @author  Jomi
 */
public class EstadoJogoVelha implements EstadoUtilidade {
    
    public static short tam = 3;
    public static final char computador = 'x';
    public static final char usuario = 'o';
    
    
    private char[][] tabuleiro = new char[tam][tam];
    private char foiJogadaDe = ' '; // indica quem (x ou o) fez este estado

    private double utilidade = 0;
    EstadoJogoVelha proxJogada = null; // a jogada que será feita depois deste estado
    
    /** construtor do estado inicial */
    public EstadoJogoVelha() {
        for (int l=0;l<tam;l++) {
            for (int c=0;c<tam;c++) {
                tabuleiro[l][c] = ' ';
            }
        }
    }
    
    /** contrutor a partir de um outro estado */
    public EstadoJogoVelha(EstadoJogoVelha e, char jogador) {
        for (int l=0;l<tam;l++) {
            for (int c=0;c<tam;c++) {
                tabuleiro[l][c] = e.tabuleiro[l][c];
            }
        }
        foiJogadaDe = jogador;
    }

    /** contrutor a partir de um outro estado */
    public EstadoJogoVelha(char[][] p, char jogador) {
        for (int l=0;l<tam;l++) {
            for (int c=0;c<tam;c++) {
                tabuleiro[l][c] = p[l][c];
            }
        }
        foiJogadaDe = jogador;
    }

    public void setProxJogada(EstadoUtilidade jogada) {
        proxJogada = (EstadoJogoVelha)jogada;
    }
    public EstadoUtilidade getProxJogada() {
        return proxJogada;
    }

    public char getJogador() {
        return foiJogadaDe;
    }
    public void setJogador(char j) {
        foiJogadaDe = j;
    }
    
    /** retorna uma descrição do problema que esta representação
     * de estado resolve
     */
    public String getDescricao() {
        return "Jogo da velha";
    }

    public void joga(int l, int c, char jogador) {
        tabuleiro[l][c] = jogador;
    }
    
    public boolean livre(int l, int c) {
        return tabuleiro[l][c] == ' ';
    }
    
    /** gera uma lista de sucessores do nodo. */
    public List sucessores() {
        List suc = new ArrayList();
        
        char seraJodagaDe = ' ';
        if (this.foiJogadaDe == computador) {
            seraJodagaDe = usuario;
        } else {
            seraJodagaDe = computador;
        }
        
        // joga em todos os lugares em branco
        for (int l=0;l<tam;l++) {
            for (int c=0;c<tam;c++) {
                if (tabuleiro[l][c] == ' ') {
                    EstadoJogoVelha novo = new EstadoJogoVelha( this, seraJodagaDe);
                    novo.tabuleiro[l][c] = seraJodagaDe;
                    suc.add( novo );
                }
            }
        }
        
        return suc;
    }

    /** retorna a utilidade do estado (qto maior melhor)  */
    public void setUtilidade(double u) {
        utilidade = u;
    }
    
    /** retorna a utilidade do estado (qto maior melhor)  */
    public double calculaUtilidade() {
        if (ganha('x')) {
            utilidade =1;
        } else if (ganha('o')) {
            utilidade =-1;
        } else {
            utilidade = 0;
        }
        return utilidade;
    }
    
    public double utilidade() {
        return utilidade;
    }
    
    /** verifica se o fim do jogo  */
    public boolean ehFim() { 
        return ganha(computador) || ganha(usuario) || contaBrancos() == 0; 
    }

    private boolean ganha(char jogador) {
        for (int i=0;i<tam;i++) {
            if (colunaIgualA(i, jogador) || linhaIgualA(i, jogador)) {
                return true;
            }
        }
        
        if (diagonalPrincialIgualA(jogador) ||  diagonalSecundariaIgualA(jogador)) {
            return true;
        }
        
        return false;
    }
    
    private boolean linhaIgualA(int l, char jogador) {
        for (int c=0;c<tam;c++) {
            if (tabuleiro[l][c] != jogador) {
                return false;
            }
        }
        return true;
    }
    
    private boolean colunaIgualA(int c, char jogador) {
        for (int l=0;l<tam;l++) {
            if (tabuleiro[l][c] != jogador) {
                return false;
            }
        }
        return true;
    }
    
    private boolean diagonalPrincialIgualA(char jogador) {
        for (int i=0;i<tam;i++) {
            if (tabuleiro[i][i] != jogador) {
                return false;
            }
        }
        return true;
    }
    
    private boolean diagonalSecundariaIgualA(char jogador) {
        for (int i=0;i<tam;i++) {
            int l = tam-i-1;
            if (tabuleiro[l][i] != jogador) {
                return false;
            }
        }
        return true;
    }
    
    private int contaBrancos() {
        int soma = 0;
        for (int l=0;l<tam;l++) {
            for (int c=0;c<tam;c++) {
                if (tabuleiro[l][c] == ' ') {
                    soma++;
                }
            }
        }
        return soma;
    }
    

    public String toString() {
        StringBuffer r = new StringBuffer("\n");
        for (int i=0;i<tam;i++) {
            r.append((i+1) + ":   ");
            for (int j=0;j<tam;j++) {
                r.append(tabuleiro[i][j]);
                if (j+1<tam) {
                    r.append(" | ");
                }
            }
            if (i+1<tam) {
                r.append("\n     ----------\n");
            }
        }
        return r + "       u="+utilidade() + "\n";
    }

    
    /** usado só para testar, o programa que joga esta em outra classe */
    public static void main(String[] a) {
        MiniMaxAB mm = new MiniMaxAB();
        
        EstadoJogoVelha e1 = new EstadoJogoVelha();
        
        EstadoJogoVelha e2 = new EstadoJogoVelha(
        new char[][]
        { {'x','o',' '},
          {'x','o',' '},
          {' ',' ',' '}}, 'o');
          
        EstadoJogoVelha e3 = new EstadoJogoVelha(
        new char[][]
        { {'x','o',' '},
          {' ',' ',' '},
          {' ',' ',' '}}, 'o');

        EstadoJogoVelha e4 = new EstadoJogoVelha(
        new char[][]
        { {'x','o',' '},
          {' ','o',' '},
          {' ','x','x'}}, 'x');


        EstadoJogoVelha e5 = new EstadoJogoVelha(
        new char[][]
        { {'x','o',' '},
          {' ','o',' '},
          {'o','x','x'}}, 'o');

        EstadoJogoVelha e6 = new EstadoJogoVelha(
        new char[][]
        { {'x','o','x'},
          {' ','o',' '},
          {'o','x','x'}}, 'x');
          
          System.out.println("Atual="+e1);
          //System.out.println("utilidade calculada para estado atual="+mm.min(e6, 1));
          System.out.println("prox="+mm.max(e1));//,-10,10,1));
          //System.out.println("prox. estado é="+ e4.getProxJogada());
    }    
}