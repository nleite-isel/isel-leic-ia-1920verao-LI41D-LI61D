
/*
Example 11.8
Resolution in Prolog
The resolution principle, due to Robinson [Rob65], says that if C1 
and C2 are Horn clauses and the head of C1 matches one of the terms 
in the body of C2, then we can replace the term in C2 with the body
of C1. Consider the following example:
*/

takes(jane_doe, his201).

takes(jane_doe, cs254).

takes(ajit_chandra, art302).

takes(ajit_chandra, cs254).

classmates(X, Y) :- takes(X, Z), takes(Y, Z), X \= Y.

/*
If we let X be jane_doe and Z be cs254, we can replace the first term 
on the right-hand side of the last clause with the (empty) body of the 
second clause, yielding the new rule
*/

% classmates(jane_doe, Y) :- takes(Y, cs254).

/*
In other words, Y is a classmate of jane_doe if Y takes cs254.

Note that the last rule has a variable (Z) on the right-hand side that
does not appear in the head. Such variables are existentially 
quantified: for all X and Y, X and Y are classmates if there exists a
class Z that they both take.
*/

/*
?- classmates(jane_doe, Y).
Y = ajit_chandra.
*/
