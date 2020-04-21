%
% Solving 8 Queens with depth-first algorithm
%
/*
* From Book (needs to adapt depth-first predicate in order for noattack 
to work)

s(Queens, [Queen | Queens]) :-
	member(Queen, [1,2,3,4,5,6,7,8]), % Place Queen into any row
	noattack(Queen, Queens).

Adaptation is made with recourse to auxiliary predicates 
(e.g., template predicate) below:

*/

template( [8/Y8]).
template( [7/Y7,8/Y8]).
template( [6/Y6,7/Y7,8/Y8]).
template( [5/Y5,6/Y6,7/Y7,8/Y8]).
template( [4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).
template( [3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).
template( [2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).
template( [1/Y1,2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).

% Predicate s(S1, S2) which is equivalent to Successor(S1, S2)
% S1 - State *before* successor operator is applied
% S2 - State *after* successor operator is applied
s(Queens, [X/Y | Queens]) :-
	member(Y, [1,2,3,4,5,6,7,8]), % Place Queen into any row
	noattack(X/Y, Queens).


% noattack predicate
noattack(_, []).          % Nothing to attack

noattack(X/Y, [X1/Y1 | Others]) :-
	Y  =\= Y1,            % Different Y-coordinates
	Y1 - Y =\= X1 - X,    % Different upward diagonals
	Y1 - Y =\= X - X1,    % Different downward diagonals
	noattack(X/Y, Others).


% A solution template
%template([1/Y1, 2/Y2, 3/Y3, 4/Y4, 5/Y5, 6/Y6, 7/Y7, 8/Y8]).

%goal( [_,_,_,_,_,_,_,_]). % Position with 8 queens

goal( [1/Y1, 2/Y2, 3/Y3, 4/Y4, 5/Y5, 6/Y6, 7/Y7, 8/Y8]). % Position with 8 queens


/*
%///////////////////////////////////////////////////////
%
% A depth-first search program that avoids cycling.
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
	template(Node1), %%%%%%%%%% Added %%%%%%%%%%%%%%%%%
	s(Node, Node1),
	\+ member(Node1, Path),           % Prevent a cycle
	depthfirst([Node | Path], Node1, Sol).

%///////////////////////////////////////////////////////
*/


%
% Query
%
% From Book

%?- solve([], Solution). 






















