% Resolução de CSP com GNU Prolog
%
% Exemplo estrela (ver lista de exercicios)
%
% by Jomi

resolve :-
  nl, % nova lina

  % cria uma lista com todas as variáveis
  Todas = [A,B,C,D,E,F,G,H,I,J,K,L],

  % cria as variáveis e os domínios (valores de 1 a 12)
  fd_domain(Todas, 1, 12),

  % restrições
  fd_all_different(Todas), % todas devem ter valores diferentes

  A + C + F + H #= B + F + I + L,
  A + C + F + H #= B + C + D + E,
  A + C + F + H #= A + D + G + K,
  A + C + F + H #= E + G + J + L,
  A + C + F + H #= K + J + I + H,

  % resolve o CSP
  fd_labeling( Todas ),

  % imprime resultado
  write('          [A,B,C,D,E,F,G,H,I,J,K,L]'),nl,
  write('Solucao = '), write(Todas),nl.  
