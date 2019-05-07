% Resolution of the Zebra problem
% using GNU Prolog and CSP
%
% by Jomi 
%
% (From Russel & Norvig. Artificial Inteligence. 2 ed., chap 5)
%
% In five houses, each with a different color, live 5 persons 
% of different nationalities, each of whom prefer a different 
% brand of cigarette, a different drink, and a different pet. 
% Given the following facts, the question to answer is  
%
% Where does the zebra live, and in which house do they drink water?  
%
% The Englishman lives in the red house. 
% The Spaniard owns the dog. 
% The Norwegian lives in the first house on the left. 
% Kools are smoked in the yellow house. 
% The man who smokes Chesterfields lives in the house next to the man with the fox. 
% The Norwegian lives next to the blue house. 
% The Winston smoker owns snails. 
% The Lucky Strike smoker drinks orange juice. 
% The Ukrainian drinks tea. 
% The Japanese smokes Parliaments. 
% Kools are smoked in the house next to the house where the horse is kept. 
% Coffee is drunk in the green house. 
% The Green house is immediately to the right (your right) of the ivory house. 
% Milk is drunk in the middle house.
%

zebra(ZebraNat, WaterNat) :-
    % we use 5 lists of 5 variables each
	Nat = [English, Spaniard, Japanese, Ukrainian, Norwegian],
	Color = [Red, Green, White, Yellow, Blue],
	Cigarrete = [Kool, Chesterfields, Winston, LuckyStrike, Parliaments],
	Pet = [Dog, Snails, Fox, Horse, Zebra],
	Drink = [Tea, Coffee, Milk, Juice, Water],

    % domains: all the variables range over house numbers 1 to 5
	fd_domain(Nat,1,5),
	fd_domain(Color,1,5),
	fd_domain(Cigarrete,1,5),
	fd_domain(Pet,1,5),
	fd_domain(Drink,1,5),

    % the values in each list are exclusive
	fd_all_different(Nat),
	fd_all_different(Color),
	fd_all_different(Cigarrete),
	fd_all_different(Pet),
	fd_all_different(Drink),

    % and here follow the actual constraints
	English = Red,
	Spaniard = Dog,
	Norwegian = 1,
	Kool = Yellow, 
	dist(Chesterfields, Fox) #= 1,
	dist(Norwegian,Blue) #= 1,
	Winston = Snails,
	LuckyStrike = Juice,
	Ukrainian = Tea,
	Japanese = Parliaments,
	dist(Kool,Horse) #= 1,
	Coffee = Green,
	Green #= White + 1,
	Milk = 3,
	

    % put all the variables in a single list
	append(Nat, Color, L1),
	append(L1, Cigarrete, L2),
	append(L2, Pet, L3),
	append(L3, Drink, List), 

    % search: label all variables with values
	fd_labeling(List),
	
    % print the answers: we need to do some decoding
	NatNames = [English-english, Spaniard-spaniard, Japanese-japanese,
		    Ukrainian-ukrainian, Norwegian-norwegian],
	memberchk(Zebra-ZebraNat, NatNames),
	memberchk(Water-WaterNat, NatNames).
	
run :-
        zebra(ZebraNat, WaterNat),
	write('The '),write(ZebraNat),write(' owns the zebra'),nl,
	write('The '),write(WaterNat),write(' drinks water'),nl.

:- initialization(run).
