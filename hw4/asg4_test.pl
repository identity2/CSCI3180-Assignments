% Use this file as queries, not facts.

% Test cases for Q1 (a).
element_last(X, [a, b, c, d, e]).  % X = e
element_last(a, [a]). % yes

% Test cases for Q1 (b).
element_n(c, [a,b,c,d,e], X). % X = s(s(s(0)))
element_n(X, [a,b,c,d,e], s(s(s(s(s(0)))))). % X = e

% Test cases for Q1 (c).
remove_n(X, [a,b,c,d,e], s(s(s(0))), L2). % X = c, L2 = [a,b,d,e]
remove_n(a, L1, s(s(0)), [b,c,w,d,e]). % L1 = [b,a,c,w,d,e]

% Test cases for Q1 (d).
remove_n(a, List, s(s(0)), [c,b,d,e]). % List = [c,a,b,d,e]

% Test cases for Q1 (e).
insert_n(h, [a,b,c], s(s(0)), L2). % L2 = [a,h,b,c]
insert_n(a, L1, s(0), [a,b,c]). % L1 = [b,c]

% Test cases for Q1 (f).
repeat_three(L1, [a,a,a,b,b,b,c,c,c]). % L1 = [a,b,c]
repeat_three([a,b,c], L2). % L2 = [a,a,a,b,b,b,c,c,c]

% Test cases for Q1 (g).
repeat_three(L, [i,i,i,m,m,m,n,n,n]). % L = [i,m,n]

% Test cases for Q2 (a).
mt(a, [mt(b, [mt(e, []),mt(f, [])]),mt(c, []),mt(d, [mt(g, [])])]). % yes

% Test cases for Q2 (b).
is_tree(mt(a, [mt(b, []), c])). % no
is_tree(mt(a, [mt(b, [mt(e, []),mt(f, [])]),mt(c, []),mt(d, [mt(g, [])])])). % yes
is_tree(mt(b, [mt(z, [mt(a, []), mt(c, [mt(f, []), mt(z, [])]), mt(b, [mt(c, [])])])])). % yes

% Test cases for Q2 (c).
sum(s(0), Y, s(s(s(s(0))))). % Y = 3 (in terms of s(0), same for the test cases below)
sum(s(s(0)), s(s(s(s(0)))), Z). % Z = 6
sum(X, s(0), s(s(s(s(0))))). % X = 3

num_node(mt(a, [mt(b, [mt(e, []),mt(f, [])]),mt(c, []),mt(d, [mt(g, [])])]), N). % N = 7
num_node(mt(b, [mt(z, [mt(a, []), mt(c, [mt(f, []), mt(z, [])]), mt(b, [mt(c, [mt(b, [])])])])]), N). % N = 9
num_node(mt(c, [mt(a, []), mt(b, []), mt(c, [])]), N). % N = 4

% Test cases for Q2 (d).
sum_length(mt(a, [mt(b, [mt(e, []),mt(f, [])]),mt(c, []),mt(d, [mt(g, [])])]), N). % N = 9
sum_length(mt(a, [mt(b, [mt(d, [mt(e, []), mt(f, [])])]), mt(c, [])]), N). % N = 10
sum_length(mt(a, [mt(b, []), mt(c, []), mt(d, [])]), N). % N = 3
sum_length(mt(a, [mt(b, [mt(c, [mt(d, [mt(e, [])])])])]), N). % N = 10
