/*

Exe 2. Introduza no SWI-Prolog o exercício 1.8.1 presente no ficheiro

Prolog programming for artificial intelligence by Ivan Bratko_pp50_51.ps

Analise os resultados.
*/


% Words that may be used in the solution
word(d,o,g).
word(f,o,u,r).
word(b,a,k,e,r).
word(p,r,o,l,o,g).
word(r,u,n).
word(l,o,s,t).
word(f,o,r,u,m).
word(v,a,n,i,s,h).
word(t,o,p).
word(m,e,s,s).
word(g,r,e,e,n).
word(w,o,n,d,e,r).
word(f,i,v,e).
word(u,n,i,t).
word(s,u,p,e,r).
word(y,e,l,l,o,w).

solution(L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16) :-
	word(L1, L2, L3, L4, L5), % Top horizontal word
	word(L9, L10, L11, L12, L13, L14), % Second horizontal word
	word(L1, L6, L9, L15), % First vertical word
	word(L3, L7, L11), % Second vertical word
	word(L5, L8, L13, L16). % Third vertical word

% Goal
%?- solution(Ll, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16).
