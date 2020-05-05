
%
% Program 20.4 Hill climbing framework for problem solving
%

% solve_hill_climb(State, History, Moves):
%  Moves is the sequence of moves to reach a
%  desired final state from the current State,
%  where History is a list of the states visited previously.
%
solve_hill_climb(State, History, []) :-
	final_state(State).
	
solve_hill_climb(State, History, [Move | Moves]) :-
	hill_climb(State, Move),
	!, % Pure Hill-climbing (no backtracking). 
	% Comment the "cut" if search with Hill Climbing move (but with backtracking)
	update(State, Move, State1),
	legal(State1),
	\+ member(State1, History),	
	solve_hill_climb(State1, [State1 | History], Moves).


hill_climb(State, Move) :- 
	findall(M, move(State, M), Moves),
	evaluate_and_order(Moves, State, [], MVs),
	member( (Move, Value), MVs).
	

% evaluate_and_order(Moves, State, SoFar, OrderedMVs):
%  All the Moves from the current State
%  are evaluated and ordered as OrderedMVs.
%  SoFar is an accumulator for partial computations.
%
evaluate_and_order([Move | Moves], State, MVs, OrderedMVs) :-
	update(State, Move, State1),
	value(State1, Value),
	insert((Move, Value), MVs, MVs1),
	evaluate_and_order(Moves, State, MVs1, OrderedMVs).

evaluate_and_order([], State, MVs, MVs).

insert(MV, [], [MV]).

insert( (M, V), [(M1, V1) | MVs], [(M, V), (M1, V1) | MVs] ) :-
	V >= V1.

insert( (M, V), [(M1, V1) | MVs], [(M1, V1) | MVs1]) :-
	V < V1, insert((M, V), MVs, MVs1).


%
% Program 20.5 Test data
%
%
% Initial state of search - Node 'a'
initial_state(tree, a).


% Final state - Node 'j'
final_state(j).

% Move a -> b
move(a, b). 

% Move a -> c
move(a, c). 

% Move a -> d
move(a, d). 

% Move a -> e
move(a, e). 

% Move c -> f
move(c, f). 

% Move c -> g
move(c, g). 

% Move d -> j
move(d, j). 

% Move e -> k
move(e, k). 

% Move f -> h
move(f, h). 

% Move f -> i
move(f, i). 


% Cost of 'a'
value(a, 0).

% Move costs
value(b, 1).
value(c, 5).

value(d, 7).
%value(d, 1). % It doesn't find goal node in Pure Hill-climbing

value(e, 2).
value(f, 4).
value(g, 6).
value(j, 9).
value(k, 1).
value(h, 3).
value(i, 2).



%
% Update
%
update(State, Move, State1) :-
	move(State, Move),
	State1 = Move.
	
	
%
% legal - In this problem, a state is legal
% if there exists a move to it.
%	
legal(X) :- 
	value(X, _).


%
% Testing the framework
%

test_hill_climb(Problem, Moves) :-
	initial_state(Problem, State),
	solve_hill_climb(State, [State], Moves).


% Goal
% ?- spy(test_hill_climb).
% ?- test_hill_climb(Problem, Moves).








































