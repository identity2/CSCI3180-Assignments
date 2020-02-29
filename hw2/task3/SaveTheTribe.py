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

from Map import Map
from Soldier import Soldier
from Spring import Spring
from Monster import Monster

class SaveTheTribe():
    def __init__(self):
        self.map = Map()
        self.soldier = Soldier()
        self.spring = Spring()
        self.monsters = []
        self.game_enabled = True
    
    def initialize(self):
        self.monsters.append(Monster(1, random.randint(0, 4) * 10 + 30))
        self.monsters[0].set_pos(4, 1)
        self.monsters[0].add_drop_item(2)
        self.monsters[0].add_drop_item(3)

        self.monsters.append(Monster(2, random.randint(0, 4) * 10 + 30))
        self.monsters[1].set_pos(3, 3)
        self.monsters[1].add_drop_item(3)
        self.monsters[1].add_drop_item(6)
        self.monsters[1].add_hint(1)
        self.monsters[1].add_hint(5)

        self.monsters.append(Monster(3, random.randint(0, 4) * 10 + 30))
        self.monsters[2].set_pos(5, 3)
        self.monsters[2].add_drop_item(4)
        self.monsters[2].add_hint(1)
        self.monsters[2].add_hint(2)

        self.monsters.append(Monster(4, random.randint(0, 4) * 10 + 30))
        self.monsters[3].set_pos(5, 5)
        self.monsters[3].add_hint(3)
        self.monsters[3].add_hint(6)

        self.monsters.append(Monster(5, random.randint(0, 4) * 10 + 30))
        self.monsters[4].set_pos(1, 4)
        self.monsters[4].add_drop_item(2)
        self.monsters[4].add_drop_item(6)

        self.monsters.append(Monster(6, random.randint(0, 4) * 10 + 30))
        self.monsters[5].set_pos(3, 5)
        self.monsters[5].add_drop_item(4)
        self.monsters[5].add_drop_item(7)
        self.monsters[5].add_hint(2)
        self.monsters[5].add_hint(5)

        self.monsters.append(Monster(7, random.randint(0, 4) * 10 + 30))
        self.monsters[6].set_pos(4, 7)
        self.monsters[6].add_drop_item(-1)
        self.monsters[6].add_hint(6)

        self.map.add_object(self.monsters)

        self.soldier.set_pos(1, 1)
        self.soldier.add_key(1)
        self.soldier.add_key(5)

        self.map.add_object(self.soldier)

        self.spring.set_pos(7, 4)

        self.map.add_object(self.spring)
    
    def start(self):
        print("=> Welcome to the desert!")
        print("=> Now you have to defeat the monsters and find the artifact to save the tribe.\n")

        while self.game_enabled:
            self.map.display_map()
            self.soldier.display_information()

            move = input("\n=> What is the next step? (W = Up, S = Down, A = Left, D = Right.) Input: ")
            pos = self.soldier.get_pos()
            old_row, old_column = pos.get_row(), pos.get_column()
            new_row, new_column = pos.get_row(), pos.get_column()
            
            if move.lower() == "w":
                new_row = old_row - 1
            elif move.lower() == "s":
                new_row = old_row + 1
            elif move.lower() == "a":
                new_column = old_column - 1
            elif move.lower() == "d":
                new_column = old_column + 1
            else:
                print("=> Illegal move!\n")
                continue
        
            if self.map.check_move(new_row, new_column):
                occupied_object = self.map.get_occupied_object(new_row, new_column)

                if occupied_object != None:
                    occupied_object.action_on_soldier(self.soldier)
                else:
                    self.soldier.move(new_row, new_column)
                    self.map.update(self.soldier, old_row, old_column, new_row, new_column)
                    print("\n")
            else:
                print("=> Illegal move!\n")
            
            if self.soldier.get_health() <= 0:
                print("=> You died.")
                print("=> Game over.\n")
                self.game_enabled = False
            
            if -1 in self.soldier.get_keys():
                print("=> You found the artifact.")
                print("=> Game over.\n")
                self.game_enabled = False

if __name__  == "__main__":
    game = SaveTheTribe()
    game.initialize()
    game.start()
