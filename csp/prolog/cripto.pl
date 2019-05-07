% Resolução de CSP com GNU Prolog
%
% Cripto aritmética
%
% Para executar, digite em uma shell de comandos:
%   gprolog --query-goal "consult('cripto'), resolve, halt"
%
% by Jomi

resolve :-
  LS = [C,R,O,S,A,D,N,G,E],
  CS = [C1,C2,C2,C4],
  append(LS,CS,All),
  fd_domain(All, 0, 9),
  fd_all_different(LS),

  S + S #= R + (C1 * 10),
  S + D + C1 #= E + (C2 * 10),
  O + A + C2 #= G + (C3 * 10),
  R + O + C3 #= N + (C4 * 10),
  C + R + C4 #= A + (D * 10),

  fd_labeling( All ),
  write('[C,R,O,S,A,D,N,G,E]'),nl,
  write(LS),nl.
