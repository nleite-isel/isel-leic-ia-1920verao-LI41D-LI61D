
% Predicado primeiro(E, L):
% Sucede se E for o primeiro elemento da lista L.

primeiro(C, [C|_]).

% Predicado segundo(E, L):
% Sucede se E for o segundo elemento da lista L.

segundo(X, [_, X|_]).

% Predicado terceiro(E, L):
% Sucede se E for o terceiro elemento da lista L.

terceiro(X, [_, _, X|_]).

% Predicado tresPrim(P, S, T, R, L):
% Sucede se P, S, T e R forem, respectivamente, os primeiro, segundo, terceiro elementos e o resto dos
% elementos da lista L.

tresPrim(P, S, T, R, [P, S, T|R]).

% Predicado resto(R, L):
% Sucede se R for o resto da lista L.

resto(R, [_|R]).

% Predicado juntarFim(E, L, L1):
% Sucede se L1 for a lista que resulta da inserção do elemento E no fim da lista L.

juntarFim(E, [], [E]).
juntarFim(E, [Y|R], [Y|R1]) :- 
	juntarFim(E, R, R1).


% Predicado inverter(L, Li):
% Sucede se Li for a lista que resulta da inversão da ordem dos elementos existentes na lista L.

inverter([], []).
inverter([X|L], L1) :- 
	inverter(L, L2), 
	juntarFim(X, L2, L1).







