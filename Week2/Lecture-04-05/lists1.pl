
/*
Exercícios
Considerando a definição de lista escreva os programas PROLOG para os seguintes
predicados e faça a dedução dos golos indicados

1- Predicado PRIMEIRO(X,Y) X é a cabeça da lista Y
G: primeiro(a, Y)

2- Predicado RESTO(X,Y) X é o resto da lista Y
G:resto(X,lista(a,lista(b,lista(c,vazio)))).

3- Predicado TIRAR(X,Y,Z), Z é uma lista que contem a lista Y sem o elemento X
G:tirar(b, lista(a,lista(b,vazio)), Z).

4- Predicado JUNTAR(X,Y,Z) Z é uma lista que contém os elementos da lista X seguidos
dos elementos da lista Y
G:juntar(lista(1,lista(2, vazio)), lista(a vazio), Z).

5- Predicado para INVERTER(X,Y) Y é a lista que contem os mesmos elementos que X
mas na ordem inversa.
G:inverter(X,lista(a,lista(b,vazio))).

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

tirar(vazio, vazio, vazio).

tirar(C, lista(C, R), R).

tirar(X, lista(C, R), Z) :- 
	lista(C, R1),  % Not working...
	tirar(X, R1, Z).

%?- tirar(a, lista(a,lista(b,vazio)), Z).
%?- tirar(b, lista(a,lista(b,vazio)), Z).

%//////////////////////////////////////////////////////






























