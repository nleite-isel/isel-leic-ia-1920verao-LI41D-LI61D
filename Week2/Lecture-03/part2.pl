
/*

% Anonymous variable 
?- p(_, 2, 2) = p(1, Y, _).
Y = 2
Yes

*/

/* Example: Mortal Philosophers */
mortal(X) :- man(X).
man(socrates).

?- mortal(socrates).
Yes
