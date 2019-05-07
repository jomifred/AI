package example.TicTacToe;

import java.util.Map;
import java.util.Random;

import qlearning.QLearning;
import example.TicTacToe.minimax.MiniMaxAB;

/**
 * Agent that learns to play TicTacToe
 *
 * Things to try:
 *   
 *   - try: learn with random, evaluated against minimax (see run method)
 *   -      learn with minimax, evaluated against random
 *   -      other combinations
 *   
 *   - try fast epsilon decrease
 *   - try low gamma value 
 *   
 *   - bad hashcodes for Q (see hashCode in StateTTT)
 *   
 * @author  Jomi Fred Hubner
 */
public class TicTacToe {
    
    String[] actions = new String[] { "0","1","2","3","4","5","6","7","8" }; // the 9 places in the TTT
    
    private QLearning<StateTTT> ql = new QLearning<StateTTT>( actions );
    
    Random rand = new Random();
    

    public static void main(String[] a) throws Exception {
        TicTacToe ttt = new TicTacToe();
        ttt.run();
        ttt.printSomeStates();
    }
    
    public void run() throws Exception {
        
        int nepochs = 1000000;
        
        ql.setEpsilon(1); // full exploration at the start
        ql.setEpsilonDecrement(1.0/nepochs/5); // 5 plays each epoch
        ql.setEpsilonMinValue( 0.5); // half exploration in the end
        
        ql.setAlpha(1); // learning rate
        ql.setAlphaDecrement(1.0/nepochs/5);
        
        ql.setGamma(0.9); // future discount
        
        StateTTT i = new StateTTT(); // initial state
        StateTTT j = null; // next state
        String   a = null; // action
        double   r;        // reward on last state x action
        
        int epoch = 0;
        while (epoch < nepochs) {
            a = ql.getExplorationActionByGreedy(i);
            j = i.simulateAction(1,a);
            
            if (j.equals(i)) { // Illegal move from our agent! 
                r = -1;        // punish!
                ql.updateQ(i, a, j, r);
                continue;
            }
            
            // contra MiniMax?
            j = simulateMiniMaxOpponent(j);
            //j = simulateRandomOpponent(j);

            r = j.getReward(1);

            ql.updateQ(i, a, j, r);

            //System.out.println(": from "+i+" to "+j+" by "+a+" with reward = "+r); //+" new q="+nq);
                        
            if (j.isTerminal()) { // end of the game
                if (epoch % 10000 == 0) 
                    System.out.println("\nepochs "+epoch+" epsilon "+ql.getEpsilon()+" alpha "+ql.getAlpha()+" ");
                else if (epoch % 500 == 0) {
                    //int m = playAgainstMiniMax(ql);
                    int m = playAgainstRandom(ql); // using the current police based on Q
                    if (m == 0)
                        System.out.print("=");
                    else if (m == 1)
                        System.out.print("+");
                    else if (m == -1)
                        System.out.print("-");
                }
                epoch++;
                i = new StateTTT();
            } else {
                i = j;
            }            
        }
    }

    
    StateTTT simulateRandomOpponent(StateTTT s) {
        if (s.isTerminal()) 
            return s;
        else 
            return s.simulateAction(-1, getValidRandomAction(s));
    }  
    
    StateTTT simulateMiniMaxOpponent(StateTTT s) {
        if (s.isTerminal()) 
            return s;
        else 
            return decisionFromMiniMax(s);
    }  

    String getValidRandomAction(StateTTT s) {
        int options = 9;
        boolean first = true;
        int free = 0;
        while (true) {
            for (int l=0; l<3; l++) 
                for (int c=0; c<3; c++)
                    if (s.isEmpty(l, c)) {
                        if (first) free++;
                        if (rand.nextInt(options) <= 1) 
                            return (l*3+c)+"";
                    }
            if (first) {
                first   = false;
                options = free;
            }
        }
    }
    
    StateTTT decisionFromMiniMax(StateTTT s) {
        MiniMaxAB mm = new MiniMaxAB();
        mm.max( s );
        return (StateTTT)s.getProxJogada();
    }
    
    int playAgainstMiniMax(QLearning<StateTTT> ql) {
        MiniMaxAB mm = new MiniMaxAB();
        StateTTT s = new StateTTT();
        while (true) {
            // my RL agent plays
            s = s.simulateAction(1, ql.argmax(s));
            if (s.wins(1)) return 1;
            else if (s.wins(-1)) return -1;
            else if (!s.hasPlaceForPlay()) return 0;
            
            // minimax plays
            mm.max( s );
            s = (StateTTT)s.getProxJogada();
            
            if (s.wins(1)) return 1;
            else if (s.wins(-1)) return -1;
            else if (!s.hasPlaceForPlay()) return 0;
        }
    }
    
    int playAgainstRandom(QLearning<StateTTT> ql) {
        StateTTT s = new StateTTT();
        while (true) {
            // my RL agent plays
            s = s.simulateAction(1, ql.argmax(s));
            if (s.wins(1)) return 1;
            else if (s.wins(-1)) return -1;
            else if (!s.hasPlaceForPlay()) return 0;
            
            // random plays
            s = s.simulateAction(-1, getValidRandomAction(s));
            
            if (s.wins(1)) return 1;
            else if (s.wins(-1)) return -1;
            else if (!s.hasPlaceForPlay()) return 0;
        }
    }

    void printSomeStates() {
        Map<StateTTT, String> pi = ql.getPi();
        
        byte[][] m = new byte[][] 
                                { { 0, 0, 0 },
                                  { 0, 0, 0 },
                                  { 0, 0, 0 } 
                              };
        StateTTT ttt = new StateTTT(m);
        System.out.println("\nFor "+ttt+" do "+pi.get(ttt));

        m = new byte[][] 
                       { { 1, -1, 0 },
                         { 0, 0, 0 },
                         { 0, 0, 0 } };                                    
        ttt = new StateTTT(m);
        System.out.println("For "+ttt+" do "+pi.get(ttt));

        
        m = new byte[][] 
                       { { 1,  0, -1 },
                         { 1, -1, 0 },
                         { 0,  0, 0 } };                                    
        ttt = new StateTTT(m);
        System.out.println("For "+ttt+" do "+pi.get(ttt)+ " should be 6");

        
        m = new byte[][] 
              { { 1, -1, -1 },
                { 0, 1, 0 },
                { 0, 0, 0 } };
        ttt = new StateTTT(m);
        System.out.println("For "+ttt+" do "+pi.get(ttt)+ " should be 8");
        
        m = new byte[][] 
                       { { 1,  0, -1 },
                         { 0, -1,  0 },
                         { 0,  0,  1 } };                                    
        ttt = new StateTTT(m);
        System.out.println("For "+ttt+" do "+pi.get(ttt)+ " should be 6");
        m = new byte[][] 
                       { { 1,  0, -1 },
                         { 0,  0, -1 },
                         { 0,  0,  1 } };                                    
        ttt = new StateTTT(m);
        System.out.println("For "+ttt+" do "+pi.get(ttt)+ " should be 6");
    }
}
