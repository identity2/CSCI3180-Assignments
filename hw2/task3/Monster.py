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

class Monster():
    def __init__(self, monster_id, health_capacity):
        self.monster_id = monster_id
        self.health_capacity = health_capacity
        self.health = health_capacity
        self.pos = Pos()
        self.drop_item_list = []
        self.hint_list = []

    def add_drop_item(self, key):
        self.drop_item_list.append(key)
    
    def add_hint(self, monster_id):
        self.hint_list.append(monster_id)

    def get_monster_id(self):
        return self.monster_id

    def get_pos(self):
        return self.pos

    def set_pos(self, row, column):
        self.pos.set_pos(row, column)

    def get_health_capacity(self):
        return self.health_capacity

    def get_health(self):
        return self.health

    def lose_health(self):
        self.health -= 10
        return self.health <= 0

    def recover(self, healing_power):
        self.health = healing_power

    def action_on_soldier(self, soldier):
        if self.health <= 0:
            self.talk("You had defeated me.\n\n")
        else:
            if self.require_key(soldier.get_keys()):
                self.fight(soldier)
            else:
                self.display_hints()
    
    def require_key(self, keys):
        return self.monster_id in keys
    
    def display_hints(self):
        self.talk("Defeat Monster " + str(self.hint_list) + " first.\n\n")

    def fight(self, soldier):
        fight_enabled = True
        
        while fight_enabled:
            print("       | Monster{} | Soldier |".format(self.monster_id))
            print("Health | %8d | %7d |\n" % (self.health, soldier.get_health()))
            choice = input("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ")

            if choice == "1":
                if self.lose_health():
                    print("=> You defeated Monster{}.\n".format(self.monster_id))
                    self.drop_items(soldier)
                    fight_enabled = False
                else:
                    if soldier.lose_health():
                        self.recover(self.health_capacity)
                        fight_enabled = False
            elif choice == "2":
                self.recover(self.health_capacity)
                fight_enabled = False
            elif choice == "3":
                if soldier.get_num_elixirs() == 0:
                    print("=> You have run out of elixirs.\n")
                else:
                    soldier.use_elixir()
            else:
                print("=> Illegal choice!\n")

    def drop_items(self, soldier):
        for item in self.drop_item_list:
            soldier.add_key(item)
    
    def talk(self, text):
        print("Monster{}: ".format(self.monster_id) + text, end="")
    
    def display_symbol(self):
        print("M", end="")
