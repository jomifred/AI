import java.util.*;

/**
 * Representa um estado do jogo da velha
 * (ocupando pouco memória atraves de manipulação de bits)
 *
 * Computador é "x", usuário é "o"
 *
 * @author  Jomi
 */
public class EstadoJogoVelhaLigth implements EstadoUtilidade {
    
    /** retorna uma descrição do problema que esta representação
     * de estado resolve
     */
    public String getDescricao() {
        return "Jogo da velha";
    }



    public static final byte computador = 0;
    public static final byte usuario = 1;
    

    /** os dados estão assim organizados em um int (32 bits)
     * bits 0 e 1: jogada na posição 1x1 do tabuleiro
     *              00 sem jogada
     *              01 jogada do computador
     *              11 jogada do usuário
     * bits 2 e 3: jogada na posição 1x2
     * (idem até os bits 17 e 18)
     *
     * bit 18: 0 se o estado foi ação de uma jogada do computador
     *         1 se foi ação do usuário
     *
     * bits 19 e 20: 00 sem utilidade calculada
     *               01 utilidade -1
     *               10 utilidade 0
     *               11 utilidade 1
     *
     * bits 21 e 22: a linha da ultima jogada 
     *
     * bits 23 e 24: a coluna da ultima jogada
     *
     */
    int dados = 0;
    
    static final byte tam = 3;
    
    // indicação dos bits para as jogadas
    static final int s11 = 1;
    static final int s12 = (1 << 2); // terceito bit ligado
    static final int s13 = (1 << 4); // quinto bit ligado
    static final int s21 = (1 << 6); // ...
    static final int s22 = (1 << 8);
    static final int s23 = (1 << 10);
    static final int s31 = (1 << 12);
    static final int s32 = (1 << 14);
    static final int s33 = (1 << 16);
    
    static final int[][] posicoes = {
        {s11, s12, s13},
        {s21, s22, s23},
        {s31, s32, s33}
    };
    
    static final int sJogador = (1 << 18); 
    
    static final int sUtilidadeA = (1 << 19); // primeiro bit da utilidade
    static final int sUtilidadeB = (1 << 20); // segundo bit da utilidade

    static final int pLin = 21; // bit 21 e 22 é o lugar da linha
    static final int pCol = 23; // bit 23 e 24 é o lugar da coluna
    
    EstadoJogoVelhaLigth proxJogada = null; // a jogada que será feita depois deste estado

    
    /** construtor do estado inicial */
    public EstadoJogoVelhaLigth() {
        dados = 0;
    }
    
    /** contrutor a partir de um outro estado */
    public EstadoJogoVelhaLigth(EstadoJogoVelhaLigth e, byte jogador) {
        dados = e.dados;
        setJogador(jogador);
        setUtilidade(0);
    }

    public void setEstado(EstadoJogoVelhaLigth e) {
        dados = e.dados;
    }
    
    public void setProxJogada(EstadoUtilidade jogada) {
        proxJogada = (EstadoJogoVelhaLigth)jogada;
    }
    
    public EstadoUtilidade getProxJogada() {
        return proxJogada;
    }
    
    public byte getJogador() {
        if ((sJogador & dados) == 0) {
            return computador;
        } else {
            return usuario;
        }
    }
    
    
    public void setJogador(byte jogador) {
        if (jogador == computador) {
            dados = (dados & ~sJogador);
        } else {
            dados = (dados | sJogador);
        }
    }
    
    public int joga(byte l, byte c, byte jogador) {
        return joga(posicoes[l][c], jogador);
    }
    
    public int joga(int posicao, byte jogador) {
        dados = dados & ~posicao & ~(posicao*2); // zera a utilidade
        if (jogador == computador) {
            dados = dados | posicao;
        } else {
            dados = dados | (posicao + (posicao * 2));
        }
        setUltimaJogada(posicao);
        return dados;
    }
    
    /** marca a linha e coluna da ultima jogada */
    private void setUltimaJogada(int posicao) {
        byte conta = -1;
        while (posicao > 0) {
            posicao = posicao >> 2;
            conta++;
        }
        // apaga linha e col
        int tira = ~(15 << pLin); // 15d = 1111b
        dados = dados & tira;
        
        int lin = (conta / 3);
        int col = (conta % 3);
        dados = dados | (lin  << pLin);
        dados = dados | (col  << pCol);
    }
    
    public byte getUltimaJogadaLin() {
        int tiraCol = ~(3 << pCol);
        return (byte)((dados & tiraCol) >> pLin);
    }
    public byte getUltimaJogadaCol() {
        return (byte)(dados >> pCol);
    }
    
    public boolean ehJogadaDe(byte l, byte c, byte jogador) {
        if ( (dados & posicoes[l][c]) > 0) { // tem jogada
            if ( ((dados & (posicoes[l][c]*2)) == 0) && jogador == computador) {
                return true;
            }
            if ( ((dados & (posicoes[l][c]*2)) > 0) && jogador == usuario) {
                return true;
            }
        }
        return false;
    }

    public boolean livre(byte l, byte c) {
        return !ehJogadaDe(l, c, computador) && !ehJogadaDe(l, c, usuario);
    }
    
    
    /** seta a utilidade do estado (qto maior melhor)  */
    public void setUtilidade(double u) {
        setUtilidade((byte)u);
    }
    
    public void setUtilidade(byte u) {
        dados = dados & ~sUtilidadeA & ~(sUtilidadeB); // zera a utilidade
        if (u == -1) {
            dados = dados | sUtilidadeA;
        } else if (u == 0) {
            dados = dados | sUtilidadeB;
        } else if (u == 1) {
            dados = dados | sUtilidadeA | sUtilidadeB;
        }
    }
    
    public double utilidade() {
        if ((dados & sUtilidadeA) > 0) {
            if ((dados & sUtilidadeB) > 0) {
                return 1;
            } else {
                return -1;
            }
        }
        return 0;
    }
    
    /** retorna a utilidade do estado (qto maior melhor)  */
    public double calculaUtilidade() {
        byte utilidade = 0;
        
        if (ganha(computador)) {
            utilidade = 1;
        } else if (ganha(usuario)) {
            utilidade = -1;
        }
        
        setUtilidade(utilidade);
        return (double)utilidade;
    }
    
    
    /** gera uma lista de sucessores do nodo. */
    public List sucessores() {
        List suc = new ArrayList();
        
        byte jogador = this.getJogador();
        byte seraJodagaDe;
        if (jogador == computador) {
            seraJodagaDe = usuario;
        } else {
            seraJodagaDe = computador;
        }
        
        // joga em todos os lugares em branco
        int i = 1;
        while (i <= s33) {
            if ( (dados & i) == 0) {
                EstadoJogoVelhaLigth novo = new EstadoJogoVelhaLigth();
                novo.setEstado(this);
                novo.setJogador(seraJodagaDe);
                novo.joga(i, seraJodagaDe);
                suc.add(novo);
            }
            i = i * 4;
        }
        
        return suc;
    }
    
    /** verifica se o fim do jogo  */
    public boolean ehFim() {
        return contaBrancos() == 0 || ganha(computador) || ganha(usuario);
    }
    
    private boolean ganha(byte jogador) {
        for (byte i=0;i<tam;i++) {
            if (colunaIgualA(i, jogador) || linhaIgualA(i, jogador)) {
                return true;
            }
        }
        
        if (diagonalPrincialIgualA(jogador) ||  diagonalSecundariaIgualA(jogador)) {
            return true;
        }
        
        return false;
    }
    
    private boolean linhaIgualA(byte l, byte jogador) {
        for (byte c=0;c<tam;c++) {
            if (! ehJogadaDe(l, c, jogador)) {
                return false;
            }
        }
        return true;
    }
    
    private boolean colunaIgualA(byte c, byte jogador) {
        for (byte l=0;l<tam;l++) {
            if (! ehJogadaDe(l, c, jogador)) {
                return false;
            }
        }
        return true;
    }
    
    
    private boolean diagonalPrincialIgualA(byte jogador) {
        for (byte i=0;i<tam;i++) {
            if (! ehJogadaDe( i, i, jogador)) {
                return false;
            }
        }
        return true;
    }
    
    private boolean diagonalSecundariaIgualA(byte jogador) {
        for (byte i=0;i<tam;i++) {
            byte l = (byte)(tam-i-1);
            if (! ehJogadaDe( l, i, jogador)) {
                return false;
            }
        }
        return true;
    }
    
    private byte contaBrancos() {
        byte soma = 0;
        
        int i = s33;
        while (i > 0) {
            if ( (dados & i) == 0) {
                soma++;
            }
            i = i / 4;
        }
        
        return soma;
    }
    
    
    public String toString() {
        StringBuffer r = new StringBuffer("\n   ");
        
        byte  quebra = 0;
        int i = 1;
        while (i <= s33) {
            if ( (dados & i) > 0) {
                if ( (dados & (i*2)) > 0) {
                    r.append( " o " );
                } else {
                    r.append( " x " );
                }
            } else {
                r.append(" _ " );
            }
            i = i * 4;
            
            if (quebra == 2) {
                quebra = 0;
                r.append("\n   ");
            } else {
                quebra++;
            }
        }
        r.append("            jogada de "+getJogador()+", u="+utilidade()+"\n");
        r.append("               jogou em "+(getUltimaJogadaLin()+1)+" x "+(getUltimaJogadaCol()+1));
        return r.toString();
    }
    
    public String toBits() {
        StringBuffer r = new StringBuffer();
        
        int i = sUtilidadeB << 4;
        while (i > 0 ) {
            if ( (dados & i) == 0) {
                r.append( "0" );
            } else {
                r.append( "1" );
            }
            i = i / 2;
        }
        return r.toString();
    }
    
}


