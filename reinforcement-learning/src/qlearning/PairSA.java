package qlearning;

/**
 * An State x Action pair
 * 
 * @author  jomi
 */
public class PairSA implements java.io.Serializable {
    
    State  s;
    String a;

    public PairSA(State s, String a) {
        this.s = s;
        this.a = a;
    }
    
    public boolean equals(Object o) {
        if (o == null) return false;
        if (o == this) return true;
        if (! (o instanceof PairSA)) return false;
        PairSA op = (PairSA)o;
        return s.equals(op.s) && a.equals(op.a);
    }
    
    public State getState() {
        return s;
    }
    
    public String getAction() {
        return a;
    }
    
    public int hashCode() {
        return s.hashCode() + a.hashCode();
    }
    
    public String toString() {
        return "Q("+s+","+a+")";
    }
}
