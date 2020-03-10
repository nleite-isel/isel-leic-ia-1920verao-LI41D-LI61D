
/*
Exercícios
Considerando a definição de lista escreva os programas PROLOG para os seguintes
predicados e faça a dedução dos golos indicados

1- Predicado PRIMEIRO(X,Y) X é a cabeça da lista Y
G: primeiro(a, Y)

2- Predicado RESTO(X,Y) X é o resto da lista Y
G:resto(X,lista(a, lista(b, lista(c, vazio)))).

3- Predicado TIRAR(X,Y,Z), Z é uma lista que contem a lista Y sem o elemento X
G:tirar(b, lista(a, lista(b, vazio)), Z).

4- Predicado JUNTAR(X,Y,Z) Z é uma lista que contém os elementos da lista X seguidos
dos elementos da lista Y
G:juntar(lista(1,lista(2, vazio)), lista(a, vazio), Z).

5- Predicado para INVERTER(X,Y) Y é a lista que contem os mesmos elementos que X
mas na ordem inversa.
G:inverter(X, lista(a, lista(b, vazio))).

*/

primeiro(vazio, vazio).

%primeiro(X, lista(C, Y)) :- X = C.
primeiro(C, lista(C, Y)).

%?- primeiro(X, lista(a, lista(b, lista(c, vazio)))).

%//////////////////////////////////////////////////////

resto(vazio, vazio).

resto(R, lista(C, R)).

%?- resto(X,lista(a,lista(b,lista(c,vazio)))).

%//////////////////////////////////////////////////////

/*
3- Predicado TIRAR(X,Y,Z), Z é uma lista que contem a lista Y sem o elemento X
G:tirar(b, lista(a,lista(b,vazio)), Z).
*/

%
% IMPLEMENTACAO 1
%
% C1 e C2 para responder a interrogacoes do genero
% ?- tirar(vazio, vazio, L).
/*
tirar(vazio, vazio, vazio). % (C1)

tirar(vazio, L, L). % (C2)

tirar(C, lista(C, R), R). % (C3)

tirar(X, lista(C, R), Z) :- 
	tirar(X, R, L), Z = lista(C, L). % (C4)
*/

%
% IMPLEMENTACAO 2
%
% C1 e C2 para responder a interrogacoes do genero
% ?- tirar(vazio, vazio, L).

tirar(vazio, vazio, vazio). % (C1)

tirar(vazio, L, L). % (C2)

tirar(C, lista(C, R), R). % (C3)

tirar(C, lista(Y, R), lista(Y, R1)) :- 
	tirar(C, R, R1). % (C4)

%?- tirar(vazio, vazio, vazio).
%?- tirar(a, lista(a,lista(b,vazio)), Z).
%?- tirar(b, lista(a,lista(b,vazio)), Z).
%?- tirar(b, lista(a,lista(b, lista(c, vazio))), Z).

%//////////////////////////////////////////////////////

/*
4- Predicado JUNTAR(X,Y,Z) Z é uma lista que contém os elementos da lista X seguidos
dos elementos da lista Y
G:juntar(lista(1,lista(2, vazio)), lista(a, vazio), Z).
*/
juntar(vazio, vazio, vazio). 

juntar(vazio, L, L). 

juntar(lista(C, vazio), vazio, lista(C, vazio)). 

%juntar(lista(C1, R1), lista(C2, R2), lista(C1, R)) :- 
%	juntar(R1, lista(C2, R2), R).
% Ou:
juntar(lista(C1, R1), X, lista(C1, R)) :- 
	juntar(R1, X, R).	

%?- juntar(vazio, vazio, vazio).
%?- juntar(lista(1, vazio), lista(a, vazio), Z).
%?- juntar(lista(1, lista(2, vazio)), lista(a, vazio), Z).
%?- juntar(vazio, lista(a, vazio), Z).
%?- juntar(lista(1, vazio), vazio, Z).


%//////////////////////////////////////////////////////

/*
5- Predicado para INVERTER(X,Y) Y é a lista que contem os mesmos elementos que X
mas na ordem inversa.
G:inverter(X, lista(a, lista(b, vazio))).
*/

%
% IMPLEMENTACAO 1
%

% Usando predicado auxiliar juntarFim(E, L, L1):
% Sucede se L1 for a lista que resulta da inserção do elemento E no fim da lista L.

juntarFim(vazio, vazio, vazio).

juntarFim(X, vazio, lista(X, vazio)).

juntarFim(X, lista(C, R), lista(C, Z)) :-
	juntarFim(X, R, Z).

%?- juntarFim(1, lista(a, lista(b, vazio)), Z).


% inverter(X, Y) 
inverter(lista(C, vazio), lista(C, vazio)).

inverter(lista(C, R), Z) :- 
	inverter(R, Y), juntarFim(C, Y, Z).


/*
?- inverter(lista(a, lista(b, vazio)), Z).
Z = lista(b, lista(a, vazio))

?- inverter(lista(a, lista(b, lista(c, vazio))), Z).
Z = lista(c, lista(b, lista(a, vazio)))
*/

/*
%
% IMPLEMENTACAO 2
%

% Usando predicado auxiliar inverter3(lista_A, lista_B, Acumulador).
inverter3(vazio, Z, Z).
inverter3(lista(C, R), Z, Acc) :- inverter3(R, Z, lista(C, Acc)).

inverter(vazio, vazio). 

inverter(X, Y) :- 
	inverter3(X, Y, vazio).	

%?- spy(inverter).

%?- inverter(vazio, vazio).
%?- inverter(lista(1, vazio), Z).
%?- inverter(lista(1, lista(2, vazio)), Z).
%?- inverter(lista(1, lista(2, lista(a, vazio))), Z).
*/
%//////////////////////////////////////////////////////






































