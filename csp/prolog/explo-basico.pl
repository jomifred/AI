% Resolução de CSP com GNU Prolog
%
% Exemplo básico:
%   variáveis:
%        X1, X2, X3
%   domínios:
%        X1: {1, 2}
%        X2: {2}
%        X3: {1, 2}
%   restrições:
%        X1 \= X3
%        X2 \= X3
%        (\= significa diferente)
%
% Para executar, digite em uma shell de comandos:
%   gprolog --query-goal "consult('explo-basico'), resolve, halt"
%
% by Jomi

resolve :-
  nl, % nova lina

  % cria uma lista com todas as variáveis
  Todas = [X1, X2, X3],

  % cria as variáveis e os domínios
  fd_domain(X1, [1,2]),
  fd_domain(X2, [2]),
  fd_domain(X3, [1,2]),

  % restrições
  X1 #\= X3,
  X2 #\= X3,

  % resolve o CSP
  fd_labeling( Todas ),

  % imprime resultado
  write('X1 = '), write(X1), nl,
  write('X2 = '), write(X2), nl,
  write('X3 = '), write(X3), nl.
