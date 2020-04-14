
:- consult('path.pl').

depth_first_iterative_deepening( Node, Solution) :-
	path( Node, GoalNode, Solution),
	goal( GoalNode).


% ?- depth_first_iterative_deepening(a, Solution).
