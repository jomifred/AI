% Resolucao de CSP com GNU Prolog
%
% Exemplo Otimizacao na Compra de Adubo
%
% Para executar, digite em uma shell de comandos:
%   gprolog --query-goal "consult('adubo.pl'), resolve, halt"
%
% by Jomi

resolve :-
  nl, % nova lina

  % cria uma lista com todas as variaveis
  Todas = [A1, A2, A3],

  Qtd = 500,

  % cria as variaveis e os dominios (valores de 1 a Qtd)
  fd_domain(Todas, 0, Qtd),

  % restricoes

  % qtd de nitrato
  ((A1*8)  + (A2*4)  + (A3*3))  #>= (4*Qtd),

  % qtd de fosforo
  ((A1*15) + (A2*17) + (A3*14)) #>= (14*Qtd),

  % qtd de potassio
  ((A1*10) + (A2*10) + (A3*7))  #>= (8*Qtd),

  A1 + A2 + A3 #= Qtd,

  % custo
  C #= A1 * 15 + A2 * 10 + A3 * 7, 

  % otimiza o CSP
  fd_minimize(fd_labeling(Todas), C),
  %fd_labeling(Todas),

  % imprime resultado
  write('A1 = '), write(A1), nl,
  write('A2 = '), write(A2), nl,
  write('A3 = '), write(A3), nl,
  write('Custo='), write(C), nl.
