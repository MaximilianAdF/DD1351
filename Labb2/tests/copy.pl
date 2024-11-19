
% Läser in filen
verify(InputFileName) :-
    see(InputFileName),
    read(Prems), read(Goal), read(Proof),
    seen,
    valid_proof(Prems, Goal, Proof).

% Main predikatet
valid_proof(Prems, Goal, Proof) :-
    last(Proof, [_, Goal, _]), % Kollar om sista raden i Proof är Goal
    verify_proof(Prems, Proof, []).

% Basfall
verify_proof(_, [], _). 

% Rekurtion uppifrån och ned
verify_proof(Prems, [Row | Rest], PrevLines) :-
    check_line(Prems, Row , PrevLines), % Kollar om Row är rätt
    append(PrevLines, [Row], NewLines), % Om ja läggtill
    verify_proof(Prems, Rest , NewLines). % Fortsätter till nästa rad

% Box
verify_box(Start, End, PrevLines) :-
    member([Start | Rest], PrevLines),
    last(Rest, End).

% Om box är tomm
verify_box(Row, Row, PrevLines) :-
    member([Row], PrevLines).



%% Alla olika Propositioner.

% Premiss
check_line(Prems, [_, Formula, Premiss], _) :-
    member(Formula, Prems).

% assumption
check_line(Prems, Row, PrevLines) :-
    Row = [[_, _, assumption] | RestBox],
    append(PrevLines, Row, NewLines),
    verify_proof(Prems, RestBox, NewLines).

% copy
check_line(_, [_, X, copy(RowNR)], PrevLines) :-
    member([RowNR, X, _], PrevLines).

% andint
check_line(_, [_, and(X, Y), andint(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, X, _], PrevLines),
    member([RowNR2, Y, _], PrevLines).

% andel1
check_line(_, [_, X, andel1(RowNR)], PrevLines) :-
    member([RowNR, and(X, _), _], PrevLines).

% andel2
check_line(_, [_, Y, andel2(RowNR)], PrevLines) :-
    member([RowNR, and(_, Y), _], PrevLines).

% orint1
check_line(_, [_, or(X, _), orint1(RowNR)], PrevLines) :-
    member([RowNR, X, _], PrevLines).

% orint2
check_line(_, [_, or(_, Y), orint2(RowNR)], PrevLines) :-
    member([RowNR, Y, _], PrevLines).

% orel
check_line(_, [_, Conclusion, orel(RowNR1, RowNR2, RowNR3, RowNR4, RowNR5)], PrevLines) :-
    member([RowNR1, or(X, Y), _], PrevLines),
    verify_box([RowNR2, X, assumption],
    [RowNR3, Conclusion, _], PrevLines),
    verify_box([RowNR4, Y, assumption],
    [RowNR5, Conclusion, _], PrevLines).

% impint
check_line(_, [_, imp(X, Y), impint(RowNR1, RowNR2)], PrevLines) :-
    verify_box([RowNR1, X, assumption],
    [RowNR2, Y, _], PrevLines).

% impel
check_line(_, [_, Y, impel(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, X, _], PrevLines),
    member([RowNR2, imp(X, Y), _], PrevLines).

% negint
check_line(_, [_, neg(X), negint(RowNR1, RowNR2)], PrevLines) :-
    verify_box([RowNR1, X, assumption],
    [RowNR2, cont, _], PrevLines).

% negel
check_line(_, [_, cont, negel(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, X, _], PrevLines),
    member([RowNR2, neg(X), _], PrevLines).

% contel
check_line(_, [_, _, contel(RowNR)], PrevLines) :-
    member([RowNR, cont, _], PrevLines).

% negnegint
check_line(_, [_, neg(neg(X)), negnegint(RowNR)], PrevLines) :-
    member([RowNR, X, _], PrevLines).

% negnegel
check_line(_, [_, X, negnegel(RowNR)], PrevLines) :-
    member([RowNR, neg(neg(X)), _], PrevLines).

% mt
check_line(_, [_, neg(X), mt(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, imp(X, Y), _], PrevLines),
    member([RowNR2, neg(Y), _], PrevLines).

% pbc
check_line(_, [_, X, pbc(RowNR1, RowNR2)], PrevLines) :-
    verify_box([RowNR1, neg(X), assumption],
    [RowNR2, cont, _], PrevLines).

% lem
check_line(_, [_, or(X, neg(X)), lem], _).



