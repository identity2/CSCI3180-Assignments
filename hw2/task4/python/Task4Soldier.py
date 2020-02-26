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

from Soldier import Soldier

class Task4Soldier(Soldier):
    def __init__(self):
        super().__init__()
        self.defence = 0
        self.coin = 0

    def get_defence(self):
        return self.defence
    
    def add_defence(self):
        self.defence += 5
    
    def get_coin(self):
        return self.coin
    
    def add_coin(self):
        self.coin += 1
    
    def spend_coin(self, num):
        self.coin -= num
    
    # Override
    def display_information(self):
        super().display_information()
        print("Defence: {}.".format(self.defence))
        print("Coins: {}.".format(self.coin))

    # Override
    def lose_health(self):
        lose_amount = 0 if self.defence >= 10 else 10 - self.defence
        self.health -= lose_amount
        return self.health <= 0
