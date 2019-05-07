package qlearning;

/**
 * Interface for state
 * 
 * @author  jomi
 */
public interface State extends java.io.Serializable {
     public boolean equals(Object o);
     public int     hashCode();
}
