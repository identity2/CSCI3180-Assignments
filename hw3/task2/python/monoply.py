# CSCI3180 Principles of Programming Languages
#
# --- Declaration ---
#
# I declare that the assignment here submitted is original except for source
# material explicitly acknowledged. I also acknowledge that I am aware of
# University policy and regulations on honesty in academic work, and of the
# disciplinary guidelines and procedures applicable to breaches of such policy
# and regulations, as contained in the website
# http://www.cuhk.edu.hk/policy/academichonesty/
#
# Assignment 3
# Name : Chao Yu
# Student ID : 1155053722
# Email Addr : ychao5@cse.cuhk.edu.hk

import random

random.seed(0) # don't touch!

# you are not allowed to modify Player class!
class Player:
    due = 200
    income = 0
    tax_rate = 0.2
    handling_fee_rate = 0
    prison_rounds = 2

    def __init__(self, name):
        self.name = name
        self.money = 100000
        self.position = 0
        self.num_rounds_in_jail = 0

    def updateAsset(self):
        self.money += Player.income

    def payDue(self):
        self.money += Player.income * (1 - Player.tax_rate)
        self.money -= Player.due * (1 + Player.handling_fee_rate)

    def printAsset(self):
        print("Player %s's money: %d" % (self.name, self.money))

    def putToJail(self):
        self.num_rounds_in_jail = Player.prison_rounds

    def move(self, step):
        if self.num_rounds_in_jail > 0:
            self.num_rounds_in_jail -= 1
        else:
            self.position = (self.position + step) % 36



class Bank:
    def __init__(self):
        pass

    def print(self):
        print("Bank ", end='')

    def stepOn(self):
        Player.tax_rate = 0
        Player.income = 2000
        Player.due = 0
        cur_player.payDue()
        print("You received $2000 from the Bank!")

class Jail:
    def __init__(self):
        pass

    def print(self):
        print("Jail ", end='')

    def stepOn(self):
        print("Pay $1000 to reduce the prison round to 1? [y/n]")
        choice = input()
        if choice == "y":
            Player.due = 1000
            Player.handling_fee_rate = 0.1
            Player.income = 0
            Player.prison_rounds = 1
            cur_player.payDue()
        else:
            Player.prison_rounds = 2

        cur_player.putToJail()


class Land:
    def __init__(self):
        self.owner = None
        self.level = 0

    def print(self):
        if self.owner is None:
            print("Land ", end='')
        else:
            print("%s:Lv%d" % (self.owner.name, self.level), end="")
    
    def buyLand(self):
        Player.due = 1000
        Player.handling_fee_rate = 0.1
        Player.income = 0
        cur_player.payDue()

        self.owner = cur_player
    
    def upgradeLand(self, cost):
        Player.handling_fee_rate = 0.1
        Player.due = cost
        Player.income = 0
        cur_player.payDue()

        self.level = self.level + 1
    
    def chargeToll(self, cost, tax):
        Player.due = cost
        Player.handling_fee_rate = 0
        Player.income = 0
        cur_player.payDue()

        Player.due = 0
        Player.income = cost
        Player.tax_rate = tax
        self.owner.payDue()

    def stepOn(self):
        if self.owner == None:
            # Unowned.
            print("Pay $1000 to buy the land? [y/n]")
            choice = input()
            if choice == "y":
                self.buyLand()
        elif self.owner is cur_player:
            # Owned by the player.
            cost = 0
            if self.level == 0:
                cost = 1000
            elif self.level == 1:
                cost = 2000
            elif self.level == 2:
                cost = 5000
            else:
                # Already highest level.
                return
            print("Pay ${} to upgrade the land? [y/n]".format(cost))
            choice = input()
            if choice == "y":
                self.upgradeLand(cost)
        else:
            cost = 0
            tax = 0
            if self.level == 0:
                cost = 500
                tax = 0.1
            elif self.level == 1:
                cost = 1000
                tax = 0.15
            elif self.level == 2:
                cost = 1500
                tax = 0.2
            elif self.level == 3:
                cost = 3000
                tax = 0.25
            print("You need to pay player {} ${}".format(self.owner.name, cost))
            self.chargeToll(cost, tax)



players = [Player("A"), Player("B")]
cur_player = players[0]
num_players = len(players)
cur_player_idx = 0
cur_player = players[cur_player_idx]
num_dices = 1
cur_round = 0
max_round = 100

game_board = [
    Bank(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Jail(),
    Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(),
    Jail(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land(), Jail(),
    Land(), Land(), Land(), Land(), Land(), Land(), Land(), Land()
]
game_board_size = len(game_board)


def printCellPrefix(position):
    occupying = []
    for player in players:
        if player.position == position and player.money > 0:
            occupying.append(player.name)
    print(" " * (num_players - len(occupying)) + "".join(occupying), end='')
    if len(occupying) > 0:
        print("|", end='')
    else:
        print(" ", end='')


def printGameBoard():
    print("-" * (10 * (num_players + 6)))
    for i in range(10):
        printCellPrefix(i)
        game_board[i].print()
    print("\n")
    for i in range(8):
        printCellPrefix(game_board_size - i - 1)
        game_board[-i - 1].print()
        print(" " * (8 * (num_players + 6)), end="")
        printCellPrefix(i + 10)
        game_board[i + 10].print()
        print("\n")
    for i in range(10):
        printCellPrefix(27 - i)
        game_board[27 - i].print()
    print("")
    print("-" * (10 * (num_players + 6)))


def termination_check():
    if cur_player.money <= 0:
        return True
    return False


def throwDice():
    step = 0
    for i in range(num_dices):
        step += random.randint(1, 6)
    return step


def main():
    global cur_player
    global num_dices
    global cur_round
    global cur_player_idx

    game_ended = False
    while not game_ended:
        printGameBoard()
        for player in players:
            player.printAsset()

        print("Player {}'s term.".format(cur_player.name))

        # Pay the $200 fixed fee.
        Player.due = 200
        Player.handling_fee_rate = 0
        Player.income = 0
        cur_player.payDue()

        if (cur_player.num_rounds_in_jail == 0):
            # Player not in jail. Throw the dice.
            dice_step = 0
            print("Pay $500 to throw two dice? [y/n]")
            choice = input()
            
            if choice == "y":
                num_dices = 2
                
                Player.due = 500
                Player.handling_fee_rate = 0.05
                Player.income = 0
                cur_player.payDue()
            else:
                num_dices = 1
            
            dice_step = throwDice()
            print("Points of dices: {}.".format(dice_step))

            # Move the player and show new gameboard.
            cur_player.move(dice_step)
            printGameBoard()

            # Perform slot action.
            cur_slot = game_board[cur_player.position]
            cur_slot.stepOn()

        else:
            # In jail. Still moves to reduce prison term.
            cur_player.move(0)

        # Check if the game should end.
        if termination_check():
            game_ended = True

        # Switch to the next player.
        cur_player_idx = (cur_player_idx + 1) % num_players
        cur_player = players[cur_player_idx]
        
    # Game over message.
    print("Game over! winner: {}.".format(cur_player.name))


if __name__ == '__main__':
    main()
