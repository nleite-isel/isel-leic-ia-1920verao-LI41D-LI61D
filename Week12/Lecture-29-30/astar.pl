

%/////////////////////////////////////////////////////////////////////////
%
% An implementation of best-first (A*) search.
%

% bestfirst(Start, Solution): Solution is a path from Start to a goal
bestfirst(Start, Solution) :-
	expand([], l(Start, 0/0), 9999, _, yes, Solution). % Assume 9999 is > any f-value

% expand( Path, Tree, Bound, Treel, Solved, Solution):
% Path is path between start node of search and subtree Tree,
% Tree1 is Tree expanded within Bound,
% if goal found then Solution is solution path and Solved = yes

% Case 1: goal leaf-node, construct a solution path
%
expand(P, l(N, _), _, _, yes, [N | P]) :-
	goal(N).

% Case 2: leaf-node, f-value less than Bound
% Generate successors and expand them within Bound
%
expand(P, l(N, F/G), Bound, Tree1, Solved, Sol) :-
	F =< Bound,
	( bagof( M/C, ( s(N, M, C), \+ member(M, P)), Succ),
	!,                      % Node N has successors
	succlist( G, Succ, Ts), % Make subtrees Ts
	bestf( Ts, F1),         % f-value of best successor
	expand(P, t(N, F1/G, Ts), Bound, Tree1, Solved, Sol)
	;
	Solved = never           % N has no successors - dead end
  ).

% Case 3: non-leaf, f-value less than Bound
% Expand the most promising subtree; depending on
% results, procedure continue will decide how to proceed
%
expand( P, t(N, F/G, [T | Ts]), Bound, Tree1, Solved, Sol) :-
	F =< Bound,
	bestf(Ts, BF), Bound1 = min( Bound, BF), % min( Bound, BF, Bound1) does not work in SWI-Prolog
	expand([N | P], T, Bound1, T1, Solved1, Sol),
	continue(P, t(N, F/G, [T1 | Ts]), Bound, Tree1, Solved1, Solved, Sol).


% Case 4: non-leaf with empty subtrees
% This is a dead end which will never be solved
%
expand( _, t(_, _, []), _, _, never, _) :- !.

% Case 5: value greater than Bound
% Tree may not grow
%
expand( _, Tree, Bound, Tree, no, _) :-
	f( Tree, F), F > Bound.


% continue( Path, Tree, Bound, NewTree, SubtreeSolved, TreeSolved, Solution)
%
continue( _,_,_,_, yes, yes, Sol).

continue( P, t(N, F/G, [T1 | Ts]), Bound, Tree1, no, Solved, Sol) :-
	insert( T1, Ts, NTs),
	bestf( NTs, F1),
	expand( P, t(N, F1/G, NTs), Bound, Tree1, Solved, Sol).

continue( P, t(N, F/G, [_ | Ts]), Bound, Tree1, never, Solved, Sol) :-
	bestf( Ts, F1),
	expand( P, t(N, F1/G, Ts), Bound, Tree1, Solved, Sol).


% succlist( GO, [Node1/Cost1, ...], [l(BestNode, BestF/G), ...]):
%   make list of search leaves ordered by their f-values
%
succlist( _, [], []).

succlist( GO, [N/C | NCs], Ts) :-
	G is GO + C,
	h(N, H),     % Heuristic term h(N)
	F is G + H,
	succlist( GO, NCs, Ts1),
	insert( l(N, F/G), Ts1, Ts).


% Insert T into list of trees Ts preserving order with respect to f-values
%
insert( T, Ts, [T | Ts]) :-
	f( T, F), bestf( Ts, F1),
	F =< F1, !.

insert( T, [T1 | Ts], [T1 | Ts1]) :-
	insert( T, Ts, Ts1).

% Extract f-value
%
f( l(_, F/_), F).        % f-value of a leaf

f( t(_, F/_, _), F).     % f-value of a tree

bestf( [T | _], F) :-    % Best f-value of a list of trees
	f( T, F).

bestf( [], 9999).         % No trees: bad f-value

%/////////////////////////////////////////////////////////////


%
% Query
%
% Debug
%?- spy(bestfirst).

%?- bestfirst(s, Solution).




































