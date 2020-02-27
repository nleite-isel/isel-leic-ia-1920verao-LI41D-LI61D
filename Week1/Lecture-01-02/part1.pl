


?- write('Hello World!'), nl.
Hello World!
true.


?- born(mary, yorkshire) = born(mary, X).
X = yorkshire

?- f(a, g(X, Y)) = f(X, Z), Z = g(W, h(X)).
X = a
Y = h(a)
Z = g(a, h(a))
W = a
Yes

?- p(X, 2, 2) = p(1, Y, X).
No


