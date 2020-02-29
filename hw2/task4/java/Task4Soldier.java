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
 * Assignment 2 Name : Chao Yu Student ID : 1155053722 Email Addr :
 * ychao5@cse.cuhk.edu.hk
 */

public class Task4Soldier extends Soldier {
    private int defence;
    private int coin;

    public Task4Soldier() {
        this.defence = 0;
        this.coin = 0;
    }

    public int getDefence() {
        return defence;
    }

    public void addDefence() {
        this.defence += 5;
    }

    public int getCoin() {
        return this.coin;
    }

    public void addCoin() {
        this.coin += 1;
    }

    public void spendCoin(int num) {
        this.coin -= num;
    }

    @Override
    public void displayInformation() {
        super.displayInformation();
        System.out.printf("Defence: %d.%n", this.defence);
        System.out.printf("Coins: %d.%n", this.coin);
    }

    @Override
    public boolean loseHealth() {
        int loseAmount = this.defence >= 10 ? 0 : 10 - this.defence;
        this.health -= loseAmount;
        return this.health <= 0;
    }
}
