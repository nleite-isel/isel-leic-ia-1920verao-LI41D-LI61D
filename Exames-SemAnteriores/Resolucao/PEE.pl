%
% Inteligência Artificial - 2a Chamada 15/07/2016
%


/*
1. Pesquisa em Espaço de Estados

Estado inicial
M M M
 M M M

Estado final
 M M
M   M
 M M

1-(a) (2 valores) Modele o estado do problema e indique a situação inicial e final.

Cardinal Points:
     N
  NW   NE
W         E
  SW   SE
     S

Cardinal Points excluding North (N) and South (S):
  NW   NE
W         E
  SW   SE


Estado do problema:

[Coin1 ID + cardinal neighbours except North+South, 
 Coin2 ID + cardinal neighbours except North+South, 
 etc.]
[[ID1, NW1, NE1, W1, E1, SW1, SE1], [ID2, NW2, NE2, W2, E2, SW2, SE2], etc.]

Situação inicial:
[ [1, -, -, -, 2, -, 4], [2, -, -, 1, 3, 4, 5], [3, -, -, 2, -, 5, 6], 
  [4, 1, 2, -, 5, -, -], [5, 2, 3, 4, 6, -, -], [6, 3, -, 5, -, -, -] ]


Situação final:
[ [1, -, -, -, 2, 6, -], [2, -, -, 1, -, -, 3], 
  [3, 2, -, -, -, 4, -], [4, -, 3, 5, -, -, -], 
  [5, 6, -, -, 4, -, -], [6, -, 1, -, -, -, 5] ]

*/

/*
b) (3,5 valores) Escreva em PROLOG todos os operadores que vai necessitar bem
como os predicados auxiliares

NOTA: Se um predicado auxiliar for repetitivo, indique um exemplo e explique o que
variava.
*/


% State = [[ID1, NW1, NE1, W1, E1, SW1, SE1], [ID2, NW2, NE2, W2, E2, SW2, SE2], etc.]
%
% Successor - Move one coin to another feasible position
s(Coins1, Coins2) :- 
	write('[s] Before moveCoinFeasibly: Coins1 ='), writeln(Coins1),
	moveCoinFeasibly(Coins1, Coins2), !, % CUT
	% Debug
	write('[s] After moveCoinFeasibly: Coins2 ='), writeln(Coins2).
	% --


moveCoinFeasibly(Coins1, Coins2) :-
	member(ID, [1, 2, 3, 4, 5, 6]), % Select coin ID sequentially - TO DO - Consider random selection
	getCoinByID(ID, Coins1, Coin),  % Get coin by ID
	% Debug
	write('[moveCoinFeasibly] Coin: '), writeln(Coin),
	% --
	canMove(Coin),                  % See if coin can move
	move(Coin, Coins1, Coins2).



getCoinByID(ID, Coins, [ID | Links]) :-
	member([ID | Links], Coins).

% To debug
%  spy(canMove).


% NE, W, SE
%  M
%MX
%  M
canMove([ID, _, X1, X2, _, _, X3]) :- % NE, W, SE
	write('[canMove] [ID, _, X1, X2, _, _, X3]: '), writeln([ID, _, X1, X2, _, _, X3]),
	number(X1),
	number(X2),
	number(X3), 
	fail.


% NW, E, SW
%M
% XM
%M
canMove([ID, X1, _, _, X2, X3, _]) :- % NW, E, SW
	write('[canMove] [ID, X1, _, _, X2, X3, _]: '), writeln([ID, X1, _, _, X2, X3, _]),
	number(X1),
	number(X2),
	number(X3),
	fail.


% In other situations, coin can move
canMove([_, _, _, _, _, _, _]) :-
	% Debug
	writeln('[canMove] OK '). 
	% --


% Move the selected coin to a new feasible position
move([ID | Links], Coins1, Coins2) :-
	% Debug
	write('[move] Coin: '), writeln([ID | Links]),
	% --
	member(NewID, [1, 2, 3, 4, 5, 6]), % Select new ID sequentially - TO DO - Consider random selection
	NewID =\= ID,
	getCoinByID(NewID, Coins1, NeighCoin),
	% Debug
	write('[move] NeighCoin: '), writeln(NeighCoin),
	% --
	feasibleMove([ID | Links], NewID, NeighCoin, Coins1, Coins2).
	


% Do feasible move
feasibleMove([ID | Links], NewID, NeighCoin, Coins1, Coins2) :-
	Coin = [ID | Links], % Aux var
	% Debug
	write('[feasibleMove] Coin, NewID, NeighCoin: '), writeln([Coin, NewID, NeighCoin]),
	% --
	unlink(Coin, Coins1, Coins1Aux), 
	% Debug
	writeln('[feasibleMove] After unlink'),
	write('[feasibleMove] Coin, Coins1Aux before remove: '),
	writeln(Coin),
	writeln(Coins1Aux),
	% --
	% Get original Coin with ID
	getCoinByID(ID, Coins, Coin1),
	del(Coin1, Coins1Aux, Coins2Aux),
	% Debug
	write('[feasibleMove] Coins2Aux after remove: '),
	writeln(Coins2Aux),
	% --
	% Get updated NeighCoin with NewID
	getCoinByID(NewID, Coins1Aux, NeighCoin1),
	link(Coin1, NeighCoin1, Coins2Aux, Coins2).
	


%/////////////////////////////////////////////////


% unlink(Coin, Coins1, Coins1Aux).
% Unlink a given coin
% A coin is represented by [ID, NW, NE, W, E, SW, SE]

% Fully unlinked
unlink([_, -, -, -, -, -, -], Coins, Coins) :-
	!,
	% Debug
	writeln('[unlink] Fully unlinked').
	% --
	
% Unlink a given coin
% A coin is represented by [ID, NW, NE, W, E, SW, SE]
unlink([ID | Links], Coins, Coins1) :-
	% Debug
	writeln('[unlink] [ID | Links], Coins'),
	writeln([ID | Links]),
	writeln(Coins),
	% --
	member(ID_Neigh, Links), % Get neighbour ID
	% Debug
	write('[unlink] ID_Neigh = '), 
	writeln(ID_Neigh),
	% --
	number(ID_Neigh),        % It has to be a number
	removeNeighLink(ID_Neigh, ID, Coins, CoinsAux),
	replace(ID_Neigh, -, Links, Links1),
	replace([ID | Links], [ID | Links1], CoinsAux, Coins1Aux),
	% Debug
	write('[unlink] Links after removing ID_Neigh = '), 
	writeln(Links1),
	% --
	unlink([ID | Links1], Coins1Aux, Coins1).
	

% Remove link in neighbour
removeNeighLink(ID_Neigh, ID, Coins, CoinsAux) :-
	% Debug
	write('[removeNeighLink] ID_Neigh, ID '),
	writeln([ID_Neigh, ID]),
	% --
	getCoinByID(ID_Neigh, Coins, [ID_Neigh | NeighLinks]),
	% Debug
	write('[removeNeighLink] NeighLinks: '),
	writeln(NeighLinks),
	% --
	replace(ID, -, NeighLinks, NeighLinks1),
	replace([ID_Neigh | NeighLinks], [ID_Neigh | NeighLinks1], Coins, CoinsAux),
	% Debug
	write('[removeNeighLink] CoinsAux: '),
	writeln(CoinsAux).
	% --


%/////////////////////////////////////////////////


% Connect a coin in a feasible link of NeighCoin 
% A coin is represented by [ID, NW, NE, W, E, SW, SE]
link([CoinID | Links], [NeighCoinID | NeighLinks], Coins1, Coins2) :-
	% Debug
	writeln('[link] [CoinID | Links], [NeighCoinID | NeighLinks]: '), 
	writeln([CoinID | Links]), writeln([NeighCoinID | NeighLinks]),
	% --
	member(LinkIndex, [1, 2, 3, 4, 5, 6]), % Get link
	nth1(LinkIndex, NeighLinks, Link), % Get link (equals '-' or an neigh ID)
	% Debug
	write('[link] [LinkIndex, Link]: '), writeln([LinkIndex, Link]), 
	% --
	isFeasibleLink(LinkIndex, Link, NeighLinks, CoinID, Coins1),
	linkCoin([CoinID | Links], LinkIndex, NeighCoinID, Coins1, Coins2).


isFeasibleLink(LinkIndex, Link, NeighLinks, CoinId, Coins1) :-
	% Debug
	write('[isFeasibleLink] [LinkIndex, Link, NeighLinks]: '), 
	writeln([LinkIndex, Link, NeighLinks]), 
	% --
	Link == -,
	% Debug
	write('[isFeasibleLink] empty link with value '),
	writeln(Link),
	% --
	isFeasible(LinkIndex, NeighLinks),
	% Debug
	writeln('[isFeasibleLink] Is feasible').
	% --


% A link is feasible if has at least an adjacent neighbour
% NeighLinks = [NW, NE, W, E, SW, SE]
isFeasible(1, NeighLinks) :-
	nth1(3, NeighLinks, NeighID),
	number(NeighID)    % It as an adjacent
	;
	(nth1(2, NeighLinks, NeighID),
	number(NeighID)).


% A link is feasible if has at least an adjacent neighbour
% NeighLinks = [NW, NE, W, E, SW, SE]
isFeasible(2, NeighLinks) :-
	nth1(4, NeighLinks, NeighID),
	number(NeighID)
	;
	(nth1(1, NeighLinks, NeighID),
	number(NeighID)).


% A link is feasible if has at least an adjacent neighbour
% NeighLinks = [NW, NE, W, E, SW, SE]
isFeasible(3, NeighLinks) :-
	nth1(1, NeighLinks, NeighID),
	number(NeighID)
	;
	(nth1(5, NeighLinks, NeighID),
	number(NeighID)).


% A link is feasible if has at least an adjacent neighbour
% NeighLinks = [NW, NE, W, E, SW, SE]
isFeasible(4, NeighLinks) :-
	nth1(1, NeighLinks, NeighID),
	number(NeighID)
	;
	(nth1(6, NeighLinks, NeighID),
	number(NeighID)).


% A link is feasible if has at least an adjacent neighbour
% NeighLinks = [NW, NE, W, E, SW, SE]
isFeasible(5, NeighLinks) :-
	nth1(3, NeighLinks, NeighID),
	number(NeighID)
	;
	(nth1(6, NeighLinks, NeighID),
	number(NeighID)).


% A link is feasible if has at least an adjacent neighbour
% NeighLinks = [NW, NE, W, E, SW, SE]
isFeasible(6, NeighLinks) :-
	nth1(4, NeighLinks, NeighID),
	number(NeighID)
	;
	(nth1(5, NeighLinks, NeighID),
	number(NeighID)).


%/////////////////////////////////////////////////

% Link coin by changing NeighLinks
linkCoin([CoinID | Links], LinkIndex, NeighCoinID, Coins1, Coins2) :-
	% Debug
	writeln('[linkCoin] CoinID, LinkIndex, NeighCoinID, Coins1'),
	writeln([CoinID, LinkIndex, NeighCoinID]),
	writeln(Coins1),
	% --
	% Get coin
	%getCoinByID(CoinID, Coins1, [CoinID | Links]),
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins1, [NeighCoinID | NeighLinks]),
	% Debug
	writeln('[linkCoin] NeighLinks'),
	writeln(NeighLinks),
	% --
	%
	% Connect coin by updating coin and neighbour' links
	%
	replaceInIdx(NeighLinks, LinkIndex, CoinID, NeighLinks1),
	opposite(LinkIndex, LinkIndexOp),
	replaceInIdx(Links, LinkIndexOp, NeighCoinID, Links1),
	% Debug
	writeln('[linkCoin] NeighLinks1, LinkIndexOp, Links1'),
	writeln(NeighLinks1),
	writeln(LinkIndexOp),
	writeln(Links1),
	% --
	% Update coins' list
	%del([CoinID | Links], Coins1, Coins1Aux),
	del([NeighCoinID | NeighLinks], Coins1, Coins2Aux),
	append([[CoinID | Links1]], Coins2Aux, Coins3Aux),
	append([[NeighCoinID | NeighLinks1]], Coins3Aux, Coins4),
	% Debug
	writeln('[linkCoin] Coins4'),
	writeln(Coins4),
	% --
	% Update adjacent coins' links
	updateAdjacents(CoinID, NeighCoinID, LinkIndex, Coins4, Coins2). 
	
	
opposite(1, 6).

opposite(2, 5).

opposite(3, 4).

opposite(4, 3).

opposite(5, 2).

opposite(6, 1).

/*
updateAdjacents(CoinId, NeighCoinID, 1, Coins, Coins1) :-
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins, [NeighCoinID | NeighLinks]),
	% W
	updateNeighDir(3, 1, 2, CoinId, NeighLinks, Coins, Coins1Aux),
	% NE
	updateNeighDir(2, 1, 3, CoinId, NeighLinks, Coins1Aux, Coins1).
*/

updateAdjacents(CoinId, NeighCoinID, 2, Coins, Coins1) :-
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins, [NeighCoinID | NeighLinks]),
	% E
	%updateNeighDir(4, 2, 1, CoinId, NeighLinks, Coins, Coins1Aux).
	updateNeighDir(4, 2, 1, CoinId, NeighLinks, Coins, Coins1).
	% NW
	%updateNeighDir(1, 2, 4, CoinId, NeighLinks, Coins1Aux, Coins1).

/*
updateAdjacents(CoinId, NeighCoinID, 3, Coins, Coins1) :-
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins, [NeighCoinID | NeighLinks]),
	% SW
	updateNeighDir(5, 3, 1, CoinId, NeighLinks, Coins, Coins1Aux),
	% NW
	updateNeighDir(1, 3, 5, CoinId, NeighLinks, Coins1Aux, Coins1).


updateAdjacents(CoinId, NeighCoinID, 4, Coins, Coins1) :-
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins, [NeighCoinID | NeighLinks]),
	% SE
	updateNeighDir(6, 4, 2, CoinId, NeighLinks, Coins, Coins1Aux),
	% NE
	updateNeighDir(2, 4, 6, CoinId, NeighLinks, Coins1Aux, Coins1).


updateAdjacents(CoinId, NeighCoinID, 5, Coins, Coins1) :-
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins, [NeighCoinID | NeighLinks]),
	% SE
	updateNeighDir(6, 5, 3, CoinId, NeighLinks, Coins, Coins1Aux),
	% W
	updateNeighDir(3, 5, 6, CoinId, NeighLinks, Coins1Aux, Coins1).


updateAdjacents(CoinId, NeighCoinID, 6, Coins, Coins1) :-
	% Get neighbour coin
	getCoinByID(NeighCoinID, Coins, [NeighCoinID | NeighLinks]),
	% SW
	updateNeighDir(5, 6, 4, CoinId, NeighLinks, Coins, Coins1Aux),
	% E
	updateNeighDir(4, 6, 5, CoinId, NeighLinks, Coins1Aux, Coins1).
*/

updateNeighDir(Dir, OriginLink, LinkIndexToConnect, CoinID, NeighLinks, Coins, Coins1) :-
	% Debug
	writeln('[updateNeighDir] Dir, OriginLink, LinkIndexToConnect, CoinID, NeighLinks, Coins'),
	writeln([Dir, OriginLink, LinkIndexToConnect, CoinID]),
	writeln(NeighLinks),
	writeln(Coins),
	% --
	nth1(Dir, NeighLinks, NeighCoinID),
	% Debug
	write('[updateNeighDir] NeighCoinID: '),
	writeln(NeighCoinID),
	% --
	number(NeighCoinID) ->
		(getCoinByID(NeighCoinID, Coins, [NeighCoinID | NewNeighLinks]),
		getCoinByID(CoinID, Coins, [CoinID | Links]),
		% Debug
		write('[updateNeighDir] [NeighCoinID | NewNeighLinks]: '),
		writeln([NeighCoinID | NewNeighLinks]),
		write('[updateNeighDir] [CoinID | Links]: '),
		writeln([CoinID | Links]),
		% --
		% Replace link in adjacent coin
		replaceInIdx(NewNeighLinks, LinkIndexToConnect, CoinID, NewNeighLinks1),
		opposite(LinkIndexToConnect, LinkIndexOp),
		replaceInIdx(Links, LinkIndexOp, NeighCoinID, Links1),
		% Update coins' list
		del([CoinID | Links], Coins, Coins1Aux),
		del([NeighCoinID | NewNeighLinks], Coins1Aux, Coins2Aux),
		append([[CoinID | Links1]], Coins2Aux, Coins3Aux),
		append([[NeighCoinID | NewNeighLinks1]], Coins3Aux, Coins4),
		% Debug
		writeln('[updateNeighDir] Coins4: '),
		writeln(Coins4),
		Coins1 = Coins4
		%
		% Update adjacents recursively
		%updateAdjacents(CoinID, NeighCoinID, LinkIndexToConnect, Coins4, Coins1)
		)
	;
	(Coins1 = Coins).




%///////////////////////////////////////////////////////
%
% AUXILIARY PREDICATES
%

% del	
del(X, [X | L], L).

del(X, [Y | L], [Y | L1]) :-
	del(X, L, L1).


% replace
replace(_, _, [], []).

replace(O, R, [O|T], [R|T2]) :- 
	replace(O, R, T, T2).

replace(O, R, [H|T], [H|T2]) :- 
	H \= O, replace(O, R, T, T2).
	
/*	
% replaceInIdx(SourceList, Index, Val, DestList) - Zero based index 
replaceInIdx([_ | T], 0, X, [X | T]).

replaceInIdx([H | T], I, X, [H | R]) :- 
	I > -1, 
	NI is I-1, 
	replaceInIdx(T, NI, X, R), 
	!.

replaceInIdx(L, _, _, L).
*/

% replaceInIdx(SourceList, Index, Val, DestList) - 1-based index 
replaceInIdx([_ | T], 1, X, [X | T]).

replaceInIdx([H | T], I, X, [H | R]) :- 
	I > 0, 
	NI is I-1, 
	replaceInIdx(T, NI, X, R), 
	!.

replaceInIdx(L, _, _, L).


%///////////////////////////////////////////////////////

/*
Situação inicial:
[ [1, -, -, -, 2, -, 4], [2, -, -, 1, 3, 4, 5], [3, -, -, 2, -, 5, 6], 
  [4, 1, 2, -, 5, -, -], [5, 2, 3, 4, 6, -, -], [6, 3, -, 5, -, -, -] ]


Situação final:
[ [1, -, -, -, 2, 6, -], [2, -, -, 1, -, -, 3], 
  [3, 2, -, -, -, 4, -], [4, -, 3, 5, -, -, -], 
  [5, 6, -, -, 4, -, -], [6, -, 1, -, -, -, 5] ]
*/


% The goal condition for our example problem is:
/*
goal(Situation) :-
	writeln(Situation),
	permutation(Situation, [ [_, -, -, -, X1, X2, -],  [_, -, -, X3, -, -, X4], 
                  [_, -, X5, -, -, -, X6],  [_, X7, -, -, -, X8, -], 
                  [_, X9, -, -, X10, -, -], [_, -, X11, X12, -, -, -] ]),
                  number(X1),
                  number(X2),
                  number(X3),
                  number(X4),
                  number(X5),
                  number(X6),
                  number(X7),
                  number(X8),
                  number(X9),
                  number(X10),
                  number(X11),
                  number(X12).
*/


/*
goal(Situation) :-
	member([ [1, -, -, -, 2, 6, -], [2, -, -, 1, -, -, 3], 
  [3, 2, -, -, -, 4, -], [4, -, 3, 5, -, -, -], 
  [5, 6, -, -, 4, -, -], [6, -, 1, -, -, -, 5] ], Situation).
  
*/


goal(Situation) :-
	writeln(''),
	writeln('[goal] Situation: '),
	writeln(Situation),
	writeln(''),
	permutation(Situation, [[2,-,1,-,3,4,5],[1,-,-,-,-,2,3],[3,1,-,2,-,5,6],
	[4,-,2,-,5,-,-],[5,2,3,4,6,-,-],[6,3,-,5,-,-,-]]).

  



/*
c) (2 valores) Considere a situação apresentada na figura 5. Usando o algoritmo de
pesquisa em largura quais seriam os estados seguintes.
*/



%
% An implementation of breadth-first search.
%

% solve( Start, Solution):
% Solution is a path (in reverse order) from Start to a goal
solve( Start, Solution) :-
	breadthfirst( [ [Start] ], Solution).

% breadthfirst( [ Path1, Path2, ...], Solution):
% Solution is an extension to a goal of one of paths
breadthfirst( [ [Node | Path] | _], [Node | Path]) :-
	goal(Node).

breadthfirst( [Path | Paths], Solution) :-
	extend( Path, NewPaths),
	append( Paths, NewPaths, Paths1),
	breadthfirst( Paths1, Solution).
	
extend( [Node | Path], NewPaths) :-
	findall( [NewNode, Node | Path],
			 (s(Node, NewNode), \+ member(NewNode, [Node | Path])),
			 NewPaths).



/*
For our block manipulation problem, the corresponding call can be:
?- solve([ [1, -, -, -, 2, -, 4], [2, -, -, 1, 3, 4, 5], [3, -, -, 2, -, 5, 6], 
  [4, 1, 2, -, 5, -, -], [5, 2, 3, 4, 6, -, -], [6, 3, -, 5, -, -, -] ]
, Solution).



*/
























































