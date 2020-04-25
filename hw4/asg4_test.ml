(* Test cases for Q1: *)
check_flush [(Clubs, 1), (Clubs, 2), (Clubs, 3), (Clubs, 4), (Clubs, 5)]; (* true *)
check_flush [(Hearts, 1), (Clubs, 2), (Clubs, 3), (Clubs, 4), (Clubs, 5)]; (* false *)

(* Test cases for Q2: *)
compare_flush ([(Clubs, 13), (Hearts, 9), (Hearts, 6), (Diamonds, 3), (Clubs, 1)],
               [(Hearts, 13), (Clubs, 9), (Hearts, 6), (Clubs, 1), (Hearts, 1)]); (* Hand 1 wins *)
compare_flush ([(Clubs, 9), (Clubs, 9), (Hearts, 6), (Diamonds, 3), (Clubs, 1)],
               [(Diamonds, 13), (Clubs, 9), (Clubs, 6), (Clubs, 1), (Diamonds, 1)]); (* Hand 2 wins *)
compare_flush ([(Diamonds, 5), (Hearts, 4), (Clubs, 4), (Hearts, 3), (Spades, 1)],
               [(Clubs, 5), (Hearts, 4), (Spades, 4), (Spades, 3), (Hearts, 1)]); (* This is a tie *)

(* Test cases for Q3: *)
check_straight [(Diamonds, 13), (Clubs, 12), (Hearts, 11), (Spades, 10), (Spades, 1)]; (* true *)
check_straight [(Diamonds, 6), (Diamonds, 5), (Hearts, 4), (Hearts, 3), (Clubs, 2)]; (* true *)
check_straight [(Clubs, 1), (Diamonds, 10), (Clubs, 7), (Hearts, 5), (Spades, 2)]; (* false *)
check_straight [(Diamonds, 13), (Diamonds, 12), (Hearts, 11), (Hearts, 10), (Clubs, 2)]; (* false *)

(* Test cases for Q4: *)
compare_straight ([(Diamonds, 13), (Hearts, 12), (Clubs, 11), (Clubs, 10), (Spades, 1)],
                  [(Spades, 13), (Spades, 12), (Clubs, 11), (Diamonds, 10), (Hearts, 1)]); (* This is a tie *)
compare_straight ([(Diamonds, 13), (Hearts, 12), (Clubs, 11), (Clubs, 10), (Spades, 1)],
                  [(Spades, 5), (Spades, 4), (Clubs, 3), (Diamonds, 2), (Hearts, 1)]); (* Hand 1 wins *)
compare_straight ([(Diamonds, 8), (Hearts, 7), (Clubs, 6), (Clubs, 5), (Spades, 4)],
                  [(Spades, 13), (Spades, 12), (Clubs, 11), (Diamonds, 10), (Hearts, 1)]); (* Hand 2 wins *)
compare_straight ([(Diamonds, 13), (Hearts, 12), (Clubs, 11), (Clubs, 10), (Spades, 9)],
                  [(Spades, 12), (Spades, 11), (Clubs, 10), (Diamonds, 9), (Hearts, 8)]); (* Hand 1 wins *)
compare_straight ([(Diamonds, 6), (Hearts, 5), (Clubs, 4), (Clubs, 3), (Spades, 2)],
                  [(Spades, 10), (Spades, 9), (Clubs, 8), (Diamonds, 7), (Hearts, 6)]); (* Hand 2 wins *)
compare_straight ([(Diamonds, 7), (Hearts, 6), (Clubs, 5), (Clubs, 4), (Spades, 3)],
                  [(Spades, 7), (Spades, 6), (Clubs, 5), (Diamonds, 4), (Hearts, 3)]); (* This is a tie *)

(* Test cases for Q5 *)
check_four_of_a_kind ([(Spades, 4), (Hearts, 4), (Clubs, 4), (Diamonds, 4), (Spades, 1)]); (* (Four_of_a_Kind, [(4,4), (1,1)]) *)
check_four_of_a_kind ([(Spades, 13), (Hearts, 5), (Clubs, 5), (Diamonds, 5), (Spades, 5)]); (* (Four_of_a_Kind, [(5,4), (13,1)]) *)
check_four_of_a_kind ([(Spades, 13), (Hearts, 11), (Clubs, 10), (Diamonds, 6), (Spades, 1)]); (* (Nothing, []) *)
check_four_of_a_kind ([(Spades, 13), (Hearts, 13), (Clubs, 13), (Diamonds, 6), (Spades, 6)]); (* (Nothing, []) *)

check_full_house ([(Spades, 2), (Hearts, 2), (Clubs, 2), (Diamonds, 1), (Spades, 1)]); (* (Full_House, [(2, 3), (1, 2)]) *)
check_full_house ([(Spades, 13), (Hearts, 13), (Clubs, 6), (Diamonds, 6), (Spades, 6)]); (* (Full_House, [(6, 3), (13, 2)]) *)
check_full_house ([(Spades, 13), (Hearts, 13), (Clubs, 12), (Diamonds, 12), (Spades, 6)]); (* (Nothing, []) *)
check_full_house ([(Spades, 13), (Hearts, 11), (Clubs, 7), (Diamonds, 8), (Spades, 4)]); (* (Nothing, []) *)

check_three_of_a_kind ([(Spades, 13), (Hearts, 13), (Clubs, 13), (Diamonds, 8), (Spades, 4)]); (* (Three_of_a_kind, [(13, 3), (8, 1), (4, 1)]) *)
check_three_of_a_kind ([(Spades, 13), (Hearts, 8), (Clubs, 8), (Diamonds, 8), (Spades, 4)]); (* (Three_of_a_kind, [(8, 3), (13, 1), (4, 1)]) *)
check_three_of_a_kind ([(Spades, 12), (Hearts, 10), (Clubs, 3), (Diamonds, 3), (Spades, 3)]); (* (Three_of_a_kind, [(3, 3), (12, 1), (10, 1)]) *)
check_three_of_a_kind ([(Spades, 13), (Hearts, 10), (Clubs, 6), (Diamonds, 5), (Spades, 4)]); (* (Nothing, []) *)
check_three_of_a_kind ([(Spades, 10), (Hearts, 10), (Clubs, 6), (Diamonds, 6), (Spades, 4)]); (* (Nothing, []) *)

check_two_pairs ([(Spades, 10), (Hearts, 10), (Clubs, 6), (Diamonds, 6), (Spades, 4)]); (* (Two_Pairs, [(10, 2), (6, 2), (4, 1)]) *)
check_two_pairs ([(Spades, 13), (Hearts, 6), (Clubs, 6), (Diamonds, 4), (Spades, 4)]); (* (Two_Pairs, [(6, 2), (4, 2), (13, 1)]) *)
check_two_pairs ([(Spades, 11), (Hearts, 11), (Clubs, 8), (Diamonds, 2), (Spades, 2)]); (* (Two_Pairs, [(11, 2), (2, 2), (8, 1)]) *)
check_two_pairs ([(Spades, 13), (Hearts, 12), (Clubs, 8), (Diamonds, 2), (Spades, 2)]); (* (Nothing, []) *)
check_two_pairs ([(Spades, 11), (Hearts, 8), (Clubs, 8), (Diamonds, 2), (Spades, 1)]); (* (Nothing, []) *)

check_pair ([(Spades, 10), (Hearts, 10), (Clubs, 8), (Diamonds, 6), (Spades, 4)]); (* (Pair, [(10, 2), (8, 1), (6, 1), (4, 1)]) *)
check_pair ([(Spades, 10), (Hearts, 8), (Clubs, 8), (Diamonds, 6), (Spades, 4)]); (* (Pair, [(8, 2), (10, 1), (6, 1), (4, 1)]) *)
check_pair ([(Spades, 10), (Hearts, 8), (Clubs, 6), (Diamonds, 6), (Spades, 4)]); (* (Pair, [(6, 2), (10, 1), (8, 1), (4, 1)]) *)
check_pair ([(Spades, 10), (Hearts, 8), (Clubs, 6), (Diamonds, 4), (Spades, 4)]); (* (Pair, [(4, 2), (10, 1), (8, 1), (6, 1)]) *)
check_pair ([(Spades, 10), (Hearts, 8), (Clubs, 6), (Diamonds, 4), (Spades, 2)]); (* (Nothing, []) *)

count_patterns [(Clubs, 13), (Clubs, 11), (Spades, 7), (Spades, 3), (Hearts, 2)]; (* (Nothing, [(13,1),(11,1),(7,1),(3,1),(2,1)]) *)
count_patterns [(Spades, 11), (Spades, 9), (Hearts, 8), (Diamonds, 8), (Diamonds, 3)]; (* (Pair, [(8,2),(11,1),(9,1),(3,1)]) *)
count_patterns [(Clubs, 13), (Spades, 13), (Hearts, 6), (Spades, 1), (Diamonds, 1)]; (* (Two_Pairs, [(13,2),(1,2),(6,1)]) *)
count_patterns [(Clubs, 10), (Clubs, 9), (Hearts, 9), (Spades, 9), (Spades, 3)]; (* (Three_of_a_Kind, [(9,3),(10,1),(3,1)]) *)
count_patterns [(Diamonds, 6), (Clubs, 6), (Spades, 6), (Spades, 4), (Diamonds, 4)]; (* (Full House, [(6, 3), (4, 2)]) *)
count_patterns [(Diamonds, 11), (Spades, 11), (Clubs, 11), (Hearts, 11), (Hearts, 10)]; (* (Four of a Kind, [(11, 4), (10, 1)]) *)

(* Test cases for Q6 *)
compare_count ([(Clubs, 13), (Clubs, 11), (Spades, 7), (Spades, 3), (Hearts, 2)],
               [(Spades, 11), (Spades, 9), (Hearts, 8), (Diamonds, 8), (Diamonds, 3)]); (* Hand 2 wins *)

compare_count ([(Clubs, 13), (Clubs, 13), (Spades, 13), (Spades, 13), (Hearts, 2)],
               [(Spades, 13), (Spades, 13), (Hearts, 13), (Diamonds, 13), (Diamonds, 2)]); (* This is a tie *)

compare_count ([(Clubs, 13), (Clubs, 11), (Spades, 11), (Spades, 11), (Hearts, 2)],
               [(Spades, 11), (Spades, 9), (Hearts, 8), (Diamonds, 8), (Diamonds, 3)]); (* Hand 1 wins *)

compare_count ([(Clubs, 13), (Clubs, 13), (Spades, 12), (Spades, 12), (Hearts, 2)],
               [(Spades, 11), (Spades, 2), (Hearts, 1), (Diamonds, 1), (Diamonds, 1)]); (* Hand 2 wins *)

compare_count ([(Clubs, 8), (Clubs, 6), (Spades, 6), (Spades, 3), (Hearts, 2)],
               [(Spades, 7), (Spades, 6), (Hearts, 6), (Diamonds, 2), (Diamonds, 2)]); (* Hand 2 wins *)

compare_count ([(Clubs, 12), (Clubs, 10), (Spades, 6), (Spades, 3), (Hearts, 2)],
               [(Spades, 12), (Spades, 6), (Hearts, 3), (Diamonds, 2), (Diamonds, 1)]); (* Hand 1 wins *)

compare_count ([(Clubs, 8), (Clubs, 6), (Spades, 4), (Spades, 3), (Hearts, 2)],
               [(Spades, 8), (Spades, 6), (Hearts, 4), (Diamonds, 3), (Diamonds, 2)]); (* This is a tie *)
