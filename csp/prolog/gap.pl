% GAP problem with 3 agents and 5 tasks
%
% Data:
% ag1 has 3 resources
%   ag1 -> t1: 0.9, 1 
%         to perform t1, agent 1 spend 1 resource 
%         and its capability for the task is 0.9 
%   ag1 -> t2: 0.8, 1
%   ag1 -> t3: 1.0, 2
%   ag1 -> t4: 0.0, 0 (it is unable to perform t4)
%   ag1 -> t5: 0.0, 0
%
% ag2 has 4 resources
%   ag2 -> t1: 0.3, 1 
%   ag2 -> t2: 0.8, 1
%   ag2 -> t3: 0.0, 0
%   ag2 -> t4: 0.7, 2
%   ag2 -> t5: 0.6, 2
%
% ag3 has 2 resources
%   ag3 -> t1: 0.0, 0 
%   ag3 -> t2: 0.2, 1
%   ag3 -> t3: 0.9, 3
%   ag3 -> t4: 0.8, 1
%   ag3 -> t5: 0.7, 1
%
%
% to run this COP in GNU-Prolog: 
%      gprolog --query-goal "consult(gap), halt"
%
% by Jomi (2006)
%

resolve :-

  % Allocation matrix (all vars are either 0 or 1)
  % A23 represents the allocation of task 3 to agent 2
  Vars = [A11,A12,A13,A14,A15,
          A21,A22,A23,A24,A25,
          A31,A32,A33,A34,A35],
  fd_domain(Vars,0,1),

  % constraints to ensure that
  % the sum of tasks's resources allocated to an agent 
  % is less than its own resources

  % A13 * 2 means that the allocation of task 3 
  % to agent 1 consumes 2 resources
  Ag1C #= A11 + A12 + A13*2 + A14 + A15,
  % agent1 has 3 resources
  Ag1C #=< 3,

  Ag2C #= A21 + A22 + A23 + A24*2 + A25*2,
  Ag2C #=< 4,

  Ag3C #= A31 + A32 + A33*3 + A34 + A35,
  Ag3C #=< 2,

  TotC #= Ag1C + Ag2C + Ag3C,

  % all task must be allocated
  fd_exactly(1,[A11,A21,A31],1), % one of the 3 vars should be 1
  fd_exactly(1,[A12,A22,A32],1),
  fd_exactly(1,[A13,A23,A33],1),
  fd_exactly(1,[A14,A24,A34],1),
  fd_exactly(1,[A15,A25,A35],1),

  % optimization: the allocation of a task to an agent
  % should consider the agent capability for the task
  %
  % A12*8 means that the capability of agent 1 to
  % perform task 2 is 0.8. The capability values in the formulae 
  % are * 10, since GNU-Prolog works only with integers.

  Ag1K #= A11*9 + A12*8 + A13*10 + A14*0 + A15*0,

  Ag2K #= A21*3 + A22*8 + A23*0  + A24*9 + A25*6, % try A24*7

  Ag3K #= A31*0 + A32*2 + A33*9  + A34*8 + A35*7,

  TotK #= Ag1K + Ag2K + Ag3K,
  
  fd_maximize(fd_labeling(Vars),TotK),

  nl,
  write('Ag1 allocations   = '),write([A11,A12,A13,A14,A15]),nl,
  write('Ag2 allocations   = '),write([A21,A22,A23,A24,A25]),nl,
  write('Ag3 allocations   = '),write([A31,A32,A33,A34,A35]),nl,
  write('Consumed resources= '), write(TotC),nl,
  write('Total reward      = '), write(TotK),nl.

:- initialization(resolve).

