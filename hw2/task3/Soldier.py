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

import random
from Pos import Pos

class Soldier():
    def __init__(self):
        self.health = 100
        self.num_elixirs = 2
        self.pos = Pos()
        self.keys = []

    def get_health(self):
        return self.health

    def lose_health(self):
        self.health -= 10
        return self.health <= 0

    def recover(self, healing_power):
        total_health = healing_power + self.health
        self.health = 100 if total_health >= 100 else total_health
    
    def get_pos(self):
        return self.pos

    def set_pos(self, row, column):
        self.pos.set_pos(row, column)

    def move(self, row, column):
        self.set_pos(row, column)

    def get_keys(self):
        return self.keys

    def add_key(self, key):
        self.keys.append(key)

    def get_num_elixirs(self):
        return self.num_elixirs

    def add_elixir(self):
        self.num_elixirs += 1

    def use_elixir(self):
        self.recover(random.randint(0, 5) + 15)
        self.num_elixirs -= 1

    def display_information(self):
        print("Health: {}.".format(self.health))
        print("Position (row, column): ({}, {}).".format(self.pos.get_row(), self.pos.get_column()))
        print("Keys: " + str(sorted(set(self.keys))) + ".")
        print("Elixirs: {}.".format(self.num_elixirs))

    def display_symbol(self):
        print("S", end="")
