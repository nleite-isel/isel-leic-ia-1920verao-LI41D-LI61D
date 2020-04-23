%
% Blocks world
%

s(Stacks, [Stack1, [Top1 | Stack2] | OtherStacks]) :- % Move Top1 to Stack2
	del( [Top1 | Stack1], Stacks, Stacks1), % Find first stack
	del( Stack2, Stacks1, OtherStacks). % Find second stack

del(X, [X | L], L).

del(X, [Y | L], [Y | L1]) :-
	del(X, L, L1).

% The goal condition for our example problem is:
goal(Situation) :-
	member([a,b,c], Situation).

% We will program search algorithms as a relation
%    solve(Start, Solution)
% where Start is the start node in the state space, and Solution is a path between Start and
% any goal node. 
%
%
% Basic implementation of the depth-first strategy.
%
/*
solve(N, [N]) :-
	goal(N).

solve(N, [N | Sol1]) :-
	s(N, N1),
	solve(N1, Sol1).
*/

%For our block manipulation problem, the corresponding call can be:
%?- solve([ [c,a,b], [],[]], Solution).

% * With solve predicate above, it enters in a cycle *
