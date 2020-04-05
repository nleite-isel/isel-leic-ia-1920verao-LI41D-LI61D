
%
% Example from page 140
%

good_standard(jeanluis).

expensive(jeanluis).

good_standard(francesco).

%reasonable(Restaurant) :-      % A restaurant is reasonably priced if
%	not expensive(Restaurant). % it is not expensive

reasonable(Restaurant) :-      % A restaurant is reasonably priced if
	\+ expensive(Restaurant). % it is not expensive

/*
The usual question of interest is:
?- good_standard(X), reasonable(X).

Prolog will answer:
X = francesco

If we ask apparently the same question
?- reasonable(X), good_standard(X).

then Prolog will answer:
no

?- expensive(X).
X = jeanluis.

%?- not expensive(X).
?- \+ expensive(X).
no

?- \+ expensive(francesco).
yes

*/
