%
% FURB/DSC
% Disciplina de IA
% Prof. Jomi Hubner
%
% Exemplo busca em largura
%   caso dos missionarios e canibais
%   v.1: quem esta na conoa conta para as minorias
%
% Digite
%   teste.
% para rodar o programa
%
% Conhecimento do problema
%   Mis = Missionario
%   Can = Canibal
%   Bar = Barco
%
% descricao dos estados
%   e(MisE, CanE, MisD, CanE, LadoBar).
% onde
%   MisE = nro de mis no lado esquerdo
%   CabE = nro de can no dado esquerdo
%   MisD = nro de mis no lado direito
%   CabD = nro de can no dado direito
%   ladoBar = lado em que o Barco esta (dir ou esq)

% Acoes

acao(levar1Mis,
     e( MisE, CanE,  MisD, CanD, esq),
     e(NMisE, CanE, NMisD, CanD, dir)) :-
	MisE >= 1,
	NMisE is MisE - 1,
	NMisD is MisD + 1,
	testaReq(NMisE, CanE, NMisD, CanD).
acao(trazer1Mis,
     e( MisE, CanE,  MisD, CanD, dir),
     e(NMisE, CanE, NMisD, CanD, esq)) :-
	MisD >= 1,
	NMisD is MisD - 1,
	NMisE is MisE + 1,
	testaReq(NMisE, CanE, NMisD, CanD).
acao(levar2Mis,
     e( MisE, CanE,  MisD, CanD, esq),
     e(NMisE, CanE, NMisD, CanD, dir)) :-
	MisE >= 2,
	NMisE is MisE - 2,
	NMisD is MisD + 2,
	testaReq(NMisE, CanE, NMisD, CanD).
acao(trazer2Mis,
     e( MisE, CanE,  MisD, CanD, dir),
     e(NMisE, CanE, NMisD, CanD, esq)) :-
	MisD >= 2,
	NMisD is MisD - 2,
	NMisE is MisE + 2,
	testaReq(NMisE, CanE, NMisD, CanD).


%para canibais

acao(levar1Can,
     e(MisE,  CanE, MisD,  CanD, esq),
     e(MisE, NCanE, MisD, NCanD, dir)) :-
	CanE >= 1,
	NCanE is CanE - 1,
	NCanD is CanD + 1,
	testaReq(MisE, NCanE, MisD, NCanD).
acao(trazer1Can,
     e(MisE,  CanE, MisD,  CanD, dir),
     e(MisE, NCanE, MisD, NCanD, esq)) :-
	CanD >= 1,
	NCanE is CanE + 1,
	NCanD is CanD - 1,
	testaReq(MisE, NCanE, MisD, NCanD).
acao(levar2can,
     e(MisE,  CanE, MisD,  CanD, esq),
     e(MisE, NCanE, MisD, NCanD, dir)) :-
	CanE >= 2,
	NCanE is CanE - 2,
	NCanD is CanD + 2,
	testaReq(MisE, NCanE, MisD, NCanD).
acao(trazer2can,
     e(MisE,  CanE, MisD,  CanD, dir),
     e(MisE, NCanE, MisD, NCanD, esq)) :-
	CanD >= 2,
	NCanE is CanE + 2,
	NCanD is CanD - 2,
	testaReq(MisE, NCanE, MisD, NCanD).

% ir um can e um mis
acao(levar1Can1Mis,
     e( MisE,  CanE,  MisD,  CanD, esq),
     e(NMisE, NCanE, NMisD, NCanD, dir)) :-
	MisE >= 1,
	CanE >= 1,
	NCanE is CanE - 1,
	NMisE is MisE - 1,
	NCanD is CanD + 1,
	NMisD is MisD + 1,
	testaReq(NMisE, NCanE, NMisD, NCanD).
acao(trazer1Can1Mis,
     e( MisE,  CanE,  MisD,  CanD, dir),
     e(NMisE, NCanE, NMisD, NCanD, esq)) :-
	MisD >= 1,
	CanD >= 1,
	NCanE is CanE + 1,
	NMisE is MisE + 1,
	NCanD is CanD - 1,
	NMisD is MisD - 1,
	testaReq(NMisE, NCanE, NMisD, NCanD).

testaReq(MisE, CanE, MisD, CanD) :-
	%write(validando),write(MisE),write(CanE),write(MisD),write(CanD),
	(MisE = 0; MisE >= CanE),
	(MisD = 0; MisD >= CanD).

% busca em largura
%   dado uma lista de caminhos candidados
%   1. se a meta eh a cabeca da lista, o caminho eh a solucao
%   2. pega o primeiro caminho, gera todas as geracoes de filhos
%      e inclui os novos caminhos no final dos abertos

teste :- 
	N = 3,
	solucao(n(ini,e(N,N,0,0,esq)),n(_,e(0,0,N,N,_)),R),
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
	      not(member(n(_,Filho), [n(_,Nodo)|Caminho]))
	     ),
	     NovosCaminhos).


% Predicados de manipulacao de listas
%

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
