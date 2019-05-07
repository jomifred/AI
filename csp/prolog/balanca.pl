% Exemplo Balanca (ver lista de exercicios)
%
% by Jomi

resolve :-
  nl, % nova lina

  Todas = [T,Q,C,X],
  fd_domain(Todas, 1, 12),

  T + 3*Q #= C + T,
  C + 2*Q #= X * Q,

  fd_labeling( Todas ),

  write(Todas),
  write('Solucao = '), write(X),nl.
