/*
Figure 18.1 Three robots a, b and c moving in a 3 by 2 grid. The cells of the grid are
numbered 1, ..., 6. A robot may move into a horizontally or vertically adjacent
unoccupied cell, e.g. go(a, 1, 4).
*/

:- consult('pop.pl').


% A planning domain: robots a, b and c move in grid 3 by 2
%

:- op(100, fx, ~).     % Operator for negated conditions

% Precondition of action: robot R goes from cell A to B
%
can(go(R, A, B), [at(R, A), clear(B)]) :-
	robot(R), adjacent(A,B).

% Effects of action go(Robot, CellA, CellB):
% After the action at(Robot, CellB) and clear(CellA) become true,
% and at(Robot, CellA) and clear(CellB) become false
%
effects(go(R, A, B), [at(R, B), clear(A), ~at(R, A), ~clear(B)]).

robot(a). robot(b). robot(c).

adjacent(A, B) :-        % Cells A and B are adjacent in the grid
	n(A, B); n(B, A).

% n(A, B): Cells A and B are "ordered" neighbours
%
n(1, 2). n(2, 3). n(4, 5). n(5, 6). n(1, 4). n(2, 5). n(3, 6).

% inconsistent(G1, G2): goals G1 and G2 inconsistent
%
inconsistent(G, ~G).  % Negated goals always inconsistent

inconsistent(~G, G).

inconsistent(at(R, C1), at(R, C2)) :-
	C1 \== C2.      % Robot cannot be at different places at the same time

inconsistent(at(_, C), clear(C)). % A cell cannot be both clear and occupied at a time

inconsistent(clear(C), at(_, C)).

inconsistent(at(R1, C), at(R2,C)) :- % Two robots cannot be in the same cell at a time
	R1 \== R2.


stateO([at(a, 1), at(b, 2), at(c, 3), clear(4), clear(5), clear(6)]). % The state of Fig. 18.1


/*

?- stateO(S), plan(S, [at(a, 3)], P), show_pop(P).

Actions = [1:go(b, 2, 5), 1:go(c, 3, 6), 2:go(a, 1, 2), 3:go(a, 2, 3)]
Actions = [1:go(b, 2, 5), 2:go(a, 1, 2), 2:go(c, 3, 6), 3:go(a, 2, 3)]

?- stateO(S), plan(S, [at(a, 3), at(c, 1)], P), show_pop(P).

Actions = [1:go(c, 3, 6), 2:go(c, 6, 5), 3:go(c, 5, 4), 
4:go(b, 2, 5), 5:go(a, 1, 2), 6:go(a, 2, 3), 6:go(c, 4, 1)]


*/































