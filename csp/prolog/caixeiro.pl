% Resolucao de CSP com GNU Prolog
%
% Exemplo do Caixeiro viajante
%
% Variavies: C1, C2, C3, .... C7
%  C1 tem o nro da primeira cidade a ser visitada,
%  C2 eh a segunda a ser visitada, etc.
%  Valor 0 indica que a cidade nao teve visita
%
% Explo: C1=1, C2=3, C3=1, C4=0, C5=0, C6=0, C7=0
%  sai da cidade 1, vai para a cidade 3, volta para a cidade 1.
%
% Restricoes
%  C1 = 1 (comeca na cidade 1)
%  visitar todas as cidades
%  ter estrada entre Ci e Cj (para j = i+1)
%  a ultima cidade visita eh a cidade 1
%
% Otimizacao
%  a soma dos custos de ir da cidade Ci para Cj
%
% Para executar, digite em uma shell de comandos:
%   gprolog --query-goal "consult('caixeiro.pl'), resolve, halt"
%
% by Jomi


% definicao das estradas e distancias
%
estrada(1,3,5). %  da cidade 1 para a cidade 3, 5 Km
estrada(1,4,3). %  da cidade 1 para a cidade 4, 3 Km 
estrada(3,2,10).
estrada(3,4,3).
estrada(4,2,2).

distancia(0,0,0). % para indicar que nao ir a lugar nenhum, tem custo 0
distancia(1,0,0).
distancia(2,0,0).
distancia(3,0,0).
distancia(4,0,0).
distancia(X,Y,D) :- estrada(X,Y,D).
distancia(X,Y,D) :- estrada(Y,X,D).

% monta uma lista com todas os caminhos
%
caminhos(L) :-
  findall( [X,Y], distancia(X,Y,_), L).

% monta uma lista com todas as distancias
%
distancias(L) :-
  findall( d(X,Y,D), distancia(X,Y,D), L).

% monta uma lista com todas as cidades
%
cidades(L) :-
  findall( X, distancia(X,_,_), LX), sort(LX,L).

resolve :-
  % cria uma lista com todas as variaveis
  Todas = [C1, C2, C3, C4, C5, C6, C7],

  % cria as variaveis e os dominios
  cidades(Cidades),
  length(Cidades, NroCidades),
  fd_domain(Todas, 0, NroCidades),

  % restricoes

  % comecar na cidade 1
  C1 #= 1,

  % visitar todas as cidades
  fd_atleast(2, Todas, 1), % pelo menos duas vars devem ter valor 1
  fd_atleast(1, Todas, 2), % pelo menos 1 var deve ter o valor 2
  fd_atleast(1, Todas, 3), % ...
  fd_atleast(1, Todas, 4),

  % caminhos
  caminhos(Cam), 
  fd_relation(Cam, [C1, C2]), % entre a cidade da visita C1 e da visita C2, deve ter caminho
  fd_relation(Cam, [C2, C3]),
  fd_relation(Cam, [C3, C4]),
  fd_relation(Cam, [C4, C5]),
  fd_relation(Cam, [C5, C6]),
  fd_relation(Cam, [C6, C7]),
  
  % para acabar na cidade 1 (C7 eh a ultima cidade do caminho)
  ((C7 #= 1) #\/ (C7 #= 0)),
  (C7 #= 0) #==> (C6 #= 1 #\/ C6 #= 0),
  (C6 #= 0) #==> (C5 #= 1 #\/ C5 #= 0),
  (C5 #= 0) #==> (C4 #= 1 #\/ C4 #= 0),
 
  % otimiza o CSP
  fd_minimize(
     (fd_labeling(Todas), 
      calculaCusto(Todas,CT)),
     CT),
  %fd_labeling(Todas),

  % imprime resultado
  write('Caminho = '), write(Todas), nl,
  write('Custo='), write(CT), 
  nl.

calculaCusto([C1,C2,C3,C4,C5,C6,C7], CT) :-
  distancia(C1,C2,D1),
  distancia(C2,C3,D2),
  distancia(C3,C4,D3),
  distancia(C4,C5,D4),
  distancia(C5,C6,D5),
  distancia(C6,C7,D6),
  CT #= D1 + D2 + D3 + D4 + D5 + D6.

