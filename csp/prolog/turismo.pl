
% 1 paris
pacote(1,temp,frio,7).
pacote(1,temp,quente,5).
% 2 moscou
pacote(2,temp,frio,9).
% 3 floripa
pacote(3,temp,quente,4).

% user prefs
user(temp,quente).

resolve :-
    % Vars: P eh o pacote
    %          OptTemp eh o peso da temperatura
    
    fd_domain(P,1,4),
    fd_domain(OptTemp,1,10),

    create_constraint(temp, P, OptTemp),  

    Op #= OptTemp, % adicionar outras variavies de peso....
    
    fd_maximize(fd_labeling([P,Op]),Op),
    nl, write('Pacote = '), write(P),nl.

% O prox. predicado cria coisas como a abaixo
% fd_relation([[1],[3]],[P]), % P tem que ser 1 ou 3
% P  #= 1 #==> Op #= 5, % se for 1, o custo é 5, ....
% P  #= 2 #==> Op #= 4,
% P  #= 3 #==> Op #= 2,
% P  #= 4 #==> Op #= 1,

create_constraint(Criteria, CSPVar, COPVar) :-
    user(Criteria,T),
    findall([P], pacote(P,Criteria,T,_), L),
    write('values for '),write(Criteria),write(': '),write(L),nl,
    fd_relation(L,[CSPVar]),
    findall(v(P,V), pacote(P,Criteria,T,V), LV),
    create_opt(LV, CSPVar, COPVar).

create_opt([],_,_).
create_opt([v(P,V)|R], CSPVar, COPVar) :-
        write('  peso '),write(P),write(': '),write(V),nl,
        CSPVar  #= P #==> COPVar #= V,
        create_opt(R,CSPVar, COPVar).
    

