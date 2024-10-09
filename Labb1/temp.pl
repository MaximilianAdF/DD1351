append([],L,L).
append([H|T],L,[H|R]) :- append(T,L,R).
appendEl(X, [], [X]).
appendEl(X, [H | T], [H | Y]) :- appendEl(X, T, Y).
length([],0).
length([_|T],N) :- length(T,N1), N is N1+1.
nth(N,L,E) :- nth(1,N,L,E).
nth(N,N,[H|_],H).
nth(K,N,[_|T],H) :- K1 is K+1, nth(K1,N,T,H).
subset([], []).
subset([H|T], [H|R]) :- subset(T, R).
subset([_|T], R) :- subset(T, R).
select(X,[X|T],T).
select(X,[Y|T],[Y|R]) :- select(X,T,R).
member(X,L) :- select(X,L,_).
memberchk(X,L) :- select(X,L,_), !.

remove_duplicates([], []).  % Basfall: om listan är tom, är resultatet också tomt.

% remove_duplicates - huvudpredikatet som startar processen
remove_duplicates(L, R) :-
    remove_duplicates_seen(L, [], R).

% Basfall: När inputlistan är tom, är resultatet seen 
remove_duplicates_seen([], Seen, Seen).

% Om elementet H inte finns i seen, lägg till det med hjälp av append
remove_duplicates_seen([H|T], Seen, R) :-
    \+ member(H, Seen),                % Kontrollera att H inte redan finns i Seen
    append(Seen, [H], New),         % Lägg till H i seen med append
    remove_duplicates_seen(T, New, R).

% Om elementet redan finns i seen, hoppa över det
remove_duplicates_seen([H|T], Seen, R) :-
    member(H, Seen),                   % Om H redan finns i Seen, hoppa över det
    remove_duplicates_seen(T, Seen, R).

