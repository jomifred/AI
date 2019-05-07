package example.TicTacToe;

import qlearning.QLearning;

/**
 * The opponent is also an AR
 *
 * @author  Jomi Fred Hubner
 */
public class TicTacToeARvsAR extends TicTacToe {
    
    QLearning<StateTTT> qlMe = new QLearning<StateTTT>( actions );
    QLearning<StateTTT> qlOp = new QLearning<StateTTT>( actions );
    
    public static void main(String[] a) throws Exception {
        TicTacToeARvsAR ttt = new TicTacToeARvsAR();
        ttt.run();
        ttt.printSomeStates();
    }
    
    public void run() throws Exception {
        
        int nepochs = 50000;
        
        qlMe.setEpsilon(0.9); // full exploration at the start
        qlMe.setEpsilonDecrement(1.0/nepochs/5); // 5 plays each epoch
        qlMe.setEpsilonMinValue( 0.5); // half exploration in the end
        qlMe.setAlpha(1); // learning rate
        qlMe.setAlphaDecrement(1.0/nepochs/5);
        qlMe.setGamma(0.9); // future discount
        
        qlOp.setEpsilon(0.9); // full exploration at the start
        qlOp.setEpsilonDecrement(1.0/nepochs/5); // 5 plays each epoch
        qlOp.setEpsilonMinValue(0.3); // half exploration in the end        
        qlOp.setAlpha(1); // learning rate
        qlOp.setAlphaDecrement(1.0/nepochs/5);        
        qlOp.setGamma(0.9); // future discount

        StateTTT i = new StateTTT(); // initial state
        StateTTT j = null; // next state
        StateTTT k=null,lj = null; // next state
        String   aMe = null; // action
        double   rMe;        // reward on last state x action
        String   aOp = null;
        double   rOp = 0;       
        
        int epoch = 0;
        while (epoch < nepochs) {
        		lj = j; // store last j for qlOp update
        		
            aMe = qlMe.getExplorationActionByGreedy(i);
            j = i.simulateAction(1,aMe);
            
            if (j.equals(i)) { // Illegal move from our agent! 
            		//System.out.print(".");
                qlMe.updateQ(i, aMe, j, -1);
                continue;
            }
            
            // update op
            if (lj != null) {
            		rOp = j.getReward(-1);
            		qlOp.updateQ(lj, aOp, j, rOp);
            }
            
            // jogada oponentes AR
            while (true) {
	            aOp = qlOp.getExplorationActionByGreedy(j);
	            k = j.simulateAction(-1,aOp);
	            if (k.equals(j) && !k.isTerminal()) { // Illegal move from our agent!
            			qlOp.updateQ(j, aOp, k, -1);
	            } else {
	            		break;
	            }
            }

            rMe = k.getReward(1);
            qlMe.updateQ(i, aMe, k, rMe);

            //System.out.println(": from "+i+" to "+j+" by "+a+" with reward = "+r); //+" new q="+nq);
                        
            if (k.isTerminal()) { // end of the game
                if (epoch % 10000 == 0) 
                    System.out.println("\nepochs "+epoch+" epsilon "+qlMe.getEpsilon()+" alpha "+qlMe.getAlpha()+" ");
                else if (epoch % 500 == 0) {
                    //int m = playAgainstMiniMax(qlMe);
                    int m = playAgainstRandom(qlMe); // using the current police based on Q
                    if (m == 0)
                        System.out.print("=");
                    else if (m == 1)
                        System.out.print("+");
                    else if (m == -1)
                        System.out.print("-");
                }
                epoch++;
                i = new StateTTT();
                k = null;
            } else {
                i = k;
            }            
        }
    }

}
