package example.grid;
import qlearning.State;

/**
 * To test q-learning
 *
 * @author  jomi
 */

public class GridState implements State {
    
    int  x; // col
    int  y; // lin
    
    /** initial state */
    public GridState() {
        x = 1;
        y = 1;
    }
    
    public GridState(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public boolean isTerminal() {
        return (x == 4 && y == 3) || (x == 4 && y == 2);
    }

    public double getReward() {
        if (x == 4 && y == 3) 
            return 1;
        if (x == 4 && y == 2) 
            return -1;
        return 0;
    }
    
    public GridState simulateAction(String action) {
        int nx = x;
        int ny = y;
        if (action.equals("N")) {
            if (y < 3) 
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
        
        if (nx == 2 && ny == 2) { // the obstacle
            nx = x;
            ny = y;
        }
        return new GridState(nx, ny);
    }
    

    
    @Override
    public boolean equals(Object o) {
        GridState os = (GridState)o;
        return (this.x == os.x && this.y == os.y);
    }
    
    @Override
    public int hashCode() {
        return x*31 + y;
    }
    
    public String toString() {
        return "s("+x+","+y+")";
    }

}

