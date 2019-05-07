% Resolution of the magic square problem
% using GNU Prolog
%
% In a 4x4 matrix filled with numbers from
% 1..16, the sum of lines and columns must
% be 34.
%
% by Jomi

resolution :-
	L1 = [V11, V12, V13, V14],
	L2 = [V21, V22, V23, V24],
	L3 = [V31, V32, V33, V34],
	L4 = [V41, V42, V43, V44],

	C1 = [V11, V21, V31, V41],
	C2 = [V12, V22, V32, V42],
	C3 = [V13, V23, V33, V43],
	C4 = [V14, V24, V34, V44],

	D1 = [V11, V22, V33, V44],
	D2 = [V14, V23, V32, V41],


	append(L1, L2, X1),
	append(X1, L3, X2),
	append(X2, L4, Todos),

	Dim = 4,
	N is Dim * Dim,
	MagicNumber is round(Dim * (((Dim * Dim)+1) / 2)),

	fd_domain(Todos, 1, N),
	fd_all_different(Todos),

	sum(L1, MagicNumber),
	sum(L2, MagicNumber),
	sum(L3, MagicNumber),
	sum(L4, MagicNumber),
	sum(C1, MagicNumber),
	sum(C2, MagicNumber),
	sum(C3, MagicNumber),
	sum(C4, MagicNumber),
	sum(D1, MagicNumber),
	sum(D2, MagicNumber),

	fd_labeling(Todos, [variable_method(most_constrained)]),
	write('matrix='),nl,
	write(L1),nl,
	write(L2),nl,
	write(L3),nl,
	write(L4),nl.

sum([V1, V2, V3, V4], Sum) :-
        V1 + V2 + V3 + V4 #= Sum.


:- initialization(resolution).
