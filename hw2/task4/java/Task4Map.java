/*
* CSCI3180 Principles of Programming Languages
*
* --- Declaration ---
*
* I declare that the assignment here submitted is original except for source
* material explicitly acknowledged. I also acknowledge that I am aware of
* University policy and regulations on honesty in academic work, and of the
* disciplinary guidelines and procedures applicable to breaches of such policy
* and regulations, as contained in the website
* http://www.cuhk.edu.hk/policy/academichonesty/
*
* Assignment 2
* Name : Chao Yu
* Student ID : 1155053722
* Email Addr : ychao5@cse.cuhk.edu.hk
*/

public class Task4Map {
  private Cell[][] cells;

  public Task4Map() {
    this.cells = new Cell[7][7];
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 7; j++) {
        this.cells[i][j] = new Cell();
      }
    }
  }

  /* Add objects to the game map. */
  public void addObject(Object object) {
    Pos pos = null;

    if (object instanceof Monster[]) {
      for (Monster monster : ((Monster[]) object)) {
        pos = monster.getPos();
        this.cells[pos.getRow() - 1][pos.getColumn() - 1].setOccupiedObject(monster);
      }
    } else {
      if (object instanceof Soldier) {
        pos = ((Soldier) object).getPos();
      } else if (object instanceof Spring) {
        pos = ((Spring) object).getPos();
      } else if (object instanceof Merchant) {
        pos = ((Merchant) object).getPos();
      }

      if (pos != null) {
        this.cells[pos.getRow() - 1][pos.getColumn() - 1].setOccupiedObject(object);
      }
    }
  }

  /* Print the game map in console. */
  public void displayMap() {
    System.out.println("   | 1 | 2 | 3 | 4 | 5 | 6 | 7 |");
    System.out.println("--------------------------------");
    for (int i = 0; i < 7; i++) {
      System.out.printf(" %d |", i + 1);
      for (int j = 0; j < 7; j++) {
        Object occupiedObject = this.cells[i][j].getOccupiedObject();
        if (occupiedObject != null) {
          System.out.printf(" ");
          if (occupiedObject instanceof Monster) {
            ((Monster) occupiedObject).displaySymbol();
          } else if (occupiedObject instanceof Spring) {
            ((Spring) occupiedObject).displaySymbol();
          } else if (occupiedObject instanceof Soldier) {
            ((Soldier) occupiedObject).displaySymbol();
          } else if (occupiedObject instanceof Merchant) {
            ((Merchant) occupiedObject).displaySymbol();
          }
          System.out.printf(" |");
        } else {
          System.out.print("   |");
        }
      }
      System.out.printf("%n");
      System.out.println("--------------------------------");
    }
    System.out.println();
  }

  public Object getOccupiedObject(int row, int column) {
    return this.cells[row - 1][column - 1].getOccupiedObject();
  }

  public boolean checkMove(int row, int column) {
    return ((row >= 1 && row <= 7) && (column >= 1 && column <= 7));
  }

  public void update(Soldier soldier, int oldRow, int oldColumn, int newRow, int newColumn) {
    this.cells[oldRow - 1][oldColumn - 1].setOccupiedObject(null);
    this.cells[newRow - 1][newColumn - 1].setOccupiedObject(soldier);
  }
}