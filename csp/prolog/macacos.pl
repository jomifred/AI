% run with
%    gprolog --query-goal "consult(macacos), resolve, halt"
%

resolve :-
  Todas = [Ze, Ch, Tn, Ga, Bn, Pl, Cg, Md, Sr],
  fd_domain(Todas,1,3),

  fd_all_different([Ze, Ch, Tn]),
  fd_all_different([Ga, Bn, Pl]),
  fd_all_different([Cg, Md, Sr]),

  Ze #= 1,
  Ze #\= Ga,
  Ga #= Sr,
  Ze #\= Sr,

  Tn #\= Bn,
  Sr #\= Tn,
  Sr #\= Bn,

  Ch #\= Pl,
  Ch #\= Cg,
  Pl #\= Cg,
  
  fd_labeling(Todas),
  
  write('nomes        [Ze, Ch, Tn] = '), write([Ze, Ch, Tn]), nl,
  write('sobre nomes  [Ga, Bn, Pl] = '), write([Ga, Bn, Pl]), nl,
  write('deficiencias [Cg, Md, Sr] = '), write([Cg, Md, Sr]), nl,
  nl.
