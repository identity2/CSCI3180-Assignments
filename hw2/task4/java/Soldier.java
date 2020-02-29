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

import java.util.HashSet;
import java.util.Random;

public class Soldier {
  protected int health;
  private int numElixirs;
  private Pos pos;
  private HashSet<Integer> keys;

  public Soldier() {
    this.health = 100;
    this.numElixirs = 2;
    this.pos = new Pos();
    this.keys = new HashSet<Integer>();
    /*
     * It is possible for the soldier to obtain two identical keys in the game. To
     * simplify the operation, we use set here to remove duplicate keys.
     */
  }

  public int getHealth() {
    return this.health;
  }

  public boolean loseHealth() {
    this.health -= 10;
    return this.health <= 0;
  }

  public void recover(int healingPower) {
    /* Soldier's health cannot exceed capacity. */
    int totalHealth = healingPower + this.health;
    this.health = totalHealth >= 100 ? 100 : totalHealth;
  }

  public Pos getPos() {
    return this.pos;
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }

  public void move(int row, int column) {
    this.setPos(row, column);
  }

  public HashSet<Integer> getKeys() {
    return this.keys;
  }

  public void addKey(int key) {
    this.keys.add(key);
  }

  public int getNumElixirs() {
    return this.numElixirs;
  }

  public void addElixir() {
    this.numElixirs += 1;
  }

  public void useElixir() {
    Random random = new Random();
    this.recover(random.nextInt(6) + 15);
    this.numElixirs -= 1;
  }

  public void displayInformation() {
    System.out.printf("Health: %d.%n", this.health);
    System.out.printf("Position (row, column): (%d, %d).%n", this.pos.getRow(), this.pos.getColumn());
    System.out.printf("Keys: " + this.keys + ".%n");
    System.out.printf("Elixirs: %d.%n", this.numElixirs);
  }

  public void displaySymbol() {
    System.out.printf("S");
  }
}