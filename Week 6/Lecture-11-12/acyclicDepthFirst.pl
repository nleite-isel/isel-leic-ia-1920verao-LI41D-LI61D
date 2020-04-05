
:- consult('blocks.pl').


%
% A depth-first search program that avoids cycling 
% Fig. 11.7
%
% solve(Node, Solution):
% Solution is an acyclic path (in reverse order) between Node and a goal
solve(Node, Solution) :-
	depthfirst([], Node, Solution).

% depthfirst(Path, Node, Solution):
%   extending the path [Node | Path] to a goal gives Solution
depthfirst(Path, Node, [Node | Path]) :-
	goal(Node).

depthfirst(Path, Node, Sol) :-
	s(Node, Node1),
	\+ member(Node1, Path),           % Prevent a cycle
	depthfirst([Node | Path], Node1, Sol).

