% partstring(List, F, L) - Generate the subset F of length L from List.
partstring(List, F, L) :-
    length(F, L),             % Ensure F has length L.
    substring(List, F, L).

% substring(List, Sub, L) - Find a subset Sub of length L from List.
substring(List, Sub, L) :-
    L > 0,                    % Ensure L is positive.
    append(_, Rest, List),    % Split List into two parts, ignoring the first part.
    append(Sub, _, Rest),     % Split the Rest into Sub and the remaining part.
    length(Sub, L).           % Ensure Sub has length L.
