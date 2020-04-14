%
% Blocks world
%

/*
%
% s( X, Y) - State Y is a successor of state X
%
% Move Top1 to Stack2
s(Stacks, [Stack1, [Top1 | Stack2] | OtherStacks]) :- 
	del( [Top1 | Stack1], Stacks, Stacks1), % Find first stack
	del( Stack2, Stacks1, OtherStacks). % Find second stack

%?- s( [[c,a,b], [],[]], Y).

% Find first stack
Stacks = [[c,a,b], [],[]]	

del( [Top1 | Stack1], Stacks, Stacks1):

[Top1 | Stack1] = [c,a,b] -> Top1 = c, Stack1 = [a,b]
Stacks1 = [ [],[]]	

% Find second stack
del( Stack2, Stacks1, OtherStacks).

Stack2 = ?
Stacks1 = [ [],[]]	
del( Stack2, Stacks1, OtherStacks) 
   -> Stack2 = [], OtherStacks = [[]]
dado que: 
del([], [[],[]], [[]]) 

Entao:
  [Stack1, [Top1 | Stack2] | OtherStacks] 
fica:
[ [a,b], [c | []], [[]] ]
*/

%
% s( X, Y) - State Y is a successor of state X
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
% where Start is the start node in the state space, 
% and Solution is a path between Start and
% any goal node. 
%

% Fazer debug com spy(s/2).
%?- s( [[c,a,b], [],[]], Y).
























