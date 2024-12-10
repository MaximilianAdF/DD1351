verify(Input) :-
        see(Input), 
        read(V), read(L), read(S), read(F), 
        seen, 
        check(V, L, S, [], F), !.

%% check_all_states anropar check med alla tillstånd i första argumentet.
% Faktum
check_all_states(_, _, [], _, _).

% Hanterar fall när U inte är tom.
check_all_states(V, L, [H|T], U, X) :-
        check(V, L, H, U, X),
        check_all_states(V, L, T, [H|U], X).

% Hanterar fall när U är tom.
check_all_states(V, L, [H|T], [], X) :-
        check(V, L, H, [], X),
        check_all_states(V, L, T, [], X).

%% check_existing ger true om ett anrop till check ger true.
% Faktum
check_existing(_, _, [], _, _) :- fail.

% Hanterar fall när U inte är tom.
check_existing(V, L, [H|T], U, X) :-
        check(V, L, H, U, X);
        check_existing(V, L, T, [H|U], X).
        
% Hanterar fall när U är tom.
check_existing(V, L, [H|T], [], X) :-
        check(V, L, H, [], X);
        check_existing(V, L, T, [], X).



%% Literals
% p
check(_, L, S, [], X) :- 
        member([S, Ls], L),
        member(X, Ls).

% neg p
check(_, L, S, [], neg(X)) :-
        member([S, Ls], L),
        \+member(X, Ls).




% And
check(V, L, S, [], and(F,G)) :- 
        check(V, L, S, [], F),
        check(V, L, S, [], G).

% Or
check(V, L, S, [], or(F,G)) :- 
        check(V, L, S, [], F);
        check(V, L, S, [], G).


% AX
check(V, L, S, [], ax(F)) :-
        member([S, Ls], V),
        check_all_states(V, L, Ls, [], F).

% EX
check(V, L, S, [], ex(F)) :-
        member([S, Ls], V),
        check_existing(V, L, Ls, [], F).

% AG1, S is in U
check(_, _, S, U, ag(_)) :-
        member(S, U).

% AG2, S is NOT in U
check(V, L, S, U, ag(F)) :-
        \+ member(S, U),
        check(V, L, S, [], F),
        member([S, Ls], V),
        check_all_states(V, L, Ls, [S|U], ag(F)).

% EG1
check(_, _, S, U, eg(_)) :-
        member(S, U).

% EG2
check(V, L, S, U, eg(F)) :- 
        \+ member(S, U),
        check(V, L, S, [], F),
        member([S, Ls], V),
        check_existing(V, L, Ls, [S|U], eg(F)).

% % EF1
check(V, L, S, U, ef(F)) :- 
        \+ member(S, U),
        check(V, L, S, [], F).

% EF2
check(V, L, S, U, ef(F)) :- 
        \+ member(S, U),
        member([S, Ls], V),
        check_existing(V, L, Ls, [S|U], ef(F)).

% AF1
check(V, L, S, U, af(F)) :-
        \+ member(S, U),
        check(V, L, S, [], F).

% AF2
check(V, L, S, U, af(F)) :- 
        \+ member(S, U),
        member([S, Ls], V),
        check_all_states(V, L, Ls, [S|U], af(F)).



