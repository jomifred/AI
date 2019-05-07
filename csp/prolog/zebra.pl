% Resolution of the Zebra problem
% using GNU Prolog
%
% by Jomi (based on an ECLIPSE example)
%
%
% Lewis Carrol's classical puzzle with five houses and a zebra:
% 
% Five men with different nationalities live in the first five houses
% of a street.  They practise five distinct professions, and each of
% them has a favourite animal and a favourite drink, all of them
% different.  The five houses are painted in different colours.
% 
% The Englishman lives in a red house.
% The Spaniard owns a dog.
% The Japanese is a painter.
% The Italian drinks tea.
% The Norwegian lives in the first house on the left.
% The owner of the green house drinks coffee.
% The green house is on the right of the white one.
% The sculptor breeds snails.
% The diplomat lives in the yellow house.
% Milk is drunk in the middle house.
% The Norwegian's house is next to the blue one.
% The violinist drinks fruit juice.
% The fox is in a house next to that of the doctor.
% The horse is in a house next to that of the diplomat.
% 
% Who owns a Zebra, and who drinks water?
% 

% Defines the queens domain and contraints
%

zebra(ZebraNat, WaterNat) :-
    % we use 5 lists of 5 variables each
	Nat = [English, Spaniard, Japanese, Italian, Norwegian],
	Color = [Red, Green, White, Yellow, Blue],
	Profession = [Painter, Sculptor, Diplomat, Violinist, Doctor],
	Pet = [Dog, Snails, Fox, Horse, Zebra],
	Drink = [Tea, Coffee, Milk, Juice, Water],

    % domains: all the variables range over house numbers 1 to 5
	fd_domain(Nat,1,5),
	fd_domain(Color,1,5),
	fd_domain(Profession,1,5),
	fd_domain(Pet,1,5),
	fd_domain(Drink,1,5),

    % the values in each list are exclusive
	fd_all_different(Nat),
	fd_all_different(Color),
	fd_all_different(Profession),
	fd_all_different(Pet),
	fd_all_different(Drink),

    % and here follow the actual constraints
	English = Red,
	Spaniard = Dog,
	Japanese = Painter,
	Italian = Tea,
	Norwegian = 1,
	Green = Coffee,
	Green #= White + 1,
	Sculptor = Snails,
	Diplomat = Yellow,
	Milk = 3,
	fd_domain(Dist1,-1,1), Dist1 #= Norwegian - Blue, 
	Violinist = Juice,
	fd_domain(Dist2,-1,1), Dist2 #= Fox - Doctor, 
	fd_domain(Dist3,-1,1), Dist3 #= Horse - Diplomat, 

    % put all the variables in a single list
	append(Nat, Color, L1),
	append(L1, Profession, L2),
	append(L2, Pet, L3),
	append(L3, Drink, List), 

    % search: label all variables with values
	fd_labeling(List),
	
    % print the answers: we need to do some decoding
	NatNames = [English-english, Spaniard-spaniard, Japanese-japanese,
		    Italian-italian, Norwegian-norwegian],
	memberchk(Zebra-ZebraNat, NatNames),
	memberchk(Water-WaterNat, NatNames).
	
run :-
        zebra(ZebraNat, WaterNat),
	write('The '),write(ZebraNat),write(' owns the zebra'),nl,
	write('The '),write(WaterNat),write(' drinks water'),nl.

:- initialization(run).
