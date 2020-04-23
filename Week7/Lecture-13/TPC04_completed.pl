% Realize os exercícios usando listas Prolog:

% 1. Predicado conc(L1, L2, L):
% Sucede se L for a lista que resulta da concatenação dos elementos 
% da lista L1 com os elementos da lista L2.
%
% ?- conc([1,2,3], [a, b], Z).
% Z = [1, 2, 3, a, b]
%?- spy(conc). % Para fazer Debug

conc([], L, L).
conc([C1|R1], L2, [C1|R]) :-
	conc(R1, L2, R).

% 2. Predicado membro(E, L): Sucede se o elemento E pertence à lista L.

membro(E, [E|R]).
membro(E, [C|R]) :-
	membro(E, R).
	
/*
?- membro(2, [1, 2, a, b]).
true .

?- membro(x, [1, 2, a, b]).
false.

?- membro(X, [1, 2, a, b]).
X = 1 ;
X = 2 ;
X = a ;
X = b ;
false.
*/

% 3. Nova versão para o predicado membro: membroV1(E, L), mas feito à custa 
% do predicado conc/3.

membroV1(E, L) :- 
	conc(L1, [E|_], L).

	
/*
?- membroV1(2, [1, 2, a, b]).
true .

?- membroV1(x, [1, 2, a, b]).
false.

?- membroV1(X, [1, 2, a, b]).
X = 1 ;
X = 2 ;
X = a ;
X = b ;
false.
*/	

/*	
% Reparem que assim nao funciona:
membroV1(E, L) :- 
	conc([E], L1, L).
% Pois obriga a que E esteja no principio da lista resultado.	
*/
/*
?- membroV1(X, [1, 2, a, b]).
X = 1.

?- membroV1(1, [1, 2, a, b]).
true.

?- membroV1(a, [1, 2, a, b]).
false.

*/




% 4. Predicado insInicio(E, L, L1):
% Sucede se L1 for a lista que resulta da inserção do elemento E 
% antes de todos os elementos da lista L.

insInicio(E, L, [E|L]).
/*
?- insInicio(2, [a, b], Z).
Z = [2, a, b].

?- insInicio(1, [a, b], [2, a, b]).
false.

?- insInicio(X, [a, b], [2, a, b]).
X = 2.
*/

% 5. Predicado inserir(E, L, L1):
% Sucede se L1 for a lista que resulta da inserção do elemento E 
% numa posição qualquer da lista L

inserir(E, L, [E|L]). 
inserir(E, [C|R], [C|R1]) :-
	inserir(E, R, R1).

/*
?- inserir(1, Z, [a, b, 1]).
Z = [a, b] ;
false.

?- inserir(1, [a, b], Z).
Z = [1, a, b] ;
Z = [a, 1, b] ;
Z = [a, b, 1] ;
false.

?- inserir(1, [a, b], [a, b, 1]).
true ;
false.

?- inserir(X, [a, b], [a, b, 1]).
X = 1 ;
false.
*/

 
% 6. Nova versão para o predicado membro: membroV2(E, L), mas feito à
% custa do inserir/3.

membroV2(E, L) :- 
	inserir(E, L1, L).


%?- membroV2(2, [1, 2, a, b]).
%true.

%?- membroV2(x, [1, 2, a, b]).
%false.

%?- membroV2(X, [1, 2, a, b]).
%X = 1 ;
%X = 2 ;
%X = a ;
%X = b ;
%false.

% 7. Predicado eliminar(E, L, L1):
% Sucede se L1 for a lista que resulta da eliminação do elemento E 
% em qualquer posição da lista L.

eliminar(E, [E|R], R).
eliminar(E, [C|R1], [C|R2]) :- 
	eliminar(E, R1, R2).
	
	
%?- eliminar(2, [1, 2, a, b], Z).
% Z = [1, a, b].

% 8. Nova versão para o predicado eliminar, feito à custa do inserir/3.

eliminarV1(E, L, L1) :-
	inserir(E, L1, L).
/*
?- eliminarV1(2, [1, 2, a, b], Z).
Z = [1, a, b].

?- eliminarV1(1, [1, 2, a, b], Z).
Z = [2, a, b].

?- eliminarV1(a, [1, 2, a, b], Z).
Z = [1, 2, b].

?- eliminarV1(b, [1, 2, a, b], Z).
Z = [1, 2, a].
*/


% 9. Nova versão para o predicado inserir/3 feito à custa de eliminar/3

inserirV1(E, L, L1) :-
	eliminar(E, L1, L).

% ?- inserirV1(1, Z, [a, b, 1]).
% Z = [a, b] ;
%false.

%?- inserirV1(1, [a, b], Z).
%Z = [1, a, b] ;
%Z = [a, 1, b] ;
%Z = [a, b, 1] ;
%false.

%?- inserirV1(1, Z, [1, a, b, 1]).
%Z = [a, b, 1] ;
%Z = [1, a, b] ;
%false.

%/////////////////////////////////////////////////
% See p. 60, Program 3.15 - append, of "The art of Prolog"
% and p. 113 - Search tree with an infinite branch
% with goal append (Xs, [c, d], Ys)
% It is the same problem as sublista(S, L)
% with the first goal conc(L1, S, L2)
%/////////////////////////////////////////////////


/*
conc([], L, L).
conc([C1|R1], L2, [C1|R]) :-
	conc(R1, L2, R).
*/

% 10. Predicado sublista(S, L):
% Sucede se S for uma sublista de L.


% Falha no último caso
sublista([], L).
sublista(S, L) :-
	conc(L1, S, L2), % This call enters in infinite recursion
	conc(L2, L3, L). 


/*
% OK
sublista([], L).
sublista(S, L) :-
	conc(L2, L3, L),
	conc(L1, S, L2).
*/

/*
% Ou:
sublista([], _).
sublista(S, L) :- 
	conc(_, L2, L),
	conc(S, _, L2), 
	S \= [].
*/

%?- spy(sublista).

/*
?- sublista([2, a], [1, 2, a, b]).
true.

?- sublista([2, a], [2, a, b]).
true.

?- sublista([2, a], [1, 2, a]).
true.

?- sublista([2, a], [1, 2, 1, a]).
false.
*/


% 11. Predicado permuta(L, Lp):
% Sucede se Lp for uma permutação de L.
% 11.1 - Implementação 1: feito à custa de inserir/3
% 11.2 - Implementação 2: feito à custa de eliminar/3


% 11.1 - Implementação 1: feito à custa de inserir/3

/*
%Primeira Tentativa (Incorreta)
permuta(L, [E|L1]) :-
	membro(E, L), % Por cada elemento de L
	inserir(E, L1, L). % Insere elemento E em L1 de modo a obter L

E = 1, L1 = [2, 3] => L = [1, 2, 3]
E = 2, L1 = [1, 3] => L = [1, 2, 3]
E = 3, L1 = [1, 2] => L = [1, 2, 3]


%?- findall(P, permuta([1, 2, 3], P), L).
%L = [[1, 2, 3], [2, 1, 3], [3, 1, 2]].
*/

% Versao correta
permuta([], []).
permuta(L, [E|R]) :-
	membro(E, L), % Por cada elemento de L
	inserir(E, L1, L), % Insere elemento E em L1 de modo a obter L
	permuta(L1, R). 

/*
% Outra Versao correta
permuta([], []).
permuta([C|R], Lp) :-
	permuta(R, L1), % cria permutacao do resto
	inserir(C, L1, Lp). % Insere cabeca na permutacao do resto 
*/

%?- permuta([1, 2, 3], P).

%?- findall(P, permuta([1, 2, 3], P), L).
% L = [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2], [3, 1, 2], [3, 2, 1]].



% 11.2 - Implementação 2: feito à custa de eliminar/3

permutaV1([], []).
permutaV1(L, [C|R]) :- 
	eliminar(C, L, L1),
	permutaV1(L1, R). 

	
%?- permutaV1([1, 2, 3], P).

%?- findall(P, permutaV1([1, 2, 3], P), L).
% L = [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2], [3, 1, 2], [3, 2, 1]].




































