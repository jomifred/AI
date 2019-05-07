package example.wumpus;
import qlearning.State;

/**
 * Wumpus's World states
 *
 * @author  Jomi
 */

public class WumpusState implements State {
    
    int  x; // col
    int  y; // lin
    
    boolean hasGold = false;
    
    /** initial state */
    public WumpusState() {
        x = 1;
        y = 1;
    }
    
    public WumpusState(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public double getReward(WumpusState previous) {
        if (x == 1 && y == 1 && hasGold)
            return 1;
        
        if (previous != null && !previous.hasGold && this.hasGold)
            return 0.1;
        
        // pits
        if (x == 3 && y == 1) return -1;
        if (x == 3 && y == 3) return -1;
        if (x == 4 && y == 4) return -1;
        
        // wumpus
        if (x == 1 && y == 3) return -1;

        return -0.1;
        /*
        if (hasGold)
            return -0.1;
        else
            return -0.3;
            */
    }
    
    public boolean isTerminal() {
        return Math.abs(getReward(null)) == 1;
    }

    
    public WumpusState simulateAction(String action) {
        int nx = x;
        int ny = y;
        if (action.equals("N")) {
            if (y < 4) 
                ny = ny + 1;
        } else if (action.equals("S")) {
            if (y > 1)
                ny = ny - 1;
        } else if (action.equals("W")) {
            if (x > 1)
                nx = nx - 1;
        } else if (action.equals("E")) {
            if (x < 4)
                nx = nx + 1;
        } 
        
        WumpusState ws = new WumpusState(nx, ny);
        
        if (action.equals("P") && nx == 2 && ny == 3) {
            ws.hasGold = true;
        } else {
            ws.hasGold = this.hasGold;
        }
        
        return ws;
    }
    

    
    @Override
    public boolean equals(Object o) {
        WumpusState os = (WumpusState)o;
        return (this.x == os.x && this.y == os.y && this.hasGold == os.hasGold);
    }
    
    @Override
    public int hashCode() {
        if (hasGold)
            return x*31 + y;
        else
            return x*17 + y;
    }
    
    public String toString() {
        return "s("+x+","+y+")"+(hasGold?"*":"");
    }

}

