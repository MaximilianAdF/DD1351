% partstring(List, F, L) - Generate the subset F of length L from List.
partstring(List, F, L) :-
    substring(List, F),       % Get all consecutive substrings.
    length(F, L),             % Ensure F has length L.
    L > 0.                    % Ensure L is positive.

% substring(List, Sub) - Find all consecutive substrings of List.
substring(List, Sub) :-
    append(Sub, _, List).     % Split List into Sub and the remaining part.
substring([_|Tail], Sub) :-
    substring(Tail, Sub).     % Recursively find substrings in the tail.
