
:- consult('planning_BlocksWorld_GoalRegression.pl').


%
% Figure 17.6 A planner based on goal regression. The planner performs an iterative
% deepening search.
%

% A means-ends planner with goal regression
% plan(State, Goals, Plan)
%
plan(State, Goals, []) :-
	satisfied(State, Goals).    % Goals true in State

plan(State, Goals, Plan) :-
	append(PrePlan, [Action], Plan),        % Divide plan achieving breadth-first effect
	select(State, Goals, Goal),             % Select a goal
	achieves(Action, Goal),
	can(Action, Condition),                 % Ensure Action contains no variables
	preserves(Action, Goals),               % Protect Goals
	regress(Goals, Action, RegressedGoals), % Regress Goals through Action
	plan(State, RegressedGoals, PrePlan).


satisfied(State, Goals) :-
	delete_all(Goals, State, []).           % All Goals in State


select(State, Goals, Goal) :-        % Select Goal from Goals
	member(Goal, Goals).             % A simple selection principle

achieves(Action, Goal) :-
	adds(Action, Goals),
	member(Goal, Goals).

preserves(Action, Goals) :-          % Action does not destroy Goals
	deletes(Action, Relations),
	\+ (member(Goal, Relations),
	    member(Goal, Goals)).

regress(Goals, Action, RegressedGoals) :-  % Regress Goals through Action
	adds(Action, NewRelations),
	delete_all(Goals, NewRelations, RestGoals),
	can(Action, Condition),
	addnew(Condition, RestGoals, RegressedGoals).  % Add precond., check imposs.


% addnew(NewGoals, OldGoals, AllGoals):
% AllGoals is the union of NewGoals and OldGoals
% NewGoals and OldGoals must be compatible
addnew([ ], L, L).

addnew([Goal | _], Goals, _) :-
	impossible(Goal, Goals),   % Goal incompatible with Goals
	!,
	fail.                      % Cannot be added

addnew([X | L1], L2, L3) :-
	member(X, L2), !,          % Ignore duplicate
	addnew(L1, L2, L3).
	
addnew([X | L1], L2, [X | L3]) :-
	addnew(L1, L2, L3).


% delete_all(L1, L2, Diff): Diff is set-difference of lists L1 and L2
delete_all([], _, []).

delete_all([X | L1], L2, Diff) :-
	member(X, L2), !,
	delete_all(L1, L2, Diff).

delete_all([X | L1], L2, [X | Diff]) :-
	delete_all(L1, L2, Diff).


/*
?- Start = [ clear(2), clear(4), clear(b), clear(c), on(a, 1), on(b, 3), on(c, a) ], 
plan(Start, [on(a, b)], Plan).

Plan = [ move(c, a, 2), move(a, 1, b) ]
 
*/


% Let us try the task in Figure 17.1. The initial state in Figure 17.1 is
% defined by the predicate statel in Figure 17.2. So the task of Figure 17.1 can be
% solved by:
%
%?- state1(Start), plan(Start, [on(a, b), on(b, c)], Plan).
%
% This produces the optimal plan:
%
% Start = [clear(2), clear(4), clear(b), clear(c), on(a, 1), on(b, 3), on(c, a)],
% Plan = [move(c, a, 2), move(b, 3, c), move(a, 1, b)]
%
% Compare this with the previous answer
%
% Plan = [ move(c, a, 2), move(b, 3, a), move(b, a, c), move(a, 1, b) ]
%






























