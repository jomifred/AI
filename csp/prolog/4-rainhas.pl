% Resolução de CSP com GNU Prolog
%
% Exemplo 4 raínhas
%   variáveis: supondo uma raínha por linha,
%   as variáveis representam as colunas das
%   raínhas
%        R1, R2, R3, R4
%   domínios:
%        Ri: {1..4}
%   restrições:
%        Ri \= Rj
%        | i-j | \= |Ri - Rj|
%        (\= significa diferente)
%        (|....| siginifica módulo)
%
% Para executar, digite em uma shell de comandos:
%   gprolog --query-goal "consult('4-rainhas'), resolve, halt"
%
% by Jomi

resolve :-
  nl, % nova lina

  % cria uma lista com todas as variáveis
  Todas = [R1, R2, R3, R4],

  % cria as variáveis e os domínios (valores de 1 a 4)
  fd_domain(Todas, 1, 4),

  % restrições
  fd_all_different(Todas), % todas devem ter valores diferentes

  % diagonais (dist retorna a diferença entre as variáveis)
  1 #\= dist(R1, R2),
  2 #\= dist(R1, R3),
  3 #\= dist(R1, R4),
  1 #\= dist(R2, R3),
  2 #\= dist(R2, R4),
  1 #\= dist(R3, R4),

  % resolve o CSP
  fd_labeling( Todas ),

  % imprime resultado
  write('R1 = '), write(R1), nl,
  write('R2 = '), write(R2), nl,
  write('R3 = '), write(R3), nl,
  write('R4 = '), write(R4), nl.
