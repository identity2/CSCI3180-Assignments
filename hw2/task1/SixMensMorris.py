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

"""Please refer to the specification of Task 1 for more
details about this game.
"""

"""Warning: Apart from completing these member functions (TODO marks), 
Do Not change any other parts of our provided source code. 
"""

"""Tips: Debug the code by inserting `from IPython import embed; embed()'
"""

import random; random.seed(0)

from utils import *
from Board import Board
from Human import Human
from Player import Player
from Computer import Computer

class SixMensMorris():
    def __init__(self):
        self.board = Board()
        self.players = []
        self.num_play = 0 
        
    def nextPlayer(self):
        self.num_play += 1
        return self.players[ 1 - self.num_play % 2 ]

    def opponent(self, player):
        return self.players[ self.num_play % 2 ]

    def checkWin(self, player):
        ifWin = False
        if self.board.checkWin(player, self.opponent(player)):
            print('Congratulation to the winner: {}!'.format( 
                g('Player 1') if player.get_id() == 1 else b('Player 2') 
            ))
            ifWin = True
        return ifWin

    def startGame(self):
        # Choose the player type for both players
        print('Please choose Player 1:')
        print('1. Human Player')
        print('2. Computer Player')
        x = input('Your choice is: ')
        if x == '1':
            self.players.append(Human(1, self.board))
            print('Player 1 is a human.')
        elif x == '2':
            self.players.append(Computer(1, self.board))
            print('Player 1 is a computer.')

        print('Please choose Player 2:')
        print('1. Human Player')
        print('2. Computer Player')
        x = input('Your choice is: ')
        if x == '1':
            self.players.append(Human(2, self.board))
            print('Player 2 is a human.')
        elif x == '2':
            self.players.append(Computer(2, self.board))
            print('Player 2 is a computer.')

        # Start the game
        self.board.printBoard()
        end = False
        while not end:
            player = self.nextPlayer()

            if self.num_play <= 12:
                # Phase 1
                x = player.nextPut()
            else:
                # Phase 2
                x = player.nextMove()
            self.board.printBoard()

            if self.num_play > 12 and self.checkWin(player):
                end = True
            else:
                if self.board.formMill(x, player):
                    print('You form a mill!')
                    
                    player.nextRemove(self.opponent(player))
                    
                    self.board.printBoard()
                
                if self.num_play > 12 and self.checkWin(player):
                    end = True

if __name__ == '__main__':
    game = SixMensMorris()
    game.startGame()


