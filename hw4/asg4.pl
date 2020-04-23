% CSCI3180 Principles of Programming Languages
%
% --- Declaration ---
%
% I declare that the assignment here submitted is original except for source
% material explicitly acknowledged. I also acknowledge that I am aware of
% University policy and regulations on honesty in academic work, and of the
% disciplinary guidelines and procedures applicable to breaches of such policy
% and regulations, as contained in the website
% http://www.cuhk.edu.hk/policy/academichonesty/
%
% Assignment 4
% Name : Chao Yu
% Student ID : 1155053722
% Email Addr : ychao5@cse.cuhk.edu.hk

% Q1.
% (a)
element_last(X, [X]).
element_last(X, [_|Tail]) :- element_last(X, Tail).

% (b)
element_n(X, [X|_], s(0)).
element_n(X, [_|Tail], s(N)) :- element_n(X, Tail, N).

% (c)
remove_n(X, [X|Tail], s(0), Tail).
remove_n(X, [Head|Tail], s(N), [Head|Rem]) :- remove_n(X, Tail, N, Rem).

% (d)
% remove_n(a, List, s(s(0)), [c,b,d,e]).

% (e)
insert_n(X, Tail, s(0), [X|Tail]).
insert_n(X, [Head|Tail], s(N), [Head|Inserted]) :- insert_n(X, Tail, N, Inserted).

% (f)
repeat_three([X], [X,X,X]).
repeat_three([H|L1], [H|[H|[H|L2]]]) :- repeat_three(L1, L2).

% (g)
% repeat_three(L, [i,i,i,m,m,m,n,n,n]).


% Q2.
% (a)
mt(a, [
    mt(b, [
        mt(e, []),
        mt(f, [])
    ]),
    mt(c, []),
    mt(d, [
        mt(g, [])
    ])
]).

% (b)
is_tree(mt(_, [])).
is_tree(mt(X, [Tree|Children])) :- is_tree(Tree), is_tree(mt(X, Children)).

% (c)
sum(0, X, X).
sum(X, 0, X).
sum(s(X), Y, s(Z)) :- sum(X, Y, Z).
sum(X, s(Y), s(Z)) :- sum(X, Y, Z).

num_node(mt(_, []), s(0)).
num_node(mt(X, [Tree|Children]), S) :-
    num_node(Tree, M), num_node(mt(X, Children), N), sum(M, N, S).

% (d)
sum_length(mt(_, []), 0).
sum_length(mt(_, [Tree|Children]), Length) :-
    num_node(Tree, N),
    sum_length(mt(_, Children), OriginalLength),
    sum_length(Tree, TreeLength),
    sum(TreeLength, N, Temp),
    sum(Temp, OriginalLength, Length).
