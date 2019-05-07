%
% FURB/DSC
% Disciplina de IA
% Prof. Jomi Hubner
%
% Exemplo busca em largura
%    caso dos missionarios e canibais
%    v.2: quem esta na conoa nao conta para as minorias
%
% Conhecimento do problema
%   Mis = Missionario
%   Can = Canibal
%   Bar = Barco
%
% descricao dos estados
%   e(MisE, CanE, MisD, CanE, LadoBar, QuemBar).
% onde
%   MisE = nro de mis no lado esquerdo
%   CabE = nro de can no dado esquerdo
%   MisD = nro de mis no lado direito
%   CabD = nro de can no dado direito
%   ladoBar = lado em que o Barco esta (dir ou esq)
%   quemBar = lista com quem esta no barco

% Acoes

% entrar Barco
%
acao(entrarMisBar,
     e( MisE, CanE, MisD, CanD, esq,  QuemBar),
     e(NMisE, CanE, MisD, CanD, esq, NQuemBar)) :-
	MisE > 0,
	MisE > CanE,
	size(QuemBar,S), S < 2,
	NMisE is MisE - 1,
	conc(QuemBar,[mis],NQuemBar).
acao(entrarMisBar,
     e(MisE, CanE,  MisD, CanD, dir,  QuemBar),
     e(MisE, CanE, NMisD, CanD, dir, NQuemBar)) :-
	MisD > 0,
	MisD > CanD,
	size(QuemBar,S), S < 2,
	NMisD is MisD - 1,
	conc(QuemBar,[mis],NQuemBar).

acao(entrarCanBar,
     e(MisE,  CanE, MisD, CanD, esq, QuemBar),
     e(MisE, NCanE, MisD, CanD, esq, [can|QuemBar])) :-
	CanE > 0,
	size(QuemBar,S), S < 2,
	NCanE is CanE - 1.
acao(entrarCanBar,
     e(MisE, CanE, MisD,  CanD, dir, QuemBar),
     e(MisE, CanE, MisD, NCanD, dir, [can|QuemBar])) :-
	CanD > 0,
	size(QuemBar,S), S < 2,
	NCanD is CanD - 1.


% sair Barco
%
acao(sairMisBar,
     e( MisE, CanE, MisD, CanD, esq,  QuemBar),
     e(NMisE, CanE, MisD, CanD, esq, NQuemBar)) :-
	member(mis,QuemBar),
	del(mis,QuemBar,NQuemBar),
	NMisE is MisE + 1.
acao(sairMisBar,
     e(MisE, CanE,  MisD, CanD, dir,  QuemBar),
     e(MisE, CanE, NMisD, CanD, dir, NQuemBar)) :-
	member(mis,QuemBar),
	del(mis,QuemBar,NQuemBar),
	NMisD is MisD + 1.

acao(sairCanBar,
     e(MisE,  CanE, MisD, CanD, esq,  QuemBar),
     e(MisE, NCanE, MisD, CanD, esq, NQuemBar)) :-
	CanE < MisE,
	member(can,QuemBar),
	del(can,QuemBar,NQuemBar),
	NCanE is CanE + 1.
acao(sairCanBar,
     e(MisE, CanE, MisD,  CanD, dir,  QuemBar),
     e(MisE, CanE, MisD, NCanD, dir, NQuemBar)) :-
	CanD < MisD,
	member(can,QuemBar),
	del(can,QuemBar,NQuemBar),
	NCanD is CanD + 1.


% ir para outro lado
%
acao(irDir,
     e(MisE, CanE, MisD, CanD, esq, QuemBar),
     e(MisE, CanE, MisD, CanD, dir, QuemBar)) :-
	size(QuemBar,S), S > 0.
acao(irEsq,
     e(MisE, CanE, MisD, CanD, dir, QuemBar),
     e(MisE, CanE, MisD, CanD, esq, QuemBar)) :-
	size(QuemBar,S), S > 0.

	

% busca em largura
%   dado uma lista de caminhos candidados
%   1. se a meta eh a cabeca da lista, o caminho eh a solucao
%   2. pega o primeiro caminho, gera todas as geracoes de filhos
%      e inclui os novos caminhos no final dos abertos

teste :- 
	N = 3,
	solucao(n(ini,e(N,N,0,0,esq,[])),n(_,e(0,0,N,N,_,_)),R),
	reverse(R,R2),
	x(R2), nl.

solucao(Inicio, Fim, Solucao) :- 
	buscal([ [Inicio] ], Fim, Solucao).

% formato do predicado
%    buscal( lista de caminhos possiveis, Meta, Solucao).

% caso 1.
buscal( [ [Meta|Solucao] | OutrosCaminhos], Meta, [Meta|Solucao]).

% caso 2.
buscal([ Caminho|RAbertos], Meta, Solucao) :-
	%write('Tentando caminho'),nl,x(Caminho),
	%size(RAbertos,SRA),write('nro abertos='),write(SRA),nl,
	filhos( Caminho, Filhos),
	%largura:
	conc( RAbertos, Filhos, NovoAbertos),	 
	%profundidade: 
	%conc( Filhos, RAbertos, NovoAbertos),	 
	buscal( NovoAbertos, Meta, Solucao).

x([]).
x([n(A,E)|R]) :- write('acao='), write(A), write(' gerou '),write(E),write(','),nl,x(R).

% gera os filhos de um caminho
filhos([n(AcaoN,Nodo) | Caminho], NovosCaminhos) :-
     findall([n(NomeAcao,Filho), n(AcaoN,Nodo) | Caminho],
		(acao(NomeAcao, Nodo, Filho),
		 not(member(n(_,Filho), [n(_,Nodo)|Caminho]))),
		NovosCaminhos).


% Predicados de manipulacao de listas
%
%member(X,[X|_]) :- !.
%member(X,[C|R]) :- member(X,R).

conc([],L,L).
conc([X|L1],L2,[X|L3]) :- conc(L1,L2,L3).

size([],0).
size([_|R],N) :- size(R,X), N is X+1.

del(X,[X|M],M) :- !.
del(X,[A|R],[A|M]) :- del(X,R,M).

reverse([],[]).
reverse([X|R],L) :-
	reverse(R,T),
	conc(T,[X],L).

:- nl,nl,write('Digite "teste." para rodar o algoritmo'),nl,nl.
