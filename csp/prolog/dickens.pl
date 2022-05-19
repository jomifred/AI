% Problema de CSP
%  by Jomi 2004

% Enunciado:
% O romancista inglês Charles Dickens nunca foi, até onde se sabe, um fã de passatempos, mas ele bem poderia ter sido um. Sua mente era capaz de produzir frases como ``..e o infortunado Millier passou a sentir-se tão fora do seu elemento como um golfinho na guarda de uma sentinela'', mostrando criatividade para idéias contraditórias, que é uma das chaves para se decifrar um enigma. E o último livro de Dickens, \textit{O mistério de Edwin Drood}, era uma espécie de quebra-cabeça literário, um romance de mistério tornado ainda mais enigmático pelo fato de o grande escritor ter morrido antes de concluí-lo. Mas neste passatempo, não existe mistério nenhum; basta um pouco de pensamento lógico ao examinar os quadrados abaixo (uma matriz de 7x7, cada lugar numerado sequencialmente de 1 a 49 na ordem de leitura). Em cada fila horizontal, coluna vertical e linha diagonal, todas formadas por sete quadradinhos, aparecem as sete letras D, I, C, K, E, N e  S, em uma certa ordem. Preenchemos alguns dos quadrados para servirem de ponto de partida (1=D, 6=I, 23=C, 28=K, 39=E, 41=N, 47=S), e as pistas abaixo irão ajudar você a preencher os restantes.
%\begin{enumerate}
%\item Os quadrados 3 e 42 contêm a mesma letra;
%\item Os quadrados 4 e 26 contêm a mesma letra, que é diferente daquela do quadrado 43;
%\item Os quadrados 5 e 49 contêm a mesma letra;
%\item Os quadrados 9 e 36 contêm a mesma letra; e
%\item Os quadrados 22 e 48 contêm a mesma letra.
%\end{enumerate}
%

% to run on GNU Prolog
%    gprolog --query-goal "consult('dickens'), halt"

resolution :-
	% the Matrix's variables organized on lines
	L1 = [ V1,  V2,  V3,  V4,  V5,  V6,  V7],
	L2 = [ V8,  V9, V10, V11, V12, V13, V14],
	L3 = [V15, V16, V17, V18, V19, V20, V21],
	L4 = [V22, V23, V24, V25, V26, V27, V28],
	L5 = [V29, V30, V31, V32, V33, V34, V35],
	L6 = [V36, V37, V38, V39, V40, V41, V42],
	L7 = [V43, V44, V45, V46, V47, V48, V49],

	% cria uma lista com todas as variávies
	append(L1, L2, X2),
	append(X2, L3, X3),
	append(X3, L4, X4),
	append(X4, L5, X5),
	append(X5, L6, X6),
	append(X6, L7, Todos),

	% define o domínio das variáveis (tem que ser numérico)
	fd_domain(Todos, 1, 7),

	% Constraints

	% Letras dadas no enunciado
	V1 = 1,
	V6 = 2,
	V23 = 3,
	V28 = 4,
	V39 = 5,
	V41 = 6,
	V47 = 7,

	% as dicas
	V3 #= V42,
	V4 #= V26,
	V4 #\= V43,
	V5 #= V49,
	V9 #= V36,
	V22 #= V48,

	% cada linha tem que ter cada letra
	fd_all_different(L1),
	fd_all_different(L2),
	fd_all_different(L3),
	fd_all_different(L4),
	fd_all_different(L5),
	fd_all_different(L6),
	fd_all_different(L7),

	% idem para as as colunas
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 1),
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 2),
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 3),
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 4),
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 5),
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 6),
	constraintCol(L1, L2, L3, L4, L5, L6, L7, 7),

	% e para as diagonais
	fd_all_different([V1, V9, V17, V25, V33, V41, V49]),
	fd_all_different([V7, V13, V19, V25, V31, V37, V43]),

	% resolve
	fd_labeling(Todos, [variable_method(most_constrained)]),
	%fd_labeling(Todos),

	write('solucao='),nl,

	converteListaParaLetra(L1, EmLetra1),
	converteListaParaLetra(L2, EmLetra2),
	converteListaParaLetra(L3, EmLetra3),
	converteListaParaLetra(L4, EmLetra4),
	converteListaParaLetra(L5, EmLetra5),
	converteListaParaLetra(L6, EmLetra6),
	converteListaParaLetra(L7, EmLetra7),

	write(EmLetra1),nl,
	write(EmLetra2),nl,
	write(EmLetra3),nl,
	write(EmLetra4),nl,
	write(EmLetra5),nl,
	write(EmLetra6),nl,
	write(EmLetra7),nl.

constraintCol(L1, L2, L3, L4, L5, L6, L7, NrCol) :-
	nth(NrCol, L1, C1),
	nth(NrCol, L2, C2),
	nth(NrCol, L3, C3),
	nth(NrCol, L4, C4),
	nth(NrCol, L5, C5),
	nth(NrCol, L6, C6),
	nth(NrCol, L7, C7),
	fd_all_different([C1, C2, C3, C4, C5, C6, C7]).


converteListaParaLetra([],[]).
converteListaParaLetra([C|R],[L|RL]) :-
	converteParaLetra(C,L),
	converteListaParaLetra(R,RL).
converteParaLetra(1,d).
converteParaLetra(2,i).
converteParaLetra(3,c).
converteParaLetra(4,k).
converteParaLetra(5,e).
converteParaLetra(6,n).
converteParaLetra(7,s).

:- initialization(resolution).
