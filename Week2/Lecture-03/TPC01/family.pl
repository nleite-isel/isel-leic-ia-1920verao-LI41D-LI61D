/*
Assuma que são dados factos na forma parent(name1, name2) (name1 é o pai/mãe de name2).

Defina o predicado brother(X, Y) que sucede se X and Y são irmãos.
Defina o predicado cousin(X, Y) que sucede se X and Y são primos.
Defina o predicado grandson(X, Y) que sucede se X é neto de Y.
Defina o predicado descendent(X, Y) que sucede se X é um descendente de Y.

Considere a seguinte árvore genealógica:
   parent(jose, maria).   % 1                 
   parent(jose, pedro).   % 2
   parent(maria, luis).   % 3
   parent(maria, afonso). % 4
   parent(pedro, ana).    % 5
cuja representação gráfica é:
        jose
        /   \
      maria  pedro
     /   \        \
    luis  afonso   ana

Indique que respostas, e por que ordem, são geradas pelas suas definições para as interrogações:
 
?- brother(X, Y).
?- cousin(X, Y).
?- grandson(X, Y).
?- descendent(X, Y).

Pode utilizar o predicado not/1.
*/

% Facts
parent(jose, maria).   
parent(jose, pedro).   
parent(maria, luis).   
parent(maria, afonso). 
parent(pedro, ana). 

% Rules

% Succeedes if X and Y are brothers
brother(X, Y) :- parent(Z, X), parent(Z, Y), not(X = Y).

% Succeedes if X and Y are cousins
cousin(X, Y) :- parent(L, X), parent(P, Y), brother(L, P).

% Succeedes if X is a granson of Y 
grandson(X, Y) :- parent(Y, P), parent(P, X).

% Succeedes if X is a descendent of Y 
descendent(X, Y) :- parent(Y, X).
descendent(X, Y) :- parent(Z, X), descendent(Z, Y).


/*
?- brother(X, Y).
?- cousin(X, Y).
?- grandson(X, Y).
?- descendent(X, Y).
*/























