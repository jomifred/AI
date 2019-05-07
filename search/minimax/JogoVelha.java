import java.io.*;

/**
 * Implementação do Joga da Velha
 *
 * Computador faz "x", usuário "o"; computador começa
 *
 * @author  Jomi
 */
public class JogoVelha {
    
    public static void main(String[] a) throws Exception {
        BufferedReader teclado = new BufferedReader(new InputStreamReader(System.in));
        MiniMaxAB mm = new MiniMaxAB(); 

        //EstadoJogoVelha corrente = new EstadoJogoVelha();
        EstadoJogoVelhaLigth corrente = new EstadoJogoVelhaLigth();
        
        corrente.setJogador(corrente.computador);
        
        while (! corrente.ehFim() ) {
            
            System.out.println("Estado atual do jogo "+corrente);
            
            if (corrente.getJogador() == corrente.computador) {
                
                boolean ok = false;
                while (!ok) {
                    // vez do usuário jogar
                    try {
                        System.out.println("\nqual sua jogada?");
                        System.out.print("linha (1, 2 ou 3):");
                        byte l = (byte)(Integer.parseInt( teclado.readLine()) - 1);
                        
                        System.out.print("coluna (1, 2 ou 3):");
                        byte c = (byte)(Byte.parseByte( teclado.readLine()) - 1);
                        
                        if ( corrente.livre(l, c)) {
                            //corrente = new EstadoJogoVelha( corrente, corrente.usuario);
                            corrente = new EstadoJogoVelhaLigth( corrente, corrente.usuario);
                            corrente.joga( l, c, corrente.usuario);

                            ok = true;
                        } else {
                            System.out.println("Posição já ocupada.");
                        }
                        
                    } catch (Exception e) {
                        System.out.println("Digite números entre 1 e 3");
                    }
                }
            } else {
                
                // vez do computador
                
                mm.max( corrente );
                System.out.println("Visitados "+mm.visitados+" nodos");
                corrente = (EstadoJogoVelhaLigth)corrente.getProxJogada();
                 
                /*
                corrente = (EstadoJogoVelha)mm.max( corrente );
                System.out.println(corrente);
                System.out.println("Visitados "+mm.visitados+" nodos");
                 */
            }

        }
        System.out.println("\n\n*** Fim do jogo!"+corrente);
    }
}
