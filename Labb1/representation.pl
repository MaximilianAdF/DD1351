% Lista över kanter mellan noder
edges([
    (a, b),
    (a, c),
    (b, d),
    (c, d),
    (d, c),
    (d, e)
]).

% väg(A, B, Path) - Hitta en väg från nod A till nod B utan att passera en nod mer än en gång.
% Path representerar vägen som en lista av noder.
path(A, B, Path) :-
    edges(Edges),
    path(A, B, [A], RevPath, Edges),  % Initiera med A som besökt nod och skicka med listan av kanter.
    reverse_list(RevPath, Path).      % Vänd listan för att få rätt ordning.

% path(A, B, Visited, Path, Edges) - Hjälpredikat för att hitta vägen.
% Visited är en lista över redan besökta noder för att undvika loopar / att man går över samma nod flera ggr.
% Edges är listan över alla kanter som finns i grafen.
path(A, B, Visited, [B | Visited], Edges) :-
    member((A, B), Edges).             % Om det finns en kant från A till B.

% Om A inte är direkt ansluten till B, leta efter en mellanliggande nod.
path(A, B, Visited, Path, Edges) :-
    member((A, C), Edges),             % Det finns en kant från A till C.
    C \= B,                 % C är inte samma som B.
    \+ member(C, Visited),  % C har inte besökts än.
    path(C, B, [C | Visited], Path, Edges).  % Fortsätt sökningen från C till B.

% reverse_list(List, Reversed) - Hjälpredikat för att vända en lista.
reverse_list(List, Reversed) :-
    reverse_list(List, [], Reversed).

reverse_list([], Acc, Acc).
reverse_list([H | T], Acc, Reversed) :-
    reverse_list(T, [H | Acc], Reversed).
