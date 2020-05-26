%
% Figure 18.5 Partial order planning program.
%

% Partial Order Planner, using CLP(FD) and iterative deepening search
%
% Partially ordered plan = pop( Actions, OpenConditions, TrueConditions, FinishingTime)
%
% Actions = [ Action1:Time1, Action2:Time2, ...] Actions and their execution times
% OpenConditions = [ Cond1:Time1, Cond2:Time2, ...]
% TrueConds = [ Cond1:Time11/Time12, Cond2:Time21/Time22, ... ]
% Note: Ordering constraints are implemented as CLP(FD) constraints

:- use_module(library(clpfd)). % Load library for CLP(FD)

:- op(100, fx, ~). % Notation for negative effects of an action

% plan(StartState, Goals, Plan, Finish):
% Plan is partially ordered plan that achieves Goals from StartState at time Finish
%
plan(StartState, Goals, Plan) :-
	add_intervals(0, StartState, TrueConds, Finish),    % StartState true at time 0
	add_times(Finish, Goals, OpenConds),                % Goals should be true at time Finish
	EmptyPlan = pop([], OpenConds, TrueConds, Finish),  % No actions in initial plan
	MaxActions in 0..100,                               % Maximally 100 actions in plan
	indomain(MaxActions),                               % Enforce iterative deepening search
	Finish in 1..MaxActions,                            % Domain for finishing time of Plan
	depth_first(EmptyPlan, SolutionPath, MaxActions),   % Search in space of POP's
	once(indomain(Finish)),                             % Minimize finishing time
	append(_, [Plan], SolutionPath).                    % Working plan is last element of solution path


% s(POP, NewPOP): successor relation between partially ordered plans
%     NewPOP is POP with the first open condition in POP achieved
%
s( pop(Acts, [Cond:Time | OpenPs], TrueConds, Fin),
  pop(Acts, OpenPs, TrueConds, Fin) ) :-
	member(Cond:Time1/Time2, TrueConds), % Cond already true between Time1 and Time2
	Time1 #< Time, Time #=< Time2.       % Constrain Time to interval Time1/Time2
		
s( pop(Acts, [Cond:Time | OpenPsO], TrueCondsO, Fin),
	 pop([Action1:Time1 | Acts], OpenPs, TrueConds, Fin) ) :-
	effects(Action1, Effects),              % Look for action that may achieve Cond
	del(Cond, Effects, RestEffects),        % Cond in Effects, that is Action1 achieves Cond
	can(Action1, PreConds1),                % Preconditions for Action1
	0 #< Time1, Time1 #< Time,              % Action1 must occur after 0 and before Time
	add_times(Time1, PreConds1, NewOpenPs),                   % Add Time1 to all preconditions
	add_intervals(Time1, RestEffects, RestEffectsTimes, Fin), % Add time intervals to all effects
	Time #=< Time2,                         % Achieved condition must be true until Time
	add_conds([Cond:Time1/Time2 | RestEffectsTimes], TrueCondsO, TrueConds), % Add effects to TrueCondsO
	append(NewOpenPs, OpenPsO, OpenPs).       % Add preconditions of Action to goals


% add_conds(Conds, TrueConds, NewTrueConds):
%    Add conditions Conds to list TrueConds, and set corresponding precedence constraints
%
add_conds([], TrueConds, TrueConds).

add_conds([CondTime | Conds], TrueCondsO, TrueConds) :-
	no_conflict(CondTime, TrueCondsO), % No conflict between CondTime and TrueCondsO
	add_conds(Conds, [CondTime | TrueCondsO], TrueConds).


% no_conflict(CondTime, TrueCondsO):
%   Set constraints to ensure no conflict between CondTime and TrueCondsO
%
no_conflict(_, []).

no_conflict(CondTime, [Cond1Time1 | TrueConds]) :-
	no_conflict1(CondTime, Cond1Time1),
	no_conflict(CondTime, TrueConds).

no_conflict1(CondA:Ta1/Ta2, CondB:Tb1/Tb2) :-
	inconsistent(CondA, CondB), !, % CondA inconsistent with CondB
	(Ta2 #=< Tb1; Tb2 #=< Ta1)     % Ensure no time overlap between CondA and CondB
	;
	true. % Case when CondA consistent with CondB - no constraint needed

% add_times(Time, Conds, TimedConds)
%
add_times(_, [], []).

add_times(Time, [Cond | Conds], [Cond:Time | TimedConds]) :-
	add_times(Time, Conds, TimedConds).

% add_intervals(Time, Conds, TimedConds, Finish):
%   every condition in Conds true from Time till some later time
%
add_intervals(_, [], [], _).

add_intervals(Time, [Cond | Conds], [Cond:Time/Time2 | TimedConds], Finish) :-
	Time #< Time2, Time2 #=< Finish, % Cond true from Time until Time2 =< Finish
	add_intervals(Time, Conds, TimedConds, Finish).


% depth_first(POP, SolutionPath, MaxActionsInPOP):
%   Depth-first search, with respect to number of actions, among partially ordered plans
%
depth_first(POP, [POP], _) :-
	POP = pop(_, [], _, _). % No open preconditions - this is a working plan

depth_first(First, [First | Rest], MaxActions) :-
	First = pop(Acts, _, _, _),
	length(Acts, NActs),
	(NActs < MaxActions, !         % # actions in plan is below MaxActions
	 ;
	 Second = pop(Acts, _, _, _)), % # actions in plan at maximum, no action may be added
	s(First, Second),
	depth_first(Second, Rest, MaxActions).


% Display all possible execution schedules of a partial order plan
%
show_pop(pop(Actions, _, _, _)) :-
	instantiate_times(Actions),               % Instantiate times of actions for readability
	setof(T:A, member(A:T, Actions), Sorted), % Sort actions according to times
	nl, write('Actions = '), write(Sorted),   % Write schedule
	fail                                      % Backtrack to produce other schedules
	;
	nl, nl.                                   % All schedues produced


% instantiate_times( Actions): instantiate times of actions respecting ordering constraints
%
instantiate_times([]).

instantiate_times([_:T | Acts]) :-
	indomain(T),                   % A value in domain of T
	instantiate_times(Acts).


del( X, [X | Tail], Tail).

del( X, [Y | Tail], [Y | Tail1]) :-
	del( X, Tail, Tail1).








































