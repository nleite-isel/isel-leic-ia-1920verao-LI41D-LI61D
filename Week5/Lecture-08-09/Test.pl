

%?- 1 + A = B + 2.

% +(1, A) = +(B,2).


/*
(1) If X and Y are equal then D is equal to X.
(2) If X < Y then D is equal to the greatest common divisor of X and the difference Y- X.
(3) If Y < X then do the same as in case (2) with X and Y interchanged.

Ex:

gcd(X, Y)
gcd(20, 25)

X < Y: gcd(20, 25-20) = gcd(20, 5)
Y < X: gcd(20, 5) = gcd(20-5, 5) = gcd(15, 5)
Y < X: gcd(15, 5) = gcd(15-5, 5) = gcd(10, 5)
Y < X: gcd(10, 5) = gcd(10-5, 5) = gcd(5, 5)
X = Y: gcd(5, 5) = 5

*/
gcd(X, X, X).

gcd(X, Y, D) :-
	X < Y,
	Y1 is Y - X,
	gcd(X, Y1, D).

gcd(X, Y, D) :-
	Y < X,
	X1 is X - Y,
	gcd(X1, Y, D).

/*
?- gcd(20, 25, D).
D = 5 ;
*/

/*
length1([ ], 0).

length1([_ | Tail], N) :-
	length1(Tail, N1),
	N is 1 + N1.
*/

/*	

?- length1( [ a, b, [ c, d], e], N).
N = 4.

?- length1( [ a, b, c, d, e], N).
N = 5.
*/

/*
length1([ ], 0).

length1([_ | Tail], N) :-
	N is 1 + N1, % Error, N1 not instantiated
	length1(Tail, N1).
*/

length1([ ], 0).

length1([_ | Tail], N) :-
	length1( Tail, N1),
	N = 1 + N1.

/*
?- length1( [ a, b, [ c, d], e], N).
N = 1+(1+(1+(1+0))),

?- length1( [ a, b, [ c, d], e], N), L is N.
N = 1+(1+(1+(1+0))),
L = 4.

*/






























