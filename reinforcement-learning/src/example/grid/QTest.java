package example.grid;

import qlearning.QLearning;

/**
 * Test Q-Learning (example of Russel&Norvig pg 600)
 *
 * @author  Jomi Fred Hubner
 */
public class QTest {
    
    String[] actions = new String[] { "S", "N","W", "E"};
    
    QLearning<GridState> ql = new QLearning<GridState>( actions );
    
    public static void main(String[] a) throws Exception {
        QTest q = new QTest();
        q.run();
    }
    
    public void run() throws Exception {
        
        //ql.loadQ("test");
        ql.setEpsilon(1); // exploration 
        ql.setEpsilonDecrement(0.0001);
        ql.setGamma(0.5); // future reward
        
        GridState i = new GridState(); // initial state
        GridState j = null; // next state
        String    a = null; // action
        double    r;        // reward on last state x action
        
        int epoch = 0;
        while (epoch < 50) {
            
            a = ql.getExplorationActionByGreedy(i);
            j = i.simulateAction(a);
            r = j.getReward();

            ql.updateQ(i, a, j, r);

            //System.out.println(": from "+i+" to "+j+" by "+a+" with reward = "+r+" new q="+nq);
            //System.out.println(nq);
            
            if (j.isTerminal()) {
                epoch++;
                i = new GridState();
                System.out.println("              epoch "+epoch); printGrid(); 
            } else {
                i = j;
            }            
        }
        
        //System.out.println("q=\n"+ql);
        //System.out.println(ql.getEpsilon() + " , " + ql.getAlpha());
        
        //ql.saveQ("test");
    }
            
    void printGrid() {
        for (int l = 3; l > 0; l--) {
            for (int c = 1; c < 5; c++) {
        		if (l==3 && c==4) {
        		    System.out.print( "1 ");
        		} else if (l==2 && c==4) {
        		    System.out.print( "-1 ");
        		} else if (l==2 && c==2) {
        		    System.out.print( "x ");
        		} else {
        		    System.out.print( ql.argmax(new GridState( c, l)) + " ");
        		}
            }
            System.out.println("");
        }
    }
    
}
