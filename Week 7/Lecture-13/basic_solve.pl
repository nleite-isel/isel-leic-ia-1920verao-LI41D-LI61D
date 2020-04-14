%
% Manipulating paths (page 269)
%

% Fig. 11.4 graph (page 266)

s(a, b).
s(a, c).
s(b, d).
s(b, e).
s(d, h).
s(e, i).
s(e, j).
s(c, f).
s(c, g).
s(f, k).

goal(j).
goal(f).

% Basic implementation of the depth-first strategy.
%

basic_solve(N, [N]) :-
	goal(N).

basic_solve(N, [N | Sol1]) :-
	s(N, N1),
	basic_solve(N1, Sol1).

% ?- basic_solve(a, Path).

% For this example, it does not get lost in infinite branches
