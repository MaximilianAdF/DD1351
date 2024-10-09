% partstring(List, F, L) - Generate the subset F of length L from List.
partstring(List, F, L) :-
    length(List, MaxL),
    between(1, MaxL, L),    % Iterate over lengths from 1 to MaxL.
    substring(List, F, L).

% substring(List, Sub, L) - Find a subset Sub of length L from List.
substring(List, Sub, L) :-
    append(_, Rest, List),  % Split List into two parts, ignoring the first part.
    append(Sub, _, Rest),   % Split the Rest into Sub and the remaining part.
    length(Sub, L).         % Ensure Sub has length L.
