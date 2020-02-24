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

from utils import *
from Player import Player

class Human(Player):
    def __init__(self, id, board):
        super(Human, self).__init__(id, board)

    def next_put(self):
        """
        This function takes a single location input for PUT-movement. It keeps checking
        whether it is a legal PUT-movement until the input is a legal PUT-movement. After
        getting the correct input, it then does the movement on the board (by calling
        board.put_piece()). It returns the position where the piece locates because 
        it might trigger the end of the game.
        """
        valid_flag = True
        while valid_flag:
            x = input('{} [Put] (pos): '.format( \
                g('Player 1') if self.id == 1 else b('Player 2') )).lower().strip()
            if len(x) != 1:
                print('Invalid Put-Movement.')
            else:
                x = sym_to_pos(x)
                if not self.board.check_put(x):
                    print('Invalid Put-Movement.')
                else:
                    valid_flag = False
        self.board.put_piece(x, self)
        return x

    def next_move(self):
        """
        This function takes two location inputs (s, t) for MOVE-movement. It keeps checking
        whether it is a legal MOVE-movement until the input is a legal MOVE-movement.
        After getting the correct input, it then does the movement on the board (by calling
        board.move_piece()). It returns the position to which the piece moves because 
        it might trigger the end of the game.
        """
        valid_flag = True
        while valid_flag:
            x = input('{} [Move] (from to): '.format( \
                g('Player 1') if self.id == 1 else b('Player 2') )).lower().strip().split(' ')

            if len(x) != 2:
                print('Invalid Move-Movement.')
            else:
                xs = sym_to_pos(x[0])
                xt = sym_to_pos(x[1])
                if not self.board.check_move(xs, xt, self):
                    print('Invalid Move-Movement.')
                else:
                    valid_flag = False

        self.board.move_piece(xs, xt, self)
        return xt

    def next_remove(self, opponent):
        """
        This function takes a location input for REMOVE-movement. It keeps checking whether
        it is a legal REMOVE-movement until the input is a legal REMOVE-movement. After
        getting the correct input, it then does REMOVE-movement on the board (by calling
        board.remove_piece()).
        """
        valid_flag = True
        while valid_flag:
            x = input('{} [Remove] (pos): '.format( \
                g('Player 1') if self.id == 1 else b('Player 2') )).lower().strip()
            
            if len(x) != 1:
                print('Invalid Remove-Movement.')
            else:
                x = sym_to_pos(x)
                if not self.board.check_remove(x, opponent):
                    print('Invalid Remove-Movement.')
                else:
                    valid_flag = False

        self.board.remove_piece(x, opponent)


