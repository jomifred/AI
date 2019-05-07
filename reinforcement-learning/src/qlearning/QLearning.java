package qlearning;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;


/**
 * Q-Learning implementation
 * 
 * @author  Jomi
 */
public class QLearning<S extends State> {
    
    Map<PairSA, Double> q = new HashMap<PairSA, Double>(); // for the Q-Learning values
    String[] actions = { };
    Random random = new Random();
    
    double gamma = 0.9;
    double alpha = 0.9;
    double alphaDec = 0.00005;
        
    double epsilon = 0.5; // 50 % of exploration
    double epsilonDec = 0.0001;
    double epsilonMin = 0.01;

    double defaultQ = 0;
    
    public QLearning(String[] actions) {
        this.actions = actions;
    }

    public String[] getActions() {
		return actions;
    }
    
    public double updateQ(State s, String a, State newState, double r) {
        if (alpha > 0.01)
            alpha = alpha - alphaDec;
        PairSA previousDecision = new PairSA(s,a);
        double q = getQ(previousDecision);
        double nq = q + alpha * (r + (gamma * max(newState) - q));
        //double nq = r + (gamma * max(newState)); // Formula used by Tom Mitchel
        //System.out.println(q+ " <- " +max(newState)+"  / "+r+" + "+(gamma * (max(newState) - q))+"="+(r +gamma * (max(newState) - q)));
        setQ( previousDecision, nq );
        setN( previousDecision, getN(previousDecision) + 1);
        return nq;
    }
    
    public void setDefaultQValue(double dq) {
        defaultQ = dq;
    }
    
    public double getAlpha() {
        return alpha;
    }
    public void setAlpha(double alpha) {
		this.alpha = alpha;
    }
    public void setAlphaDecrement(double dec) {
		alphaDec = dec;
    }

    
    public double getGamma() {
        return gamma;
    }
    public void setGamma(double g) {
        gamma = g;
    }
    
    
    public double getQ(PairSA p) {
        Double d = q.get(p);
        if (d == null) {
            return defaultQ;
        } else {
            return d.doubleValue();
        }
    }
    
    private void setQ(PairSA p, double v) {
        q.put(p,v);
    }
    
    @SuppressWarnings("unchecked")
    public Map<S, Double> getV() {
        Map<S, Double> map = new HashMap<S, Double>();
        for (PairSA p: q.keySet()) {
            Double vl = map.get(p.s);
            if (vl == null)
                vl = 0.0;
            if (q.get(p) > vl)
                map.put((S)p.s, q.get(p));
        }
        return map;
    }
    
    @SuppressWarnings("unchecked")
    public Map<S, String> getPi() {
        Map<S, String> map = new HashMap<S, String>();
        Map<S, Double> v   = new HashMap<S, Double>();
        for (PairSA p: q.keySet()) {
            Double vl = v.get(p.s);
            if (vl == null)
                vl = 0.0;
            if (q.get(p) > vl) {
                v.put((S)p.s, q.get(p));
                map.put((S)p.s, p.a);
            }
        }
        return map;
    }
    
    public double max(State s) {
        double max = Double.NEGATIVE_INFINITY;
        // for all actions, get the max q-value
        for( int i=0; i<actions.length; i++) {
            PairSA p = new PairSA(s, actions[i]);
            max = Math.max(max, getQ(p));
        }
        return max;
    }
    
    public String argmax(State s) {
        String a = null;
        double max = Double.NEGATIVE_INFINITY;
        // for all actions, get the max q-value
        for( int i=0; i<actions.length; i++) {
            //System.out.println("a="+actions[i]);
            PairSA p = new PairSA(s, actions[i]);
            double q = getQ(p);
            //System.out.print(", oq="+q);
            if (q > max) {
                max = q;
                a = actions[i];
                //System.out.print(" * ");
            }
        }
        
        //System.out.println(" ---- q="+max);
        if (a == null) { // no best action, ...
            return actions[ random.nextInt( actions.length )];
        } else {
            return a;
        }
    }
    
    
    
    //
    // epsilon-Greedy exploration x exploitation
    //

    public void setEpsilon(double e) {
        if (e >= 0 && e <= 1) {
            epsilon = e;
        } else {
            System.err.println("trying to set invalid epsilon value "+e);
        }
    }
    
    public double getEpsilon() {
        return epsilon;
    }    
    public void setEpsilonDecrement(double d) {
        epsilonDec = d;
    }
    public void setEpsilonMinValue(double m) {
        epsilonMin = m;
    }
    
    public String getExplorationActionByGreedy(State s) {
        if (epsilon > epsilonMin)
            epsilon = epsilon - epsilonDec;
        double r = random.nextDouble();
        if (r < epsilon) // exploration
            return actions[ random.nextInt( actions.length ) ];
        else // exploitation
            return argmax(s);
    }
    
    //
    // minimum number of trials exploration x exploitation
    //
    
    Map<PairSA, Integer> n = new HashMap<PairSA, Integer>(); // the number of trials of each action on states
    int numberExploration = 2; // the number of desired explorations for each action
    public String getExplorationActionByMinimumNumberOfTrials(State s) {
        
        // try to find a randomlly selected unexplored action
        for( int i=0; i<actions.length / 2; i++) {
            String a = actions[ random.nextInt( actions.length ) ];
            PairSA p = new PairSA(s, a);
            int n = getN(p);
            if (n < numberExploration) {
                return a;
            }
        }
        
        // all action are well tried
        //return argmax(s);
        
        // use greedy
        return getExplorationActionByGreedy(s);
    }
    
    public int getN(PairSA p) {
        Integer i = n.get(p);
        if (i == null) {
            return 0;
        } else {
            return i.intValue();
        }
    }
    
    private void setN(PairSA p, int v) {
        n.put( p, v);
    }
    
    public void saveQ(String fileName) {
        try {
            ObjectOutputStream oout = new ObjectOutputStream(new FileOutputStream(fileName+".obj"));
            oout.writeObject(q);
            oout.close();
        } catch (Exception e) {
            System.err.println("Error saving Q-table." + e);
        }
    }
    
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public void loadQ(String fileName) {
        try {
            ObjectInputStream oin = new ObjectInputStream(new FileInputStream(fileName+".obj"));
            q = (Map)oin.readObject();
            oin.close();
        } catch (Exception e) {
            System.err.println("Error loading Q-table." + e);
        }
    }
    
    public String printN() {
        StringBuffer s = new StringBuffer();
        Iterator<PairSA> i = n.keySet().iterator();
        while (i.hasNext()) {
            PairSA k = i.next();
            s.append( k + "=" + n.get(k) + "\n");
        }
        return s.toString();
    }
    
    
    public String toString() {
        StringBuffer s = new StringBuffer();
        Iterator<PairSA> i = q.keySet().iterator();
        while (i.hasNext()) {
            PairSA k = i.next();
            s.append( k + "=" + q.get(k) + "\n");
        }
        return s.toString();
    }
}
