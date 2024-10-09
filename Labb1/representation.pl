% Definiera en kant mellan två noder
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(d, e).

% väg(A, B, Path) - Hitta en väg från nod A till nod B utan att passera en nod mer än en gång.
% Path representerar vägen som en lista av noder.
path(A, B, Path) :-
    path(A, B, [A], Path).  % Initiera med A som besökt nod.

% path(A, B, Visited, Path) - Hjälpredikat för att hitta vägen.
% Visited är en lista över redan besökta noder för att undvika loopar.
path(A, B, Visited, Path) :-
    edge(A, B),             % Om det finns en kant från A till B.
    reverse([B | Visited], Path).  % Bygg hela vägen och vänd den.

% Om A inte är direkt ansluten till B, leta efter en mellanliggande nod.
path(A, B, Visited, Path) :-
    edge(A, C),             % Det finns en kant från A till C.
    C \= B,                 % C är inte samma som B.
    \+ member(C, Visited),  % C har inte besökts än.
    path(C, B, [C | Visited], Path).  % Fortsätt sökningen från C till B.
