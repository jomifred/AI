% Resolution of the n-queens problem
% using GNU Prolog
%
% by Jomi

% Defines the queens domain and contraints
%
queensDefinition(Queens) :-
	length(Queens, N),

	fd_domain(Queens, 1, N),
	fd_all_different(Queens),
	distConstraint(Queens).
	
% the distance contraints
distConstraint([]).
distConstraint([Q|T]) :-
        distConstraint(Q,T,1),
        distConstraint(T).

distConstraint(_,[],_).
distConstraint(Q,[H|T],D) :-
        dist(Q,H) #\= D,
        D1 is D + 1,
        distConstraint(Q,T,D1).

% the creation of the variables
createQueens(0,[]).
createQueens(N,[_|R]) :-
	N1 is N - 1,
	createQueens(N1, R).

% the "main"
queensResolution(N) :-
    createQueens(N, Queens),
	queensDefinition(Queens),
	fd_labeling(Queens, [variable_method(most_constrained)]),
	write('queens='),write(Queens),nl.
	

:- initialization(queensResolution(8)).
