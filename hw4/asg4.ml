(*
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
* Assignment 4
* Name : Chao Yu
* Student ID : 1155053722
* Email Addr : ychao5@cse.cuhk.edu.hk
*)

datatype suit = Clubs | Diamonds | Hearts | Spades;
datatype pattern = Nothing | Pair | Two_Pairs | Three_of_a_Kind | Full_House | Four_of_a_Kind;

(* Q1 *)
fun check_flush ([(s1, _), (s2, _), (s3, _), (s4, _), (s5, _)] : (suit * int) list) = 
    if s1 = s2 andalso s2 = s3 andalso s3 = s4 andalso s4 = s5 then true : bool
    else false
| check_flush err = raise Fail "Input incorrect!";


(* Q2 *)
fun compare_flush ([] : (suit * int) list, [] : (suit * int) list) = "This is a tie" : string
| compare_flush (x::li1, y::li2) =
    if #2 x > #2 y then "Hand 1 wins"
    else if #2 x < #2 y then "Hand 2 wins"
    else compare_flush(li1, li2)
| compare_flush err = raise Fail "Input incorrect!";


(* Q3 *)
fun check_straight ([(_, 13), (_, 12), (_, 11), (_, 10), (_, 1)] : (suit * int) list) = true : bool
| check_straight [(_, n1), (_, n2), (_, n3), (_, n4), (_, n5)] =
    if n1 = n2+1 andalso n2 = n3+1 andalso n3 = n4+1 andalso n4 = n5+1 then true
    else false
| check_straight err = raise Fail "Input incorrect!";


(* Q4 *)
fun compare_straight ([(_, 13), (_, 12), (_, 11), (_, 10), (_, 1)] : (suit * int) list,
                      [(_, 13), (_, 12), (_, 11), (_, 10), (_, 1)] : (suit * int) list) = "This is a tie" : string
| compare_straight ([(_, 13), (_, 12), (_, 11), (_, 10), (_, 1)], x) = "Hand 1 wins"
| compare_straight (x, [(_, 13), (_, 12), (_, 11), (_, 10), (_, 1)]) = "Hand 2 wins"
| compare_straight ([], []) = "This is a tie"
| compare_straight (x::li1, y::li2) =
    if #2 x > #2 y then "Hand 1 wins"
    else if #2 x < #2 y then "Hand 2 wins"
    else compare_straight(li1, li2)
| compare_straight err = raise Fail "Input incorrect!";


(* Q5 *)
(* Return (Nothing, []) if it is not four of a kind, else return the organized four of a kind. *)
fun check_four_of_a_kind ([(_, n1), (_, n2), (_, n3), (_, n4), (_, n5)] : (suit * int) list) = 
    if n1 = n2 andalso n2 = n3 andalso n3 = n4 then (Four_of_a_Kind, [(n1, 4), (n5, 1)]) : (pattern * ((int * int) list))
    else if n2 = n3 andalso n3 = n4 andalso n4 = n5 then (Four_of_a_Kind, [(n2, 4), (n1, 1)])
    else (Nothing, [])
| check_four_of_a_kind err = raise Fail "Input incorrect!";

(* Return (Nothing, []) if it is not a full house, else return the organized full house.
   The input should be checked for Four of a Kind first. *)
fun check_full_house ([(_, n1), (_, n2), (_, n3), (_, n4), (_, n5)] : (suit * int) list) =
    if n1 = n2 andalso n2 = n3 andalso n4 = n5 then (Full_House, [(n1, 3), (n4, 2)]) : (pattern * ((int * int) list))
    else if n1 = n2 andalso n3 = n4 andalso n4 = n5 then (Full_House, [(n3, 3), (n1, 2)])
    else (Nothing, [])
| check_full_house err = raise Fail "Input incorrect!";

(* Return (Nothing, []) if it is not a three of a kind, else return the organized three of a kind.
   The input should be checked for Four of a Kind and Full House first. *)
fun check_three_of_a_kind ([(_, n1), (_, n2), (_, n3), (_, n4), (_, n5)] : (suit * int) list) =
    if n1 = n2 andalso n2 = n3 then (Three_of_a_Kind, [(n1, 3), (n4, 1), (n5, 1)]) : (pattern * ((int * int) list))
    else if n2 = n3 andalso n3 = n4 then (Three_of_a_Kind, [(n2, 3), (n1, 1), (n5, 1)])
    else if n3 = n4 andalso n4 = n5 then (Three_of_a_Kind, [(n3, 3), (n1, 1), (n2, 1)])
    else (Nothing, [])
| check_three_of_a_kind err = raise Fail "Input incorrect!";

(* Return (Nothing, []) if it is not a two pair, else return the organized two pair.
   The input should be checked for Four of a Kind, Full House, and Three of a Kind first. *)
fun check_two_pairs ([(_, n1), (_, n2), (_, n3), (_, n4), (_, n5)] : (suit * int) list) =
    if n1 = n2 andalso n3 = n4 then (Two_Pairs, [(n1, 2), (n3, 2), (n5, 1)]) : (pattern * ((int * int) list))
    else if n2 = n3 andalso n4 = n5 then (Two_Pairs, [(n2, 2), (n4, 2), (n1, 1)])
    else if n1 = n2 andalso n4 = n5 then (Two_Pairs, [(n1, 2), (n4, 2), (n3, 1)])
    else (Nothing, [])
| check_two_pairs err = raise Fail "Input incorrect!";

(* Return organized "nothing" if it is not a pair, else return the organized pair.
   The input should be checked for Four of a Kind, Full House, Three of a Kind, and Two Pair first. *)
fun check_pair ([(_, n1), (_, n2), (_, n3), (_, n4), (_, n5)] : (suit * int) list) =
    if n1 = n2 then (Pair, [(n1, 2), (n3, 1), (n4, 1), (n5, 1)]) : (pattern * ((int * int) list))
    else if n2 = n3 then (Pair, [(n2, 2), (n1, 1), (n4, 1), (n5, 1)])
    else if n3 = n4 then (Pair, [(n3, 2), (n1, 1), (n2, 1), (n5, 1)])
    else if n4 = n5 then (Pair, [(n4, 2), (n1, 1), (n2, 1), (n3, 1)])
    else (Nothing, [(n1, 1), (n2, 1), (n3, 1), (n4, 1), (n5, 1)])
| check_pair err = raise Fail "Input incorrect!";

(* main function for Q5*)
fun count_patterns ( li : (suit * int) list) =
    let val foak = check_four_of_a_kind li
        val fh = check_full_house li
        val toak = check_three_of_a_kind li
        val tp = check_two_pairs li
        val p = check_pair li
    in
        if #1 foak <> Nothing then foak : (pattern * ((int * int) list))
        else if #1 fh <> Nothing then fh
        else if #1 toak <> Nothing then toak
        else if #1 tp <> Nothing then tp
        else if #1 p <> Nothing then p
        else p
    end;


(* Q6 *)
(* Rank the patterns. *)
fun pattern_rank (pat : pattern) =
    if pat = Four_of_a_Kind then 5 : int
    else if pat = Full_House then 4
    else if pat = Three_of_a_Kind then 3
    else if pat = Two_Pairs then 2
    else if pat = Pair then 1
    else 0;

(* Compare the two hands if they have the same patterns. *)
fun compare_num ([] : (int * int) list, [] : (int * int) list) = "This is a tie" : string
| compare_num (x::li1, y::li2) =
    if #1 x > #1 y then "Hand 1 wins"
    else if #1 x < #1 y then "Hand 2 wins"
    else compare_num(li1, li2)
| compare_num err = raise Fail "Input incorrect!";

(* main function for Q6 *)
fun compare_count (li1 : (suit * int) list, li2 : (suit * int) list) =
    let val pat1 = count_patterns li1
        val pat2 = count_patterns li2
    in
        let val rk1 = pattern_rank (#1 pat1)
            val rk2 = pattern_rank (#1 pat2)
            val hand1 = #2 pat1
            val hand2 = #2 pat2
        in
            if rk1 > rk2 then "Hand 1 wins" : string
            else if rk1 < rk2 then "Hand 2 wins"
            else compare_num(hand1, hand2)
        end        
    end;
