% Resolução do problema do peixe
% usando GNU Prolog and CSP
%
% by Jomi
%

%  Imagine 5 casas de 5 diferentes cores. Em cada casa mora uma
%  pessoa de uma nacionalidade diferente, sendo que esses 5
%  proprietários bebem diferentes bebidas, fumam diferentes tipos
%  de cigarro e têm um certo animal de estimação. Observa-se que nenhum
%  deles têm o mesmo animal, nem fumam o mesmo cigarro e nem bebem a
%  mesma bebida.  Sabe-se que:
%
%	O inglês vive na casa vermelha.
%	O sueco tem cachorros como animais de estimação.
%	O dinamarquês bebe chá.
%	A casa verde fica à esquerda da casa branca.
%	O dono da casa verde bebe café.
%	A pessoa que fuma Pall Mall cria pássaros.
%	O dono da casa amarela fuma Dunhill.
%	O homem que vive na casa do centro bebe leite.
%	O norueguês vive na primeira casa.
%	O homem que fuma Blends vive ao lado do que tem gatos.
%	O homem que cria cavalos vive ao lado do que fuma Dunhill.
%	O homem que fuma Bluemaster bebe cerveja.
%	O alemão fuma Prince.
%	O norueguês vive ao lado da casa azul.
%	O homem que fuma Blend é vizinho do que bebe água.
%
% A questão é: quem tem o peixe?

peixe :-
    % criação de 5 listas para as cinco variávies
	Nat = [Ingles, Alemao, Sueco, Dinamarques, Noruegues],
	Color = [Vermelho, Verde, Branco, Amarelo, Azul],
	Cigarrete = [Bluemaster, Palm, Dunhill, Blends, Prince],
	Pet = [Gato, Cachorro, Peixe, Cavalo, Passaro],
	Drink = [Cha, Cafe, Agua, Leite, Cerveja],

    % domínios: todas as variáveis tem valores de 1 a 5 (o nro da casa)
	fd_domain(Nat,1,5),
	fd_domain(Color,1,5),
	fd_domain(Cigarrete,1,5),
	fd_domain(Pet,1,5),
	fd_domain(Drink,1,5),

    % os valores não podem se repedir em cada conjunto
	fd_all_different(Nat),
	fd_all_different(Color),
	fd_all_different(Cigarrete),
	fd_all_different(Pet),
	fd_all_different(Drink),

    % as outras restrições (do enunciado)
	Ingles = Vermelho,
	Sueco = Cachorro,
	Dinamarques = Cha,
	Verde + 1 #= Branco,
	Verde = Cafe,
	Palm = Passaro,
	Amarelo = Dunhill,
 	Leite = 3,
	Noruegues #= 1,
	dist(Blends, Gato) #= 1,
	dist(Cavalo, Dunhill) #= 1,
	Bluemaster = Cerveja,
	Alemao = Prince,
	dist(Noruegues, Azul) #= 1,
	dist(Blends, Agua) #= 1,


    % cria uma lista com todas as variáveis
	append(Nat, Color, L1),
	append(L1, Cigarrete, L2),
	append(L2, Pet, L3),
	append(L3, Drink, List),

    % resolve o problema
	fd_labeling(List),


    % imprime algumas respostas
	NatNames = [Ingles-ingles, Dinamarques-dinamarques, Sueco-sueco,
		    Noruegues-noruegues, Alemao-alemao],
	memberchk(Peixe-NatPeixe, NatNames),
	write('Nacionalidade do dono do peixe é '),write(NatPeixe),nl,
	write('Casa do café '),write(Cafe),nl,
	write('--------------------------'),nl,
	write('Casa do verde '),write(Verde),nl,
	write('Casa do branco '),write(Branco),nl,
	write('--------------------------'),nl,
	write('Casa do alemão '), write(Alemao),nl,
	write('Casa do ingles '), write(Ingles),nl,
	write('Casa do dinamarques '), write(Dinamarques),nl,
	write('Casa do sueco '), write(Sueco),nl,
	write('Casa do noruegues '), write(Noruegues),nl,
	write('--------------------------'),nl,
	write('Casa do peixe '),write(Peixe),nl,
	write('Casa do gato '), write(Gato),nl,
	write('Casa do cachorro '), write(Cachorro),nl.

:- initialization(peixe).
