public class Task4Monster extends Monster {
    public Task4Monster(int monsterID, int healthCapacity) {
        super(monsterID, healthCapacity);
    }

    @Override
    public void dropItems(Soldier soldier) {
        super.dropItems(soldier);
        ((Task4Soldier) soldier).addCoin();
    }
}
