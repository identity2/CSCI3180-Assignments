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

import java.util.Scanner;

public class Merchant {
  private int elixirPrice;
  private int shieldPrice;
  private Pos pos;

  public Merchant() {
    this.pos = new Pos();
    this.shieldPrice = 2;
    this.elixirPrice = 1;
  }

  public void actionOnSoldier(Task4Soldier soldier) {
    this.talk("Do you want to buy something? (1. Elixir, 2. Shield) Input: ");

    Scanner sc = new Scanner(System.in);
    String choice = sc.nextLine();

    if (choice.equalsIgnoreCase("1")) {
      if (soldier.getCoin() >= elixirPrice) {
        soldier.spendCoin(elixirPrice);
        soldier.addElixir();
      }
    } else if (choice.equalsIgnoreCase("2")) {
      if (soldier.getCoin() >= shieldPrice) {
        soldier.spendCoin(shieldPrice);
        soldier.addDefence();
      }
    } else {
      System.out.printf("=> Illegal choice!%n%n");
    }

  }

  public void talk(String text) {
    System.out.printf("Merchant$: " + text);
  }

  public void displaySymbol() {
    System.out.printf("$");
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }

  public Pos getPos() {
    return this.pos;
  }

}