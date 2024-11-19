
% Reads File
verify(InputFileName) :-
    see(InputFileName),
    read(Prems), read(Goal), read(Proof),
    seen,
    valid_proof(Prems, Goal, Proof).

% Main predicate to verify the entire proof
valid_proof(Prems, Goal, Proof) :-
    last(Proof, [_, Goal, _]), % check that the last line in proof is Goal
    verify_proof(Prems, Proof, []).

% Base case
verify_proof(_, [], _). % the second argument is proof (if it is empty, we are done)

% Recursive case: Verify top down
verify_proof(Prems, [Row | Rest], PrevLines) :-
    check_line(Prems, Row , PrevLines), % line verification (check each line)
    append(PrevLines, [Row], NewLines), % if we are here, previous line is valid
    verify_proof(Prems, Rest , NewLines). % continue verifying the rest of the proof

% Box handling
verify_box(Start, End, PrevLines) :-
    member([Start | Rest], PrevLines),
    last(Rest, End).

% assumption box only covers one line
verify_box(Row, Row, PrevLines) :-
    member([Row], PrevLines).



%% All Diffrent operations.

% premise
check_line(Prems, [_, Formula, premise], _) :-
    member(Formula, Prems).

% assumption
check_line(Prems, Row, PrevLines) :-
    Row = [[_, _, assumption] | RestBox],
    append(PrevLines, Row, NewLines),
    verify_proof(Prems, RestBox, NewLines).

% copy(x)
check_line(_, [_, X, copy(RowNR)], PrevLines) :-
    member([RowNR, X, _], PrevLines).

% andint(x, y)
check_line(_, [_, and(X, Y), andint(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, X, _], PrevLines),
    member([RowNR2, Y, _], PrevLines).

% andel1(x)
check_line(_, [_, X, andel1(RowNR)], PrevLines) :-
    member([RowNR, and(X, _), _], PrevLines).

% andel2(x)
check_line(_, [_, Y, andel2(RowNR)], PrevLines) :-
    member([RowNR, and(_, Y), _], PrevLines).

% orint1(x)
check_line(_, [_, or(X, _), orint1(RowNR)], PrevLines) :-
    member([RowNR, X, _], PrevLines).

% orint2(x)
check_line(_, [_, or(_, Y), orint2(RowNR)], PrevLines) :-
    member([RowNR, Y, _], PrevLines).

% orel(x, y, z, u, v)
check_line(_, [_, Conclusion, orel(RowNR1, RowNR2, RowNR3, RowNR4, RowNR5)], PrevLines) :-
    member([RowNR1, or(X, Y), _], PrevLines),
    verify_box([RowNR2, X, assumption],
    [RowNR3, Conclusion, _], PrevLines),
    verify_box([RowNR4, Y, assumption],
    [RowNR5, Conclusion, _], PrevLines).

% impint(x, y)
check_line(_, [_, imp(X, Y), impint(RowNR1, RowNR2)], PrevLines) :-
    verify_box([RowNR1, X, assumption],
    [RowNR2, Y, _], PrevLines).

% impel(x, y)
check_line(_, [_, Y, impel(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, X, _], PrevLines),
    member([RowNR2, imp(X, Y), _], PrevLines).

% negint(x, y)
check_line(_, [_, neg(X), negint(RowNR1, RowNR2)], PrevLines) :-
    verify_box([RowNR1, X, assumption],
    [RowNR2, cont, _], PrevLines).

% negel(x, y)
check_line(_, [_, cont, negel(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, X, _], PrevLines),
    member([RowNR2, neg(X), _], PrevLines).

% contel(x)
check_line(_, [_, _, contel(RowNR)], PrevLines) :-
    member([RowNR, cont, _], PrevLines).

% negnegint(x)
check_line(_, [_, neg(neg(X)), negnegint(RowNR)], PrevLines) :-
    member([RowNR, X, _], PrevLines).

% negnegel(x)
check_line(_, [_, X, negnegel(RowNR)], PrevLines) :-
    member([RowNR, neg(neg(X)), _], PrevLines).

% mt(x, y)
check_line(_, [_, neg(X), mt(RowNR1, RowNR2)], PrevLines) :-
    member([RowNR1, imp(X, Y), _], PrevLines),
    member([RowNR2, neg(Y), _], PrevLines).

% pbc(x, y)
check_line(_, [_, X, pbc(RowNR1, RowNR2)], PrevLines) :-
    verify_box([RowNR1, neg(X), assumption],
    [RowNR2, cont, _], PrevLines).

% lem
check_line(_, [_, or(X, neg(X)), lem], _).



