
%
% Fig. 17.2 - A definition of the planning domain for the blocks world.
%

% Definition of action move(Block, From, To) in blocks world
% can(Action, Condition): Action possible if Condition true
can(move(Block, From, To), [ clear(Block), clear(To), on(Block, From)]) :-
    block(Block),    % Block to be moved
	object(To),      % 'To' is a block or a place
	To \== Block,    % Block cannot be moved to itself
	object(From),    % 'From' is a block or a place
	From \== To,     % Move to new position
	Block \== From.  % Block not moved from itself


% adds(Action, Relationships): Action establishes Relationships
adds(move(X, From, To), [ on(X, To), clear(From) ]).

% deletes(Action, Relationships): Action destroys Relationships
deletes(move(X, From, To), [ on(X, From), clear(To) ]).


object(X) :-    % X is an object if
	place(X)    % X is a place
	;           % or
	block( X).  % X is a block


% A blocks world
block(a).
block(b).
block(c).

place(1).
place(2).
place(3).
place(4).

% A state in the blocks world
%
%       c
%       a   b
%       = = = =
% place 1 2 3 4

state1( [ clear(2), clear(4), clear(b), clear(c), on(a, 1), on(b, 3), on(c, a) ]).
































