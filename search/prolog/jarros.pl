
:- nl,nl,
   write('------------------------------------------------------------------'),nl,nl,
   write('Trabalho de disciplina USP/PCS'),nl,
   write('Fundamentos Logicos da Inteligencia Artificial'),nl,
   write('Prof. Dr. Jaime Simao Sichman'),nl,nl,
   write('Aluno: Jomi Fred Hubner'),nl,
   write('       abril de 1999'),nl,nl,
   write('Solucao para o problema dos jarros (busca em espaco de estados)'),nl,nl,
   write('------------------------------------------------------------------'),nl,nl,
   write('Teste com:'),nl,
   write('   jug(InicioJarro4l,InicioJarro3l,ObjetivoJarro4l,ObjetivoJarro3l).'),nl,
   write('por exemplo:'),nl,
   write('   jug(0,0,2,0).'),nl,nl,
   write('------------------------------------------------------------------'),nl,nl.


jug(X1, Y1, X2, Y2) :- buscal([ [ (X1,Y1,'inicio ') ] ], (X2,Y2,_),
   Solucao), writeSol(Solucao),nl.

writeSol([]).
writeSol([(X,Y,O)|R]) :- 
   writeSol(R),
   write(O), write(': ('),write(X), write(','), write(Y), write(')'),nl.

    % Estado     Estado apos
    % Atual      Operacao                  Pre-condicoes
    % ---------	 --------------------	   ----------------
oper( (X1,Y1,_), (4,Y1,'encheJ4    ')) :-  X1 < 4.
oper( (X1,Y1,_), (X1,3,'encheJ3    ')) :-  Y1 < 3.
oper( (X1,Y1,_), (0,Y1,'esvaziaJ4  ')) :-  X1 > 0.
oper( (X1,Y1,_), (X1,0,'esvaziaJ3  ')) :-  Y1 > 0.
oper( (X1,Y1,_), (4,Y2,'transJ3J4  ')) :-  T is X1 + Y1, T >= 4,
                                           X1 < 4, Y1 > 0,
                                           Y2 is Y1 - (4 - X1).
oper( (X1,Y1,_), (X2,3,'transJ4J3  ')) :-  T is X1 + Y1, T >= 3,
                                           X1 > 0, Y1 < 3,
                                           X2 is X1 - (3 - Y1).
oper( (X1,Y1,_), (X2,0,'derramaJ3J4')) :-  T is X1 + Y1, T =< 4,
                                           Y1 > 0,
                                           X2 is X1 + Y1.
oper( (X1,Y1,_), (0,Y2,'derramaJ4J3')) :-  T is X1 + Y1, T =< 3,
                                           X1 > 0,
                                           Y2 is X1 + Y1.

% busca em largura
%   dado uma lista de caminhos candidados
%   1. se a meta eh a cabeca da lista, este caminho eh a solucao
%   2. senao, pega o primeiro caminho, gera todas as geracoes de filhos
%      e inclui os novos caminhos no final dos abertos
%
% formato da clausula
%    buscal( lista de caminhos possiveis (abertos), Meta, Solucao).
%	cada caminho eh uma lista de operacoes


% caso 1.
buscal( [ [Meta|Solucao] | _], Meta, [Meta|Solucao]).

% caso 2.
buscal([ Caminho|RAbertos], Meta, Solucao) :-
   filhos( Caminho, Filhos), %write('Filhos '), write(Filhos),nl,
   % largura:
   conc( RAbertos, Filhos, NovoAbertos),
   % profundidade: 
   %conc( Filhos, RAbertos, NovoAbertos),	 
   buscal( NovoAbertos, Meta, Solucao).


% gera os filhos de um caminho
filhos([Nodo | Caminho], NovosCaminhos) :-
   findall([Filho, Nodo | Caminho], 
      (oper( Nodo, Filho), \+ member(Filho, [Nodo|Caminho])),
      NovosCaminhos).


%the next line is needed for SWI prolog
%:- redefine_system_predicate(member(_,_)).

member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

conc([],L,L).
conc([X|L1],L2,[X|L3]) :- conc(L1,L2,L3).

:- jug(0,0,2,0),halt.





