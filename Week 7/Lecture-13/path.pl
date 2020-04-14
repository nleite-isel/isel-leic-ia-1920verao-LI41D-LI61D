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

path(Node, Node, [Node]). % Single node path

path(FirstNode, LastNode, [LastNode | Path]) :-
	path(FirstNode, OneButLast, Path), % Path up to one-but-last node
	s(OneButLast, LastNode),           % Last step
	\+ member(LastNode, Path).         % No cycle


% ?- path(a, Last, Path).

