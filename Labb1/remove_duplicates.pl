% Helper predicate to track seen elements.
remove_duplicates_helper([], _, []).  % No elements to process.

% Recursive case: Include H if it's not already seen.
remove_duplicates_helper([H|T], Seen, [H|R]) :-
    \+ member(H, Seen),   % H has not been seen yet.
    remove_duplicates_helper(T, [H|Seen], R).  % Add H to Seen and recurse.

% Recursive case: Skip H if it has been seen.
remove_duplicates_helper([H|T], Seen, R) :-
    member(H, Seen),      % H has been seen before.
    remove_duplicates_helper(T, Seen, R).  % Just recurse.



% Base case: An empty list results in an empty list.
remove_duplicates([], []).

% Main predicate to remove duplicates while maintaining order.
remove_duplicates(List, Result) :-
    remove_duplicates_helper(List, [], Result).  % Start with an empty Seen list.


% Man kan kalla predikatet för en funktion eftersom det tar ett argument (listan) och returnerar ett resultat (set)
% vilket påminer om hur funktioner agerar i andra programmeringspråk. Dessutom är predikatet deterministiskt, dvs.
% för samma input kommer det alltid ge samma output.