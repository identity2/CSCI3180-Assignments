"""
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
"""

from Pos import Pos

class Task4Merchant():
    def __init__(self):
        self.pos = Pos()
        self.shield_price = 2
        self.elixir_price = 1
    
    def action_on_soldier(self, soldier):
        self.talk("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave) Input: ")

        choice = input()

        if choice == "1":
            if soldier.get_coin() >= self.elixir_price:
                soldier.spend_coin(self.elixir_price)
                soldier.add_elixir()
            else:
                print("You don't have enough coins.\n")
        elif choice == "2":
            if soldier.get_coin() >= self.shield_price:
                soldier.spend_coin(self.shield_price)
                soldier.add_defence()
            else:
                print("You don't have enough coins.\n")
        elif choice == "3":
            return
        else:
            print("=> Illegal choice!\n")
    
    def talk(self, text):
        print("Merchant$: " + text, end="")
    
    def display_symbol(self):
        print("$", end="")
    
    def set_pos(self, row, column):
        self.pos.set_pos(row, column)
    
    def get_pos(self):
        return self.pos
