package example.wumpus;

import qlearning.QLearning;

/**
 * Q-Learning for Wumpys (example of Russel&Norvig)
 *
 * @author  Jomi Fred Hubner
 */
public class Wumpus {
    
    String[] actions = new String[] {"N", "S", "W", "E", "P"}; // P=pick gold
    
    QLearning<WumpusState> ql = new QLearning<WumpusState>( actions );
    
    public static void main(String[] a) throws Exception {
        Wumpus q = new Wumpus();
        q.run();
        //System.out.println(q.ql);
    }
    
    public void run() throws Exception {
        
        ql.setEpsilon(1); // exploration 
        ql.setEpsilonDecrement(0.00000001);
        ql.setEpsilonMinValue(0.4);
        
        ql.setGamma(0.7); // future reward
        
        ql.setAlpha(1);
        ql.setAlphaDecrement(0.00000001);
        
        WumpusState i = new WumpusState(); // initial state
        WumpusState j = null; // next state
        String    a = null; // action
        double    r;        // reward on last state x action
        
        int epoch = 0;
        while (epoch < 2000) {
            
            a = ql.getExplorationActionByGreedy(i);
            j = i.simulateAction(a);
            r = j.getReward(i);

            ql.updateQ(i, a, j, r);

            //System.out.println(": from "+i+" to "+j+" by "+a+" with reward = "+r+" new q="+nq);

            if (j.isTerminal()) {
                epoch++;
                i = new WumpusState();
                if (epoch % 100 == 0) {
                    System.out.println("\n              epoch "+epoch+" epsilon="+ql.getEpsilon()+" alpha="+ql.getAlpha()); 
                    printGrid(); 
                }
            } else {
                i = j;
            }            
        }
        
        //System.out.println("q=\n"+ql);
        //System.out.println(ql.getEpsilon() + " , " + ql.getAlpha());
        
        //ql.saveQ("test");
    }
            
    void printGrid() {
        System.out.println("no gold       with gold");
        for (int l = 4; l > 0; l--) {
            // without gold
            for (int c = 1; c < 5; c++) {
                WumpusState w = new WumpusState(c,l);
                if (w.isTerminal())
                    System.out.print("* ");
                else
                    System.out.print( ql.argmax(w) + " ");
            }

            // with gold
            System.out.print("      ");
            for (int c = 1; c < 5; c++) {
                WumpusState w = new WumpusState(c,l);
                w.hasGold = true;
                if (w.isTerminal())
                    System.out.print("* ");
                else
                    System.out.print( ql.argmax(w) + " ");
            }
            
            System.out.println("");
        }
    }    
}
