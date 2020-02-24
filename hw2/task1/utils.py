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

color_mode = True # if you want to close the color mode, just set it as False.
if color_mode:
    def g(s): return '\033[92m' + s + '\033[0m'
    def b(s): return '\033[94m' + s + '\033[0m'
else:
    def g(s): return s
    def b(s): return s

def pos_to_sym(i):
    return chr(ord('a')+i)

def sym_to_pos(i):
    return ord(i) - ord('a')
