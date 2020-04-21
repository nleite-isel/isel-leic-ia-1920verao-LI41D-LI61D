:- consult('8queens.pl').


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
			 (template(NewNode), %%%%%%%%%% Added %%%%%%%%%%%%%%%%%
			 s(Node, NewNode), \+ member(NewNode, [Node | Path])),
			 NewPaths).


%
% Query
%
% From Book

/*
?- solve([], Solution). 
Solution = [[1/4, 2/2, 3/7, 4/3, 5/6, 6/8, 7/5, ... / ...], ....] 

Ver Fig. 4.9 da p. 105 do livro

*/
