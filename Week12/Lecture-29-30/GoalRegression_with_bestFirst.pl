/*
Figure 17.7 A state-space definition for means-ends planning based on goal regression.
Predicates satisfied, achieves, preserves, regress, addnew and delete_all are as defined in
Figure 17.6.
*/

% State-space representation of means-ends planning with goal regression

:- consult('means_ends_planner_GoalRegression.pl').
:- consult('astar.pl').


% xfy - right associativity - see p. 46 of 'acet prolog.pdf', Prof. Pita
:- op(300, xfy, ->).


s(Goals -> NextAction, NewGoals -> Action, 1) :-    % All costs are 1
	member(Goal, Goals),
	achieves(Action, Goal),
	can(Action, Condition),
	preserves(Action, Goals),
	regress(Goals, Action, NewGoals).


goal(Goals -> Action) :-
	start(State),                          % User-defined initial situation
	satisfied(State, Goals).               % Goals true in initial situation


h(Goals -> Action, H) :-                   % Heuristic estimate
	start(State),
	delete_all(Goals, State, Unsatisfied), % Unsatisfied goals
	length(Unsatisfied, H).                % Number of unsatisfied goals

/*
To solve the task of Figure 17.1 by our means-ends best-first planner, 
we can now call the best-first procedure by:

?- bestfirst( [ on(a, b), on(b, c)] -> stop, Plan).

The null action stop is added here because in our representation each 
goal-list must be followed, at least syntactically, by an action.

Response:

Plan = [
[ clear( 2), on( c, a), clear( c), on( b, 3), clear( b), on( a, 1)] -> move( c, a, 2),
[ clear( c), on( b, 3), clear( a), clear( b), on( a, 1)] -> move( b, 3, c),
[ clear( a), clear( b), on( a, 1), on( b, c)] -> move( a, 1, b),
[ on( a, b), on( b, c)] -> stop]


*/






















