

:- consult('planning_BlocksWorld.pl').


%
% p. 394 Ivan Bratko's Book
%

% This can be improved for better efficiency by observing that some combinations
% of goals are impossible. For example, on(a,b) and clear(b) cannot be true at the
% same time. This can be formulated as the relation
%
% impossible( Goal, Goals)
%
% which says that Goal is not possible in combination with goals Goals; that is, both
% Goal and Goals can never be achieved because they are incompatible. For our blocks
% world, such incompatible combinations can be defined as follows:

impossible(on(X, X), _). % Block cannot be on itself

impossible(on(X, Y), Goals) :-
	member(clear(Y), Goals)
	;  % Or
	member(on(X, Y1), Goals), Y1 \== Y % Block cannot be in two places
	;  % Or
	member(on(X1, Y), Goals), X1 \== X. % Two blocks cannot be in same place


impossible(clear(X), Goals) :-
	member(on(_, X), Goals).



/*
We also have to supply the relation impossible and the relation start,
which describes the initial situation of the plan. For the situation in
Figure 17.1, this is:
*/

start( [ on(a, 1), on(b, 3), on(c, a), clear(b), clear(c), clear(2), clear(4)] ).







































