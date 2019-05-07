no(2,27).

no(3,17).

no(4,25).

no(5,11).

no(6,26).

no(7,6).

no(8,24).

no(15,31).

no(16,10).

no(17,16).

no(18,12).

no(19,35).

no(20,19).

no(21,38).

no(27,23).

no(31,29).

no(35,33).

no(39,7).

no(38,14).

no(38,32).

no(34,20).

no(34,8).

no(30,21).

no(30,13).

no(26,36).

no(26,30).

no(25,15).

no(25,4).

no(29,22).

no(29,5).

no(33,37).

no(33,34).

no(37,28).

no(37,1).

no(36,3).

no(32,9).

no(28,2).

no(24,18).





% ligacoes e distancias

%

ligacao(1,2). %  entre no 1 e 2 distancia de 1 unidade (Ex.metro)

ligacao(2,3). 

ligacao(3,4).

ligacao(4,5).

ligacao(5,6).

ligacao(6,7).

ligacao(7,8).

ligacao(8,9).

ligacao(9,11).

ligacao(11,13).

ligacao(13,23).

ligacao(23,27).

ligacao(27,31).

ligacao(31,35).

ligacao(35,39).

ligacao(39,49).

ligacao(49,48).

ligacao(48,47).

ligacao(47,46).

ligacao(46,45).

ligacao(45,44).

ligacao(44,43).

ligacao(43,42).

ligacao(42,41).

ligacao(41,40).

ligacao(40,36).

ligacao(36,32).

ligacao(32,28).

ligacao(28,24).

ligacao(24,14).

ligacao(14,12).

ligacao(12,10).

ligacao(10,1).

ligacao(17,25).

ligacao(16,17).

ligacao(16,15).

ligacao(15,14).

ligacao(25,29).

ligacao(29,33).

ligacao(33,37).

ligacao(37,43).

ligacao(20,26).

ligacao(26,30).

ligacao(30,34).

ligacao(34,38).

ligacao(38,46).







% Pesos dos produtos - dados aleatorios

peso(1,10).

peso(2,5).

peso(3,5).

peso(4,10).

peso(5,10).

peso(6,20).

peso(7,30).

peso(8,5).

peso(9,2).

peso(10,2).

peso(11,2).

peso(12,2).

peso(13,10).

peso(14,6).

peso(15,5).

peso(16,10).

peso(17,20).

peso(18,20).

peso(19,20).

peso(20,10).

peso(21,5).

peso(22,2).

peso(23,3).

peso(24,4).

peso(25,2).

peso(26,2).

peso(27,40).

peso(28,10).

peso(29,2).

peso(30,5).

peso(31,5).

peso(32,10).

peso(33,20).

peso(34,20).

peso(35,5).

peso(36,10).

peso(37,10).

peso(38,10).



% Volume dos produtos - adicionei um 0 ao final

volume(1,100).

volume(2,50).

volume(3,50).

volume(4,100).

volume(5,100).

volume(6,200).

volume(7,300).

volume(8,50).

volume(9,20).

volume(10,20).

volume(11,20).

volume(12,20).

volume(13,100).

volume(14,60).

volume(15,50).

volume(16,100).

volume(17,200).

volume(18,200).

volume(19,200).

volume(20,100).

volume(21,50).

volume(22,20).

volume(23,30).

volume(24,40).

volume(25,20).

volume(26,20).

volume(27,400).

volume(28,100).

volume(29,20).

volume(30,50).

volume(31,500).

volume(32,100).

volume(33,200).

volume(34,200).

volume(35,50).

volume(36,100).

volume(37,100).

volume(38,100).



distancia(X,Y,1) :- ligacao(X,Y).   % distancia padrao entre no e no eh um

distancia(X,Y,1) :- ligacao(Y,X).



% Define os equipamentos (empilhadeiras) com seu peso e volume max.

% notaÁ„o empilhadeira(seuCod, VolMax, PesoMax). - adicionei um 0 ao final do VolMax 



empilhadeira(1,900,125).

empilhadeira(2,1200,200).

empilhadeira(3,1800,300).

empilhadeira(4,900,200).





% este outro modelo, by Jomi È apenas exemplo ....

% monta uma lista com todas os caminhos

%

caminhos(L) :-

  findall( [X,Y], distancia(X,Y,_), L).




run :-
  cria_lista(50,L),
  busca(0,50,L,R),
  write('Caminho = '), write(R).

% Nao tem mais onde procurar, retorna o melhor que conseguiu
busca(Min,Max,L,L) :- Max =< Min.

% Procura exatamente no meio entre Min e Max
busca(Min,Max,_,R) :-    
  calc_meio(Min,Max,Meio),
  cria_lista(Meio,L),
  resolve(L),
  Meio1 is Meio-1,
  write(Min),write('-'),write(Meio1),nl,
  busca(Min,Meio1,L,R).

% Procura no meio-1 entre Min e Max
busca(Min,Max,_,R) :-    
  calc_meio(Min,Max,Meio),
  Meio1 is Meio-1,
  cria_lista(Meio1,L),
  resolve(L),
  Meio2 is Meio1-1,
  write(Min),write('-'),write(Meio2),nl,
  busca(Min,Meio2,L,R).

busca(Min,Max,L,R) :-    
  calc_meio(Min,Max,Meio),
  Meio1 is Meio+1,
  write(Meio1),write('='),write(Max),nl,
  busca(Meio1,Max,L,R).

cria_lista(0,[])    :- !.
cria_lista(N,[_|R]) :- N1 is N-1, cria_lista(N1,R).

calc_meio(Ini,Fim,Meio) :- Fim >= Ini, Meio is ((Fim - Ini) // 2)+Ini.


% resolve o CSP com uma lista de Vars
%
resolve(Vars) :-

  % cria as variaveis e os dominios

  fd_domain(Vars, 0, 49),



  % restricoes



  % a primeira variavel tem que ser o ponto 1

  Vars = [Primeira|_],
  Primeira #= 1,


  % a ultima variavel da lista tb. tem que ser um
  length(Vars,NroVars), write(NroVars),nl,
  nth(NroVars, Vars, Ultima),
  Ultima #= 1,


  % visitar todas os pontos

  no(N1,1), fd_atleast(1, Vars, N1),

  no(N5,5), fd_atleast(1, Vars, N5),

  no(N6,4), fd_atleast(1, Vars, N6),

  no(N7,7), fd_atleast(1, Vars, N7),



  % caminhos

  caminhos(Cam),

  restringe_caminhos(Vars,Cam),

  

  fd_labeling(Vars),



  % imprime resultado

  write(Vars), nl.



restringe_caminhos([_],_).

restringe_caminhos([CA,CB|R],Cam) :-

  fd_relation(Cam, [CA, CB]),

  restringe_caminhos([CB|R],Cam).

