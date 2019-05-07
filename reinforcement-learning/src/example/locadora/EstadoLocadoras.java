package example.locadora;
import java.util.Random;

import qlearning.State;

/**
 * Estados para a locacao de automoveis
 *
 * @author  Jomi
 */

public class EstadoLocadoras implements State {
    
    public static final int maxCarrosLoc = 10;
    
    int  carrosA; // carros na locadora da cidade A
    int  carrosB; // e da cidade B

    int alugadosA = 0, alugadosB = 0;
    int transferidos; // numero de transferencias de carros feitas
    
    final static int pedidosA  = 3;
    final static int retornosA = 3;
    final static int pedidosB  = 4;
    final static int retornosB = 2;
    
    private static Random r = new Random();
    
    /** cria um estado com nro aleatorio de carros */
    public EstadoLocadoras() {
        this.carrosA = 5+r.nextInt(maxCarrosLoc-6);
        this.carrosB = 5+r.nextInt(maxCarrosLoc-6);
        this.transferidos = 0;
    }

    public EstadoLocadoras(int a, int b, int transferidos) {
        this.carrosA = a;
        this.carrosB = b;
        this.transferidos = transferidos;
    }
    
    public boolean equals(Object o) {
        EstadoLocadoras os = (EstadoLocadoras)o;
        return carrosA == os.carrosA && carrosB == os.carrosB;
    }

    @Override
    public int hashCode() {
        return carrosA * 31 * carrosB;
    }
    
    public EstadoLocadoras simulateAction(String action) {
        int qtd = Integer.valueOf( action.substring(2,3));
        if (qtd == 0)
            return new EstadoLocadoras(carrosA, carrosB, 0);;
        if (action.startsWith("ab")) {
            if (qtd > carrosA) qtd = carrosA;
            return new EstadoLocadoras(carrosA - qtd, carrosB + qtd, qtd);
        } else if (action.startsWith("ba")) {
            if (qtd > carrosB) qtd = carrosB;
            return new EstadoLocadoras(carrosA + qtd, carrosB - qtd, qtd);
        }
        return null;
    }
    
    public void simulateStep() {
        // simula locacoes e entregar
        alugadosA = poisson(pedidosA);
        if (alugadosA > carrosA) 
            alugadosA = carrosA;
        carrosA -= alugadosA;

        int retornoA = poisson(retornosA);
        carrosA += retornoA;
        if (carrosA > maxCarrosLoc)
            carrosA = maxCarrosLoc;
        
        alugadosB = poisson(pedidosB);
        if (alugadosB > carrosB) 
            alugadosB = carrosB;
        carrosB -= alugadosB;
        int retornoB = poisson(retornosB);
        carrosB += retornoB;
        if (carrosB > maxCarrosLoc)
            carrosB = maxCarrosLoc;
    }

    static int poisson(int lambda) {
        for (int t=0; t<5; t++) {
            for (int n = 0; n < 10; n++) {
                double probN = (Math.pow(lambda, n) * Math.pow(Math.E, -lambda)) / fatorial(n);
                //System.out.println(n+" "+probN);
                if (r.nextDouble() < probN)
                    return n;
            }
        }
        return lambda;
    }

    static int fatorial(int n) {
        if (n == 0)
            return 1;
        else
            return n * fatorial(n-1);
    }

    public double reward() {
        return alugadosA*10 + alugadosB*10 - transferidos*2;        
    }
    
    public String toString() {
        String a = carrosA > 9 ? String.valueOf(carrosA) : "0" + String.valueOf(carrosA);
        String b = carrosB > 9 ? String.valueOf(carrosB) : "0" + String.valueOf(carrosB);
        return "s("+a+","+b+")";
    }
}

