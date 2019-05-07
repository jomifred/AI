package example.locadora;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.Map;

import qlearning.QLearning;

/**
 * Q-Learning aplicado ao problema de duas locadoras de automoveis 
 *
 * @author  Jomi Fred Hübner
 */
public class LocacaoAutomoveis {
   
    
    String[] actions = new String[] {"ab1", "ab2", "ab3", "ab4", "ab5",  // levar 1, 2, ... 5 carros de A para B
                                     "ba1", "ba2", "ba3", "ba4", "ba5",  // levar de B para A
                                     "--0" }; // nao fazer nada 

    QLearning<EstadoLocadoras> ql = new QLearning<EstadoLocadoras>( actions );
    
    public void runQL() throws Exception {
        
        //ql.loadQ("test");
        ql.setEpsilon(0.9);
        ql.setEpsilonDecrement(0.000001);
        
        ql.setAlpha(0.5);
        ql.setAlphaDecrement(0.000001);
        // output
        PrintWriter out = new PrintWriter(new FileWriter("x.dat"));
        
        EstadoLocadoras i = new EstadoLocadoras(10,10,0); // last state
        EstadoLocadoras j = null; // current state 
        String    a = ql.getExplorationActionByGreedy(i); // last action
        double    r;        // reward on last state x action
        
        int step = 0; // steps to terminal
        while (step < 300000) {
            
            j = i.simulateAction(a);
            j.simulateStep();
            r = j.reward();
            
            //System.out.print("iteration " + step);
            //System.out.println(": from "+i+" to "+j+" by "+a+" with reward = "+r);
            
            //if (i != null) {
            ql.updateQ(i, a, j, r);
            //}
            
            if (step % 100 == 0) // start again (new epoch)
                j = new EstadoLocadoras();
             
            a = ql.getExplorationActionByGreedy(j);
            step++;
            i = j;
        }
        
        //System.out.println("q=\n"+ql);
        //out.print(ql);
        System.out.println(ql.getEpsilon() + " , " + ql.getAlpha());
        //out.println(ql.printN());
        //ql.saveQ("test");
        
        /*Map<EstadoLocadoras, Double> v = ql.getV();
        for (EstadoLocadoras s: v.keySet())
            out.println(s.carrosA + ", "+s.carrosB+", "+v.get(s));*/
        Map<EstadoLocadoras, String> v = ql.getPi();
        for (EstadoLocadoras s: v.keySet())
            out.println(s.carrosA + ", "+s.carrosB+", "+v.get(s).substring(0,2));
        out.close();
    }
    
    /** iteracao-valor */
    public void runIV() {
        double[][] vp = new double[EstadoLocadoras.maxCarrosLoc+1][EstadoLocadoras.maxCarrosLoc+1];
        for (int i=0; i<vp.length; i++) {
            for (int j=0; j<vp.length; j++) {
                vp[i][j] = 0;
            }
        }
        
        double delta = 100;
        while (delta > 0.1) {
            double[][] v = copy(vp);            
            delta = 0;
            
            for (int i=0; i<v.length; i++) { // for each state
                for (int j=0; j<v.length; j++) {
                
                    EstadoLocadoras s = new EstadoLocadoras(i,j,0);
                    double max = 0;
                    for (String a: actions) {
                        EstadoLocadoras sp = s.simulateAction(a);
                        sp.simulateStep();
                        double r = sp.reward();
                        double inc = r + 0.5 * v[sp.carrosA][sp.carrosB];
                        //System.out.println(s +" -> "+sp+" r="+r + " a="+a+"  alA"+sp.alugadosA+" alB"+sp.alugadosB+" inc="+inc);
                        max = Math.max(max, inc);
                    }
                    //System.out.println("-- "+max);
                    vp[i][j] = max;
                    delta = Math.max( delta, Math.abs(vp[i][j] - v[i][j]));
                    //System.out.println(" "+v[i][j]+" "+ vp[i][j]+" "+Math.abs(vp[i][j] - v[i][j]));
                }
            }
            System.out.println(delta);
        }
        
    }
    
    double[][] copy(double[][] v) {
        double[][] n = new double[v.length][v[0].length];
        for (int i=0; i<v.length; i++)
            for (int j=0; j<v.length; j++)
                n[i][j] = v[i][j];
        return n;
    }
    
    
    public static void main(String[] a) throws Exception {
        /*EstadoLocadoras i = new EstadoLocadoras(10, 11, 1);
        System.out.println(i.equals(i));
        PairSA p = new PairSA(i, "ac1");
        PairSA np = new PairSA(new EstadoLocadoras(10, 11, 1), "ac1") ;
        System.out.println(p.equals(np));
        System.out.println(i.hashCode() + "  "+new EstadoLocadoras(10, 11, 1).hashCode());
        System.out.println(p.hashCode() + "  "+np.hashCode());*/
        
        //new LocacaoAutomoveis().runQL();
        
        new LocacaoAutomoveis().runIV();
    }
    
}
