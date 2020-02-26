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

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Scanner;

public class Monster {
  private int monsterID;
  private int healthCapacity;
  private int health;
  private Pos pos;
  private ArrayList<Integer> dropItemList;
  private ArrayList<Integer> hintList;

  public Monster(int monsterID, int healthCapacity) {
    this.monsterID = monsterID;
    this.healthCapacity = healthCapacity;
    this.health = healthCapacity;
    this.pos = new Pos();
    this.dropItemList = new ArrayList<Integer>();
    this.hintList = new ArrayList<Integer>();
  }

  public void addDropItem(int key) {
    this.dropItemList.add(key);
  }

  public void addHint(int monsterID) {
    this.hintList.add(monsterID);
  }

  public int getMonsterID() {
    return this.monsterID;
  }

  public Pos getPos() {
    return this.pos;
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }

  public int getHealthCapacity() {
    return this.healthCapacity;
  }

  public int getHealth() {
    return this.health;
  }

  public boolean loseHealth() {
    this.health -= 10;
    return this.health <= 0;
  }

  public void recover(int healingPower) {
    this.health = healingPower;
  }

  public void actionOnSoldier(Soldier soldier) {
    if (this.health <= 0) {
      this.talk("You had defeated me.%n%n");
    } else {
      if (this.requireKey(soldier.getKeys())) {
        this.fight(soldier);
      } else {
        this.displayHints();
      }
    }
  }

  public boolean requireKey(HashSet<Integer> keys) {
    return keys.contains(this.monsterID);
  }

  public void displayHints() {
    this.talk("Defeat Monster " + this.hintList + " first.%n%n");
  }

  public void fight(Soldier soldier) {
    boolean fightEnabled = true;

    while (fightEnabled) {
      System.out.printf("       | Monster%d | Soldier |%n", this.monsterID);
      System.out.printf("Health | %8d | %7d |%n%n", this.health, soldier.getHealth());
      System.out.printf("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ");

      Scanner sc = new Scanner(System.in);

      String choice = sc.nextLine();

      if (choice.equalsIgnoreCase("1")) {
        if (this.loseHealth()) {
          System.out.printf("=> You defeated Monster%d.%n%n", this.monsterID);
          this.dropItems(soldier);
          fightEnabled = false;
        } else {
          if (soldier.loseHealth()) {
            this.recover(this.healthCapacity);
            fightEnabled = false;
          }
        }
      } else if (choice.equalsIgnoreCase("2")) {
        this.recover(this.healthCapacity);
        fightEnabled = false;
      } else if (choice.equalsIgnoreCase("3")) {
        if (soldier.getNumElixirs() == 0) {
          System.out.printf("=> You have run out of elixirs.%n%n");
        } else {
          soldier.useElixir();
        }
      } else {
        System.out.printf("=> Illegal choice!%n%n");
      }
    }
  }

  public void dropItems(Soldier soldier) {
    for (Integer item : this.dropItemList) {
      soldier.addKey(item);
    }
  }

  public void talk(String text) {
    System.out.printf("Monster%d: " + text, this.monsterID);
  }

  public void displaySymbol() {
    System.out.printf("M");
  }
}