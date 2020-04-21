:- consult('blocks.pl').


%
% An implementation of breadth-first search.
%

% solve( Start, Solution):
% Solution is a path (in reverse order) from Start to a goal
solve( Start, Solution) :-
	breadthfirst( [ [Start] ], Solution).

% breadthfirst( [ Path1, Path2, ...], Solution):
% Solution is an extension to a goal of one of paths
breadthfirst( [ [Node | Path] | _], [Node | Path]) :-
	goal(Node).

breadthfirst( [Path | Paths], Solution) :-
	extend( Path, NewPaths),
	append( Paths, NewPaths, Paths1),
	breadthfirst( Paths1, Solution).
	
extend( [Node | Path], NewPaths) :-
	findall( [NewNode, Node | Path],
			 (s(Node, NewNode), \+ member(NewNode, [Node | Path])),
			 NewPaths).



%For our block manipulation problem, the corresponding call can be:
%?- solve([ [c,a,b], [],[]], Solution).

/*

Solution = [[[], [a, b, c], []], [[], [b, c], [a]], ... ]
*/
