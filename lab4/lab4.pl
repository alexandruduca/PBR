language(armeana).
language(persana).
language(greaca).
language(aramaica).

speaks(_,Y,Z) :- language(Y), language(Z).

languages(Salal, Atar, Eber, Zaman) :-
    speaks(Salal,A,B),A\=persana,B\=persana,((A\=aramaica,A\=armeana,A\=aramaica,A\=armeana);(A=aramaica,B\=armeana);(A\=aramaica,B=armeana)), %Salal nu stie persana, poate vorbi fie armeana, fie aramaica, dar niciodata ambele in acelasi timp
    speaks(Atar,C,D),((C\=aramaica,C\=armeana,D\=aramaica,D\=armeana);(C=aramaica,D\=armeana);(C\=aramaica,D=armeana)),                        %Atar poate vorbi fie armeana, fie aramaica, dar niciodata ambele in acelasi timp
    speaks(Eber,E,F),E=aramaica,F\=armeana,                                                                                                    %Eber stie aramaica, dar nu se poate aramaica si armeana in acelasi timp
    speaks(Zaman,G,H),((G\=aramaica,G\=armeana,H\=aramaica,H\=armeana);(G=aramaica,H\=armeana);(G\=aramaica,H=armeana)),                       %Zaman poate vorbi fie armeana, fie aramaica, dar niciodata ambele in acelasi timp
    ((A==C;A==D;B==C;B==D);(A==E;A==F;B==E;B==F)),                                                                                             %Salal este traducator pentru Atar si Eber, deci are o limba in comun cu unul din cei doi
    (F==G;F==H),                                                                                                                               %Eber si Zaman au o limba comuna, diferita de aramaica
    A\==B,C\==D,E\==F,G\==H, 																												   %cele doua limbi vorbite de fiecare sunt diferite
    format('~w cunoaste ~w si ~w.', ['Salal',A,B]),
    format('~w cunoaste ~w si ~w.', ['Atar',C,D]),
    format('~w cunoaste ~w si ~w.', ['Eber',E,F]),
    format('~w cunoaste ~w si ~w.', ['Zaman',G,H]).